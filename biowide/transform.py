# Converts the raw data into CSVs formatted to the new model
# This uses idiomatic code deliberately, favouring readability over performance (e.g. dataframe iterating)
import pandas as pd
from pathlib import Path
from model import *
import datetime
import numbers

# source data
matrix = pd.read_csv("./data/EDNA_fungi_annotated_community_matrix.txt",sep='\t',header=0)
metadata = pd.read_csv("./data/biowide_metadata.txt",sep='\t',header=0, decimal=',')
plots = pd.read_csv("./data/plots.txt",sep='\t',header=0)
visits = pd.read_csv("./data/eDNA_Soil_Sampling_dates.txt",sep='\t',header=0)

# matrix headers that aren't site IDs
nonSiteColumns = {"_id", "qseqid", "pident", "taxpath", "kingdom", "phylum", "class", "order",
                  "family", "genus", "species", "accession", "SH", "dataset",  "sequence"}

# outputs
location = []
event = []
entityRelationship = []
entity = []
entityEvent = []
materialEntity = []
digitalEntity = []
geneticSequence = []
sequenceTaxon = []
taxon = []
eventAssertion = []
geneticSequenceAssertions = []

# Utility to provide auto incremental keys in favour of long compound keys
keys = Keys()

# events for the site visits, and locations for the sites
visitDates = {} # maintain a dictionary lookup for later
for index, visit in visits.iterrows():
    siteID = visit["NewSiteID"]
    originalDate = visit["eventDate"]
    date = datetime.datetime.strptime(originalDate, "%d/%m/%Y").strftime("%Y-%m-%d")
    visitDates[siteID] = date
    event.append(Event(keys.key(siteID + ":visit"), siteID, "Collect", None, None, date, None))
    location.append(Location(siteID))

# add the observations for the site visit event
metadataKeys = [elem for elem in list(metadata) if not elem == "site_id"]
for index in range(len(metadata)):
    siteID = metadata["site_id"].loc[index]
    eventID = keys.key(siteID + ":visit")
    for key in metadataKeys:
        val = metadata[key].loc[index]
        assertionID = keys.key(siteID + ":assertion:" + key)
        if is_num(val):
            # we have no units in the file
            eventAssertion.append(EventAssertion(assertionID, eventID, visitDates[siteID], key, None, val, None))
        else:
            eventAssertion.append(EventAssertion(assertionID, eventID, visitDates[siteID], key, val, None, None))

# compute total reads per site to allow for relative abundance measures later
siteIDs = [elem for elem in list(matrix) if not elem in nonSiteColumns]
readsPerSite = matrix[siteIDs].transpose().sum(axis=1)

# Scan all sites and infer the material collected adding relationships
for siteID in siteIDs:
    blendedSoil  = keys.key(siteID + ":ms1")
    sampledSoil  = keys.key(siteID + ":ms2")
    dna  = keys.key(siteID + ":ms3")

    entity.append(Entity(blendedSoil, "material", None))
    entity.append(Entity(sampledSoil, "material", None))
    entity.append(Entity(dna, "material", None))
    materialEntity.append(MaterialEntity(blendedSoil, "soil"))
    materialEntity.append(MaterialEntity(sampledSoil, "soil"))
    materialEntity.append(MaterialEntity(dna, "DNA"))

    # add bidirectional relationships
    entityRelationship.append(EntityRelationship(keys.key(siteID + ":er1"), None, blendedSoil, "sourceOf", sampledSoil, None))
    entityRelationship.append(EntityRelationship(keys.key(siteID + ":er1_inverse"), None, sampledSoil, "derivedFrom", blendedSoil, None))
    entityRelationship.append(EntityRelationship(keys.key(siteID + ":er2"), None, sampledSoil, "sourceOf", dna, None))
    entityRelationship.append(EntityRelationship(keys.key(siteID + ":er2_inverse"), None, dna, "derivedFrom", sampledSoil, None))

