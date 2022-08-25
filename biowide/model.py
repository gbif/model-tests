class Location:
    def __init__(self, locationID):
        self.locationID = locationID

class Event:
    def __init__(self, eventID, locationID, eventType, parentEventID, protocolID, time, environment):
        self.eventID = eventID
        self.locationID = locationID
        self.eventType = eventType
        self.parentEventID = parentEventID
        self.protocolID = protocolID
        self.time = time
        self.environment = environment

class EntityRelationship:
    def __init__(self, entityRelationshipID, dependsOnEntityRelationshipID, subjectEntityID, entityRelationshipType, objectEntityID, entityRelationshipDate):
        self.entityRelationshipID = entityRelationshipID
        self.dependsOnEntityRelationshipID = dependsOnEntityRelationshipID
        self.subjectEntityID = subjectEntityID
        self.entityRelationshipType = entityRelationshipType
        self.objectEntityID = objectEntityID
        self.entityRelationshipDate = entityRelationshipDate

class Entity:
    def __init__(self, entityID, entityType, collectionID):
        self.entityID = entityID
        self.entityType = entityType
        self.collectionID = collectionID

class EntityEvent:
    def __init__(self, entityID, eventID):
        self.entityID = entityID
        self.eventID = eventID

class MaterialEntity:
    def __init__(self, materialEntityID, materialEntityType):
        self.materialEntityID = materialEntityID
        self.materialEntityType = materialEntityType

class DigitalEntity:
    def __init__(self, digitalEntityID, digitalEntityType, accessURI, webStatement):
        self.digitalEntityID = digitalEntityID
        self.digitalEntityType = digitalEntityType
        self.accessURI = accessURI
        self.webStatement = webStatement

class GeneticSequence:
    def __init__(self, geneticSequenceID, sequence, geneticSequenceType):
        self.geneticSequenceID = geneticSequenceID
        self.sequence = sequence
        self.geneticSequenceType = geneticSequenceType

class SequenceTaxon:
    def __init__(self, geneticSequenceID, taxonID, sequenceTaxonAuthorityID, confidence):
        self.geneticSequenceID = geneticSequenceID
        self.taxonID = taxonID
        self.sequenceTaxonAuthorityID = sequenceTaxonAuthorityID
        self.confidence = confidence

class Taxon:
    def __init__(self, taxonID, parentTaxonID, scientificName):
        self.taxonID = taxonID
        self.parentTaxonID = parentTaxonID
        self.scientificName = scientificName

# Assertions could be modelled in a single table, but a table per class eases implementation of GraphQL
class EventAssertion:
    def __init__(self, assertionID, eventID, effectiveDate, type, value, valueNumeric, unit):
        self.assertionID = assertionID
        self.eventID = eventID
        self.effectiveDate = effectiveDate
        self.type = type
        self.value = value
        self.valueNumeric = valueNumeric
        self.unit = unit

class GeneticSequenceAssertion:
    def __init__(self, assertionID, geneticSequenceID, effectiveDate, type, value, valueNumeric, unit):
        self.assertionID = assertionID
        self.geneticSequenceID = geneticSequenceID
        self.effectiveDate = effectiveDate
        self.type = type
        self.value = value
        self.valueNumeric = valueNumeric
        self.unit = unit

class SequenceTaxonAssertion:
    def __init__(self, assertionID, geneticSequenceID, effectiveDate, type, value, valueNumeric, unit):
        self.assertionID = assertionID
        self.geneticSequenceID = geneticSequenceID
        self.effectiveDate = effectiveDate
        self.type = type
        self.value = value
        self.valueNumeric = valueNumeric
        self.unit = unit


# Simple dictionary to assign auto incrementing integer keys
class Keys:
    def __init__(self):
        self._counter = 0
        self._dict = {}

    def key(self, value):
        curr = self._dict.get(value)
        if curr == None:
            self._counter += 1
            self._dict[value] = self._counter
            return self._counter
        else:
            return curr

def is_num(s):
    try:
        float(s)
    except ValueError:
        return False
    else:
        return True