---
-- Schema for the specimen related contracts.
-- 
--  To aid readability, this file is structured as:
-- 
--   Location and support tables
--   Event and support tables
--   Entity, sub-entities and their relationships
--   Identification including sequence based identifications
--   Agent and the connections to other entities
--   Assertions for all relevant content
--   Identifiers for all relevant content
---



---
-- Location and support tables
---

CREATE TABLE location (
  locationID TEXT PRIMARY KEY,
  parentLocationID TEXT REFERENCES location ON DELETE CASCADE,
  higherGeographyID TEXT,
  higherGeography TEXT,
  continent TEXT,
  waterBody TEXT,
  islandGroup TEXT,
  island TEXT,
  country TEXT,
  countryCode TEXT,
  stateProvince TEXT,
  county TEXT,
  municipality TEXT,
  locality TEXT,
  minimumElevationInMeters NUMERIC,
  maximumElevationInMeters NUMERIC,
  verticalDatum TEXT,
  minimumDistanceAboveSurfaceInMeters NUMERIC,
  maximumDistanceAboveSurfaceInMeters NUMERIC,
  locationAccordingTo TEXT,
  locationRemarks TEXT
);
CREATE INDEX ON location(parentLocationID);

CREATE TABLE geological_context (
  geologicalContextID TEXT PRIMARY KEY,
  locationID TEXT REFERENCES location ON DELETE CASCADE,
  earliestEonOrLowestEonothem TEXT,
  latestEonOrHighestEonothem TEXT,
  earliestEraOrLowestErathem TEXT,
  latestEraOrHighestErathem TEXT,
  earliestPeriodOrLowestSystem TEXT,
  latestPeriodOrHighestSystem TEXT,
  earliestEpochOrLowestSeries TEXT,
  latestEpochOrHighestSeries TEXT,
  earliestAgeOrLowestStage TEXT,
  latestAgeOrHighestStage TEXT,
  lowestBiostratigraphicZone TEXT,
  highestBiostratigraphicZone TEXT,
  lithostratigraphicTerms TEXT,
  "group" TEXT,
  formation TEXT,
  member TEXT,
  bed TEXT
);
CREATE INDEX ON geological_context(locationID);

CREATE TABLE georeference (
  locationID TEXT REFERENCES location ON DELETE CASCADE,
  decimalLatitude NUMERIC NOT NULL CHECK (decimalLatitude BETWEEN -90 AND 90),
  decimalLongitude NUMERIC NOT NULL CHECK (decimalLongitude BETWEEN -180 AND 180),
  geodeticDatum TEXT NOT NULL,
  coordinateUncertaintyInMeters NUMERIC CHECK (coordinateUncertaintyInMeters > 0),
  coordinatePrecision NUMERIC CHECK (coordinatePrecision > 0),
  pointRadiusSpatialFit NUMERIC CHECK (pointRadiusSpatialFit >= 0),
  footprintWKT TEXT,
  footprintSRS TEXT,
  footprintSpatialFit NUMERIC CHECK (footprintSpatialFit >= 0),
  georeferencedBy TEXT,
  georeferencedDate TEXT,
  georeferenceProtocol TEXT,
  georeferenceSources TEXT,
  georeferenceRemarks TEXT,
  preferredSpatialRepresentation TEXT
);
CREATE INDEX ON georeference(locationID);



---
-- Event and support tables
---

CREATE TABLE protocol (
  protocolID TEXT PRIMARY KEY,
  protocolType TEXT NOT NULL
);

CREATE TABLE reference (
  referenceID TEXT PRIMARY KEY,
  referenceType TEXT NOT NULL,
  bibliographicCitation TEXT,
  referenceYear integer,
  referenceDOI TEXT,
  isPeerReviewed BOOLEAN
);

CREATE TABLE protocol_citation (
  protocolID TEXT REFERENCES protocol,
  protocolReferenceID TEXT REFERENCES reference,
  protocolCitationType TEXT,
  protocolCitationPageNumber TEXT,
  protocolCitationRemarks TEXT,
  PRIMARY KEY (protocolID, protocolReferenceID)
);
CREATE INDEX ON protocol_citation(protocolID, protocolReferenceID);

CREATE TABLE event (
  eventID TEXT PRIMARY KEY,
  parentEventID TEXT REFERENCES event ON DELETE CASCADE,
  eventType TEXT NOT NULL,
  locationID TEXT REFERENCES location ON DELETE CASCADE,
  protocolID TEXT REFERENCES protocol ON DELETE CASCADE,
  eventDate TEXT,
  verbatimEventDate TEXT,
  verbatimLocality TEXT,
  verbatimElevation TEXT,
  verbatimDepth TEXT,
  verbatimCoordinates TEXT,
  verbatimLatitude TEXT,
  verbatimLongitude TEXT,
  verbatimCoordinateSystem TEXT,
  verbatimSRS TEXT,
  protocolDescription TEXT,
  habitat TEXT,
  eventRemarks TEXT,
  eventEffort TEXT
);
CREATE INDEX ON event(parentEventID);
CREATE INDEX ON event(locationID);
CREATE INDEX ON event(protocolID);