# For every species
for index in range(len(matrix)):

    print(" Processing " + str(index + 1) + "/" + str(len(matrix)) + " " + matrix["species"].loc[index])

    # This infers the classification based on what is in the matrix
    # The Taxon pairs (parent-child) are collected and then distinct combinations are extracted later.
    # This approach means homonym pairs would merge (e.g. same family+genus in different order) but that is not present
    # in this dataset.
    taxon.append(Taxon(matrix["kingdom"].loc[index], None, matrix["kingdom"].loc[index]))
    taxon.append(Taxon(matrix["phylum"].loc[index], matrix["kingdom"].loc[index], matrix["phylum"].loc[index]))
    taxon.append(Taxon(matrix["class"].loc[index], matrix["phylum"].loc[index], matrix["class"].loc[index]))
    taxon.append(Taxon(matrix["order"].loc[index], matrix["class"].loc[index], matrix["order"].loc[index]))
    taxon.append(Taxon(matrix["family"].loc[index], matrix["order"].loc[index], matrix["family"].loc[index]))
    taxon.append(Taxon(matrix["genus"].loc[index], matrix["family"].loc[index], matrix["genus"].loc[index]))
    taxon.append(Taxon(matrix["species"].loc[index], matrix["genus"].loc[index], matrix["species"].loc[index]))
    taxon.append(Taxon(matrix["SH"].loc[index], matrix["species"].loc[index], matrix["SH"].loc[index]))

    # iterate over the sites having the species
    for siteID in siteIDs:
        if matrix[siteID].loc[index]>0:

            # compound keys of siteID : sequenceID + "something" to ensure uniqueness
            id = siteID + ":" + matrix["qseqid"].loc[index]

            dna = keys.key(siteID + ":ms3") # lookup key (created above)
            sequence = keys.key(id + ":seq1")
            organism = keys.key(id + ":org1")
            entity.append(Entity(organism, "organism", None))
            entity.append(Entity(sequence, "sequence", None))
            digitalEntity.append(DigitalEntity(sequence, "sequence", None, None))
            geneticSequence.append(GeneticSequence(sequence, matrix["sequence"].loc[index], "eDNASequence"))

            # relate them
            entityRelationship.append(EntityRelationship(keys.key(id + ":er3"), None, dna, "sourceOf", sequence, None))
            entityRelationship.append(EntityRelationship(keys.key(id + ":er3_inverse"), None, sequence, "derivedFrom", dna, None))
            entityRelationship.append(EntityRelationship(keys.key(id + ":er4"), None, organism, "inferredFrom", sequence, None))
            entityRelationship.append(EntityRelationship(keys.key(id + ":er5"), None, dna, "partOf", organism, None))

            # sequence / taxon
            taxonID = matrix["SH"].loc[index]
            sequenceTaxon.append(SequenceTaxon(sequence, taxonID, "unite_v3"))
            # TODO append confidence of this claim as assertion, which requires SequenceTaxon to have a PK

            # calculate a relativeAbundance based on the reads
            reads = matrix[siteID].loc[index]
            relativeAbundancePct = 100 * reads / readsPerSite[siteID]
            geneticSequenceAssertions.append(GeneticSequenceAssertion(keys.key(id + ":a1"), sequence, None, "readsDetected", None, reads, "unit"))
            geneticSequenceAssertions.append(GeneticSequenceAssertion(keys.key(id + ":a1"), sequence, None, "readsDetectedPerTotalReads", None, relativeAbundancePct, "percentage"))

# write the output CSVs
Path("./target").mkdir(exist_ok=True)

entityRelationshipDF = pd.DataFrame([vars(e) for e in entityRelationship], columns=['entityRelationshipID', 'dependsOnEntityRelationshipID', 'subjectEntityID', 'entityRelationshipType', 'objectEntityID', 'entityRelationshipDate'])
entityDF = pd.DataFrame([vars(e) for e in entity], columns=['entityID', 'entityType'])
materialEntityDF = pd.DataFrame([vars(e) for e in materialEntity], columns=['materialEntityID', 'materialEntityType'])
digitalEntityDF = pd.DataFrame([vars(e) for e in digitalEntity], columns=['digitalEntityID', 'digitalEntityType', 'accessURI', 'webStatement'])
geneticSequenceDF = pd.DataFrame([vars(e) for e in geneticSequence], columns=['geneticSequenceID', 'sequence', 'geneticSequenceType'])
sequenceTaxonDF = pd.DataFrame([vars(e) for e in sequenceTaxon], columns=['geneticSequenceID', 'taxonID', 'sequenceTaxonAuthorityID'])
eventDF = pd.DataFrame([vars(e) for e in event], columns=['eventID','locationID', 'eventType', 'parentEventID', 'protocolID', 'time', 'environment'])
eventAssertionDF = pd.DataFrame([vars(e) for e in eventAssertion], columns=['assertionID', 'eventID', 'effectiveDate', 'type', 'value', 'valueNumeric', 'unit'])
geneticSequenceAssertionDF = pd.DataFrame([vars(e) for e in geneticSequenceAssertions], columns=['assertionID', 'geneticSequenceID', 'effectiveDate', 'type', 'value', 'valueNumeric', 'unit'])

# distinct the values for those we overpopulate
taxonDF = pd.DataFrame([vars(e) for e in taxon], columns=['taxonID', 'parentTaxonID', 'scientificName']).drop_duplicates()
locationDF = pd.DataFrame([vars(e) for e in location], columns=['locationID']).drop_duplicates()

locationDF.to_csv("./target/location.csv", index=False)
eventDF = eventDF.to_csv("./target/event.csv", index=False)
entityRelationshipDF.to_csv("./target/entityRelationship.csv", index=False)
entityDF.to_csv("./target/entity.csv", index=False)
materialEntityDF.to_csv("./target/materialEntity.csv", index=False)
digitalEntityDF.to_csv("./target/digitalEntity.csv", index=False)
geneticSequenceDF.to_csv("./target/geneticSequence.csv", index=False)
sequenceTaxonDF.to_csv("./target/sequenceTaxon.csv", index=False)
taxonDF.to_csv("./target/taxon.csv", index=False)
eventAssertionDF.to_csv("./target/eventAssertion.csv", index=False)
geneticSequenceAssertionDF.to_csv("./target/geneticSequenceAssertion.csv", index=False)