---
-- Entity, sub-entities and their relationships.
--
-- Foreign keys on the sub-entities to the entity primary key enforces the
-- inheritance model of:
--
--   Entity
--     DigitalEntity
--       GeneticSequence
--     MaterialEntity
--       MaterialGroup
--     Collection
--     Organism
---

CREATE TYPE ENTITY_TYPE AS ENUM (
  'DIGITAL_ENTITY',
  'GENETIC_SEQUENCE',
  'MATERIAL_ENTITY',
  'MATERIAL_GROUP',
  'COLLECTION',
  'ORGANISM'
);

CREATE TABLE entity (
  entityID TEXT PRIMARY KEY,
  entityType ENTITY_TYPE NOT NULL,
  entityRemarks TEXT
);
CREATE INDEX ON entity(entityType);

CREATE TABLE digital_entity (
  digitalEntityID TEXT PRIMARY KEY REFERENCES entity ON DELETE CASCADE,
  digitalEntityType TEXT NOT NULL,
  accessURI TEXT NOT NULL,
  webStatement TEXT,
  format TEXT,
  license TEXT,
  accessRights TEXT,
  rightsHolder TEXT
);

CREATE TABLE genetic_sequence (
  geneticSequenceID TEXT PRIMARY KEY REFERENCES digital_entity ON DELETE CASCADE,
  geneticSequenceType TEXT NOT NULL,
  sequence TEXT NOT NULL
);

CREATE TABLE material_entity (
  materialEntityID TEXT PRIMARY KEY REFERENCES entity ON DELETE CASCADE,
  materialEntityType TEXT NOT NULL
);

CREATE TABLE material_group (
  materialGroupID TEXT PRIMARY KEY REFERENCES material_entity ON DELETE CASCADE,
  materialGroupType TEXT
);

CREATE TABLE collection (
  collectionID TEXT PRIMARY KEY REFERENCES entity ON DELETE CASCADE,
  collectionType TEXT,
  collectionCode TEXT,
  institutionCode TEXT,
  grsciCollID UUID NOT NULL
);

CREATE TABLE organism (
  organismID TEXT PRIMARY KEY REFERENCES entity ON DELETE CASCADE,
  organismScope TEXT,
  organismQuantity TEXT,
  organismQuantityType TEXT,
  organismName TEXT
);

CREATE TYPE OCCURRENCE_STATUS AS ENUM (
  'PRESENT',
  'ABSENT'
);

CREATE TABLE entity_event (
  entityID TEXT REFERENCES entity ON DELETE CASCADE,
  eventID TEXT REFERENCES event ON DELETE CASCADE,
  occurrenceStatus OCCURRENCE_STATUS NOT NULL,
  establishmentMeans TEXT,
  pathway TEXT,
  degreeOfEstablishment TEXT,
  sex TEXT,
  lifeStage TEXT,
  reproductiveCondition TEXT,
  behavior TEXT,
  entityEventRemarks TEXT,
  PRIMARY KEY (entityID, eventID)
);
CREATE INDEX ON entity_event(entityID, eventID);

CREATE TABLE entity_relationship (
  entityRelationshipID TEXT PRIMARY KEY,
  dependsOnEntityRelationshipID TEXT REFERENCES entity_relationship ON DELETE CASCADE,
  subjectEntityID TEXT REFERENCES entity ON DELETE CASCADE,
  entityRelationshipType TEXT NOT NULL,
  objectEntityID TEXT REFERENCES entity ON DELETE CASCADE,
  objectEntityIRI TEXT,
  entityRelationshipDate TEXT
);
CREATE INDEX ON entity_relationship(dependsOnEntityRelationshipID);
CREATE INDEX ON entity_relationship(subjectEntityID);
CREATE INDEX ON entity_relationship(objectEntityID);


---
-- Identification including sequence based identifications.
-- An identification connects an Entity to one or more Taxa through a taxon formula.
-- The identification may involve genetic material and a sequence.
---
CREATE TABLE identification (
  identificationID TEXT PRIMARY KEY,
  identificationType TEXT NOT NULL,
  taxonFormula TEXT NOT NULL,
  verbatimIdentification TEXT,
  typeStatus TEXT,
  dateIdentified TEXT,
  identificationVerificationStatus TEXT,
  identificationRemarks TEXT,
  isAcceptedIdentification BOOLEAN
);

CREATE TABLE identification_entity (
  identificationID TEXT REFERENCES identification ON DELETE CASCADE,
  entityID TEXT REFERENCES entity ON DELETE CASCADE,
  PRIMARY KEY (identificationID, entityID)
);

CREATE TABLE taxon (
  taxonID TEXT PRIMARY KEY,
  parentTaxonID TEXT REFERENCES taxon ON DELETE CASCADE,
  scientificName TEXT NOT NULL,
  scientificNameID TEXT,
  acceptedNameUsageID TEXT,
  parentNameUsageID TEXT,
  originalNameUsageID TEXT,
  taxonConceptID TEXT,
  acceptedNameUsage TEXT,
  parentNameUsage TEXT,
  originalNameUsage TEXT,
  higherClassification TEXT,
  kingdom TEXT,
  phylum TEXT,
  class TEXT,
  "order" TEXT,
  family TEXT,
  subfamily TEXT,
  genericName TEXT,
  subgenus TEXT,
  infragenericEpithet TEXT,
  specificEpithet TEXT,
  infraspecificEpithet TEXT,
  cultivarEpithet TEXT,
  taxonRank TEXT,
  verbatimTaxonRank TEXT,
  scientificNameAuthorship TEXT,
  vernacularName TEXT,
  nomenclaturalCode TEXT,
  taxonomicStatus TEXT,
  nomenclaturalStatus TEXT,
  taxonRemarks TEXT
);
CREATE INDEX ON taxon(parentTaxonID);

CREATE TABLE taxon_identification (
  taxonID TEXT REFERENCES taxon ON DELETE CASCADE,
  identificationID TEXT REFERENCES identification ON DELETE CASCADE,
  taxonOrder NUMERIC NOT NULL CHECK (taxonOrder >= 0),
  PRIMARY KEY (taxonID, identificationID)
);

CREATE TABLE sequence_taxon (
  taxonID TEXT REFERENCES taxon ON DELETE CASCADE,
  geneticSequenceID TEXT REFERENCES genetic_sequence ON DELETE CASCADE,
  sequenceTaxonAuthority TEXT,
  taxonConfidencePercent NUMERIC NOT NULL CHECK (taxonConfidencePercent BETWEEN 0 AND 100),
  PRIMARY KEY (taxonID, geneticSequenceID)
);

CREATE TABLE identification_citation (
  identificationID TEXT,
  identificationReferenceID TEXT,
  identificationCitationType TEXT,
  identificationCitationPageNumber TEXT,
  identificationCitationRemarks TEXT,
  PRIMARY KEY (identificationID, identificationReferenceID)
);



---
--   Agent and the connections to other entities
---

CREATE TABLE agent (
  agentID TEXT PRIMARY KEY,
  agentType TEXT NOT NULL,
  preferredAgentName TEXT
);

CREATE TABLE agent_relationship (
  subjectAgentID TEXT REFERENCES agent ON DELETE CASCADE,
  relationshipTo TEXT NOT NULL,
  objectAgentID TEXT REFERENCES agent ON DELETE CASCADE,
  PRIMARY KEY (subjectAgentID, relationshipTo, objectAgentID)
);

CREATE TABLE collection_agent_role (
  collectionID TEXT REFERENCES collection ON DELETE CASCADE,
  agentID TEXT REFERENCES agent ON DELETE CASCADE,
  collectionAgentRole TEXT NOT NULL,
  collectionAgentRoleBegan TEXT,
  collectionAgentRoleEnded TEXT,
  collectionAgentRoleOrder SMALLINT NOT NULL CHECK (collectionAgentRoleOrder > 0),
  PRIMARY KEY (collectionID, agentID, collectionAgentRoleOrder)
);

CREATE TABLE entity_agent_role (
  entityID TEXT REFERENCES entity ON DELETE CASCADE,
  agentID TEXT REFERENCES agent ON DELETE CASCADE,
  entityAgentRole TEXT,
  entityAgentRoleBegan TEXT,
  entityAgentRoleEnded TEXT,
  entityAgentRoleOrder SMALLINT NOT NULL CHECK (entityAgentRoleOrder > 0),
  PRIMARY KEY (entityID, agentID, entityAgentRoleOrder)
);

CREATE TABLE event_agent_role (
  eventID TEXT REFERENCES event ON DELETE CASCADE,
  agentID TEXT REFERENCES agent ON DELETE CASCADE,
  eventAgentRole TEXT,
  eventAgentRoleBegan TEXT,
  eventAgentRoleEnded TEXT,
  eventAgentRoleOrder SMALLINT NOT NULL CHECK (eventAgentRoleOrder > 0),
  PRIMARY KEY (eventID, agentID, eventAgentRoleOrder)
);

CREATE TABLE identification_agent_role (
  identificationID TEXT REFERENCES identification ON DELETE CASCADE,
  agentID TEXT REFERENCES agent ON DELETE CASCADE,
  identificationAgentRole TEXT,
  identificationAgentRoleBegan TEXT,
  identificationAgentRoleEnded TEXT,
  identificationAgentRoleOrder SMALLINT NOT NULL CHECK (identificationAgentRoleOrder > 0),
  PRIMARY KEY (identificationID, agentID, identificationAgentRoleOrder)
);

CREATE TABLE reference_agent_role (
  referenceID TEXT REFERENCES reference ON DELETE CASCADE,
  agentID TEXT REFERENCES agent ON DELETE CASCADE,
  referenceAgentRole TEXT,
  referenceAgentRoleBegan TEXT,
  referenceAgentRoleEnded TEXT,
  referenceAgentRoleOrder SMALLINT NOT NULL CHECK (referenceAgentRoleOrder > 0),
  PRIMARY KEY (referenceID, agentID, referenceAgentRoleOrder)
);



---
--   Assertions for all relevant content
---

CREATE TABLE entity_assertion (
  entityAssertionID TEXT PRIMARY KEY,
  entityID TEXT NOT NULL REFERENCES entity ON DELETE CASCADE,
  entityParentAssertionID TEXT REFERENCES entity_assertion ON DELETE CASCADE,
  entityAssertionType TEXT NOT NULL,
  entityAssertionMadeDate TEXT,
  entityAssertionEffectiveDate TEXT,
  entityAssertionValue TEXT,
  entityAssertionValueNumeric NUMERIC,
  entityAssertionUnit TEXT,
  entityAssertionByAgentID TEXT REFERENCES agent ON DELETE CASCADE,
  entityAssertionProtocol TEXT,
  entityAssertionProtocolID TEXT,
  entityAssertionRemarks TEXT
);

CREATE TABLE event_assertion (
  eventID TEXT PRIMARY KEY,
  eventAssertionID TEXT NOT NULL REFERENCES event ON DELETE CASCADE,
  eventParentAssertionID TEXT REFERENCES event_assertion ON DELETE CASCADE,
  eventAssertionType TEXT NOT NULL,
  eventAssertionMadeDate TEXT,
  eventAssertionEffectiveDate TEXT,
  eventAssertionValue TEXT,
  eventAssertionValueNumeric NUMERIC,
  eventAssertionUnit TEXT,
  eventAssertionByAgentID TEXT REFERENCES agent ON DELETE CASCADE,
  eventAssertionProtocol TEXT,
  eventAssertionProtocolID TEXT,
  eventAssertionRemarks TEXT
);

CREATE TABLE location_assertion (
  locationID TEXT PRIMARY KEY,
  locationAssertionID TEXT NOT NULL REFERENCES location ON DELETE CASCADE,
  locationParentAssertionID TEXT REFERENCES location_assertion ON DELETE CASCADE,
  locationAssertionType TEXT NOT NULL,
  locationAssertionMadeDate TEXT,
  locationAssertionEffectiveDate TEXT,
  locationAssertionValue TEXT,
  locationAssertionValueNumeric NUMERIC,
  locationAssertionUnit TEXT,
  locationAssertionByAgentID TEXT REFERENCES agent ON DELETE CASCADE,
  locationAssertionProtocol TEXT,
  locationAssertionProtocolID TEXT,
  locationAssertionRemarks TEXT
);



---
--   Identifiers for all relevant content
---

CREATE TABLE agent_identifier (
  agentID TEXT REFERENCES agent ON DELETE CASCADE,
  agentIdentifier TEXT NOT NULL,
  agentIdentifierType TEXT,
  PRIMARY KEY (agentID, agentIdentifier, agentIdentifierType)
);


CREATE TABLE collection_identifier (
  collectionID TEXT REFERENCES collection ON DELETE CASCADE,
  collectionIdentifier TEXT,
  collectionIdentifierType TEXT,
  PRIMARY KEY (collectionID, collectionIdentifier, collectionIdentifierType)
);

CREATE TABLE entity_identifier (
  entityID TEXT REFERENCES entity ON DELETE CASCADE,
  entityIdentifier TEXT NOT NULL,
  entityIdentifierType TEXT NOT NULL,
  PRIMARY KEY (entityID, entityIdentifier, entityIdentifierType)
);

CREATE TABLE event_identifier (
  eventID TEXT REFERENCES event ON DELETE CASCADE,
  eventIdentifier TEXT NOT NULL,
  eventIdentifierType TEXT  NOT NULL,
  PRIMARY KEY (eventID, eventIdentifier, eventIdentifierType)
);