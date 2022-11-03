--
-- psql gum -f gum_create.sql
--

-- Script to create the unified model. Though this is a single script, it is separated
-- into sections for:
--
--  CREATE core tables
--  CREATE common model tables
--  CONSTRAIN core tables
--    PRIMARY KEYS for core tables
--    FOREIGN KEYS for core tables
--  CONSTRAIN common model tables
--    PRIMARY KEYS for common model tables
--    FOREIGN KEYS for common tables
--  ALTER core tables to add properties
--  ALTER common model tables to add properties

-- ----- CREATE core tables ------
--
-- entity (PK)
--   collection (PK)
--   digital_entity (PK)
--     genetic_sequence (PK)
--   material_entity (PK)
--     material_group (PK)
--   organism (PK)
-- entity_relationship (PK)
-- event (PK)
-- protocol (PK)
-- location (PK)
-- geological_context
-- georeference
-- entity_event
-- identification (PK)
-- identification_entity
-- taxon (PK)
-- taxon_identification
-- sequence_taxon

CREATE TABLE public.entity (
    "entityID" character varying,
    "entityType" character varying
);

CREATE TABLE public.collection (
    "collectionID" character varying,
    "collectionType" character varying
);

CREATE TABLE public.digital_entity (
    "digitalEntityID" character varying,
    "digitalEntityType" character varying
);

CREATE TABLE public.genetic_sequence (
    "geneticSequenceID" character varying,
    "geneticSequenceType" character varying,
    "sequence" character varying
);

CREATE TABLE public.material_entity (
    "materialEntityID" character varying,
    "materialEntityType" character varying
);

CREATE TABLE public.material_group (
    "materialGroupID" character varying,
    "materialGroupType" character varying
);

CREATE TABLE public.organism (
    "organismID" character varying,
    "organismScope" character varying
);

CREATE TABLE public.entity_relationship (
    "entityRelationshipID" character varying,
    "dependsOnEntityRelationshipID" character varying,
    "subjectEntityID" character varying,
    "entityRelationshipType" character varying,
    "objectEntityID" character varying,
    "objectEntityIRI" character varying,
    "entityRelationshipDate" character varying
);

CREATE TABLE public.event (
    "eventID" character varying,
    "parentEventID" character varying,
    "eventType" character varying,
    "locationID" character varying,
    "protocolID" character varying,
    "eventDate" character varying
);

CREATE TABLE public.protocol (
    "protocolID" character varying,
    "protocolType" character varying
);

CREATE TABLE public.location (
    "locationID" character varying,
    "parentLocationID" character varying
);

CREATE TABLE public.geological_context (
    "locationID" character varying
);

CREATE TABLE public.georeference (
    "locationID" character varying
);

CREATE TABLE public.entity_event (
    "entityID" character varying,
    "eventID" character varying
);

CREATE TABLE public.identification (
    "identificationID" character varying,
    "identificationType" character varying
);

CREATE TABLE public.identification_entity (
    "identificationID" character varying,
    "entityID" character varying
);

CREATE TABLE public.taxon (
    "taxonID" character varying,
    "parentTaxonID" character varying,
    "scientificName" character varying
);

CREATE TABLE public.taxon_identification (
    "taxonID" character varying,
    "identificationID" character varying,
    "taxonOrder" character varying
);

CREATE TABLE public.sequence_taxon (
    "taxonID" character varying,
    "geneticSequenceID" character varying,
    "sequenceTaxonAuthority" character varying
);

-- ----- CREATE common model tables ------
--
--   agent
--   agent_identifier
--   agent_relationship
--   collection_agent_role
--   collection_identifier
--   entity_agent_role
--   entity_assertion
--   entity_identifier
--   event_agent_role
--   event_assertion
--   event_identifier
--   identification_agent_role
--   identification_citation
--   location_assertion
--   reference_agent_role
--   reference
--   

CREATE TABLE public.agent (
    "agentID" character varying,
    "agentType" character varying,
    "preferredAgentName" character varying
);

CREATE TABLE public.agent_identifier (
    "agentID" character varying,
    "agentIdentifier" character varying,
    "agentIdentifierType" character varying
);

CREATE TABLE public.agent_relationship (
    "subjectAgentID" character varying,
    "relationshipTo" character varying,
    "objectAgentID" character varying
);

CREATE TABLE public.collection_agent_role (
    "collectionID" character varying,
    "agentID" character varying,
    "collectionAgentRole" character varying,
    "collectionAgentRoleBegan" character varying,
    "collectionAgentRoleEnded" character varying,
    "collectionAgentRoleOrder" integer
);

CREATE TABLE public.collection_identifier (
    "collectionID" character varying,
    "collectionIdentifier" character varying,
    "collectionIdentifierType" character varying
);

CREATE TABLE public.entity_agent_role (
    "entityID" character varying,
    "agentID" character varying,
    "entityAgentRole" character varying,
    "entityAgentRoleBegan" character varying,
    "entityAgentRoleEnded" character varying,
    "entityAgentRoleOrder" integer
);

CREATE TABLE public.entity_assertion (
    "entityID" character varying,
    "entityAssertionID" character varying,
    "entityParentAssertionID" character varying,
    "entityAssertionType" character varying,
    "entityAssertionMadeDate" character varying,
    "entityAssertionEffectiveDate" character varying,
    "entityAssertionValue" character varying,
    "entityAssertionValueNumeric" numeric,
    "entityAssertionUnit" character varying,
    "entityAssertionByAgentID" character varying,
    "entityAssertionProtocol" character varying,
    "entityAssertionProtocolID" character varying,
    "entityAssertionRemarks" character varying
);

-- This is where IRIs to external entity identifiers should go
CREATE TABLE public.entity_identifier (
    "entityID" character varying,
    "entityIdentifier" character varying,
    "entityIdentifierType" character varying
);

CREATE TABLE public.event_agent_role (
    "eventID" character varying,
    "agentID" character varying,
    "eventAgentRole" character varying,
    "eventAgentRoleBegan" character varying,
    "eventAgentRoleEnded" character varying,
    "eventAgentRoleOrder" integer
);

CREATE TABLE public.event_assertion (
    "eventID" character varying,
    "eventAssertionID" character varying,
    "eventParentAssertionID" character varying,
    "eventAssertionType" character varying,
    "eventAssertionMadeDate" character varying,
    "eventAssertionEffectiveDate" character varying,
    "eventAssertionValue" character varying,
    "eventAssertionValueNumeric" numeric,
    "eventAssertionUnit" character varying,
    "eventAssertionByAgentID" character varying,
    "eventAssertionProtocol" character varying,
    "eventAssertionProtocolID" character varying,
    "eventAssertionRemarks" character varying
);

CREATE TABLE public.event_identifier (
    "eventID" character varying,
    "eventIdentifier" character varying,
    "eventIdentifierType" character varying
);

CREATE TABLE public.identification_agent_role (
    "identificationID" character varying,
    "agentID" character varying,
    "identificationAgentRole" character varying,
    "identificationAgentRoleBegan" character varying,
    "identificationAgentRoleEnded" character varying,
    "identificationAgentRoleOrder" integer
);

CREATE TABLE public.identification_citation (
    "identificationID" character varying,
    "identificationReferenceID" character varying,
    "identificationCitationType" character varying,
    "identificationCitationPageNumber" character varying,
    "identificationCitationRemarks" character varying
);

CREATE TABLE public.location_assertion (
    "locationID" character varying,
    "locationAssertionID" character varying,
    "locationParentAssertionID" character varying,
    "locationAssertionType" character varying,
    "locationAssertionMadeDate" character varying,
    "locationAssertionEffectiveDate" character varying,
    "locationAssertionValue" character varying,
    "locationAssertionValueNumeric" numeric,
    "locationAssertionUnit" character varying,
    "locationAssertionByAgentID" character varying,
    "locationAssertionProtocol" character varying,
    "locationAssertionProtocolID" character varying,
    "locationAssertionRemarks" character varying
);

CREATE TABLE public.protocol_citation (
    "protocolID" character varying,
    "protocolReferenceID" character varying,
    "protocolCitationType" character varying,
    "protocolCitationPageNumber" character varying,
    "protocolCitationRemarks" character varying
);

CREATE TABLE public.reference_agent_role (
    "referenceID" character varying,
    "agentID" character varying,
    "referenceAgentRole" character varying,
    "referenceAgentRoleBegan" character varying,
    "referenceAgentRoleEnded" character varying,
    "referenceAgentRoleOrder" integer
);

CREATE TABLE public.reference (
    "referenceID" character varying,
    "referenceType" character varying,
    "bibliographicCitation" character varying,
    "referenceYear" integer,
    "referenceDOI" character varying,
    "isPeerReviewed" boolean
);

-- ----- CONSTRAIN core tables ------
--    PRIMARY KEYS for core tables
--
ALTER TABLE ONLY public.collection
    ADD CONSTRAINT pk_collection UNIQUE ("collectionID");

ALTER TABLE ONLY public.digital_entity
    ADD CONSTRAINT pk_digital_entity UNIQUE ("digitalEntityID");

ALTER TABLE ONLY public.entity
    ADD CONSTRAINT pk_entity UNIQUE ("entityID");

ALTER TABLE ONLY public.entity_relationship
    ADD CONSTRAINT pk_entity_relationshipid UNIQUE ("entityRelationshipID");

ALTER TABLE ONLY public.event
    ADD CONSTRAINT pk_event UNIQUE ("eventID");

ALTER TABLE ONLY public.genetic_sequence
    ADD CONSTRAINT pk_event_geneticSequenceID UNIQUE ("geneticSequenceID");

ALTER TABLE ONLY public.identification
    ADD CONSTRAINT pk_identification UNIQUE ("identificationID");

ALTER TABLE ONLY public.location
    ADD CONSTRAINT pk_location UNIQUE ("locationID");

ALTER TABLE ONLY public.material_entity
    ADD CONSTRAINT pk_material_entity UNIQUE ("materialEntityID");

ALTER TABLE ONLY public.material_group
    ADD CONSTRAINT pk_material_entity_materialGroupID UNIQUE ("materialGroupID");

ALTER TABLE ONLY public.organism
    ADD CONSTRAINT pk_organismID UNIQUE ("organismID");

ALTER TABLE ONLY public.protocol
    ADD CONSTRAINT pk_protocolID UNIQUE ("protocolID");

ALTER TABLE ONLY public.taxon
    ADD CONSTRAINT pk_taxon UNIQUE ("taxonID");

--    FOREIGN KEYS for core tables
--
-- A Location may have zero or more Georeferences.
ALTER TABLE ONLY public.georeference
    ADD CONSTRAINT "georeference_locationID_fkey" 
    FOREIGN KEY ("locationID") REFERENCES public.location("locationID");

-- A Location may have zero or one GeologicalContexts.
ALTER TABLE ONLY public.geological_context
    ADD CONSTRAINT "geological_context_locationID_fkey" 
    FOREIGN KEY ("locationID") REFERENCES public.location("locationID");

-- The parentLocationID supports an arbitrary Location hierarchy
ALTER TABLE ONLY public.location
    ADD CONSTRAINT "location_locationID_fkey" 
    FOREIGN KEY ("parentLocationID") REFERENCES public.location("locationID");

-- An Event happens at a Location whether declared or not.
ALTER TABLE ONLY public.event
    ADD CONSTRAINT "event_locationID_fkey" 
    FOREIGN KEY ("locationID") REFERENCES public.location("locationID");

-- The parentEventID supports an arbitrary Event hierarchy. Parent Events are expected to
-- contain child Events both spatially and temporally.
ALTER TABLE ONLY public.event
    ADD CONSTRAINT "event_eventID_fkey" 
    FOREIGN KEY ("parentEventID") REFERENCES public.event("eventID");

-- An Event may have a declared Protocol.
ALTER TABLE ONLY public.event
    ADD CONSTRAINT "event_protocolID_fkey" 
    FOREIGN KEY ("protocolID") REFERENCES public.protocol("protocolID");

-- An Entity may participate in one or more Events.
ALTER TABLE ONLY public.entity_event
    ADD CONSTRAINT "entity_event_entityID_fkey" 
    FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

-- An Event may target zero or more Entities.
ALTER TABLE ONLY public.entity_event
    ADD CONSTRAINT "entity_event_eventID_fkey" 
    FOREIGN KEY ("eventID") REFERENCES public.event("eventID");

-- An EntityRelationship may depend on zero or one other EntityRelationships.
ALTER TABLE ONLY public.entity_relationship
    ADD CONSTRAINT "entity_relationship_dependsOnEntityRelationshipID_fkey" 
    FOREIGN KEY ("dependsOnEntityRelationshipID") REFERENCES public.entity_relationship("entityRelationshipID");

-- An EntityRelationship has exactly one object Entity.
ALTER TABLE ONLY public.entity_relationship
    ADD CONSTRAINT "entity_relationship_objectEntityID_fkey" 
    FOREIGN KEY ("objectEntityID") REFERENCES public.entity("entityID");

-- An EntityRelationship has exactly one subject Entity.
ALTER TABLE ONLY public.entity_relationship
    ADD CONSTRAINT "entity_relationship_subjectEntityID_fkey" 
    FOREIGN KEY ("subjectEntityID") REFERENCES public.entity("entityID");

-- A Collection is a subtype of Entity.
ALTER TABLE ONLY public.collection
    ADD CONSTRAINT "collection_collectionID_fkey" 
    FOREIGN KEY ("collectionID") REFERENCES public.entity("entityID");

-- A DigitalEntity is a subtype of Entity.
ALTER TABLE ONLY public.digital_entity
    ADD CONSTRAINT "digital_entity_digitalEntityID_fkey" 
    FOREIGN KEY ("digitalEntityID") REFERENCES public.entity("entityID");

-- A GeneticSequence is a subtype of DigitalEntity.
ALTER TABLE ONLY public.genetic_sequence
    ADD CONSTRAINT "genetic_sequence_geneticSequenceID_fkey" 
    FOREIGN KEY ("geneticSequenceID") REFERENCES public.digital_entity("digitalEntityID");

-- A MaterialEntity is a subtype of Entity.
ALTER TABLE ONLY public.material_entity
    ADD CONSTRAINT "material_entity_materialEntityID_fkey" 
    FOREIGN KEY ("materialEntityID") REFERENCES public.entity("entityID");

-- A MaterialGroup is a subtype of MaterialEntity.
ALTER TABLE ONLY public.material_group
    ADD CONSTRAINT "material_group_materialGroupID_fkey" 
    FOREIGN KEY ("materialGroupID") REFERENCES public.material_entity("materialEntityID");

-- An Organism is a subtype of Entity.
ALTER TABLE ONLY public.organism
    ADD CONSTRAINT "organism_organismID_fkey" 
    FOREIGN KEY ("organismID") REFERENCES public.entity("entityID");

-- An Identification can apply to one or more Entities.
ALTER TABLE ONLY public.identification_entity
    ADD CONSTRAINT "identification_entity_identificationID_fkey" 
    FOREIGN KEY ("identificationID") REFERENCES public.identification("identificationID");

-- An Entity may participate in one or more Identifications.
ALTER TABLE ONLY public.identification_entity
    ADD CONSTRAINT "identification_entity_entityID_fkey" 
    FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

-- The parentTaxonID supports an arbitrary Taxon hierarchy.
ALTER TABLE ONLY public.taxon
    ADD CONSTRAINT "taxon_taxonID_fkey" 
    FOREIGN KEY ("parentTaxonID") REFERENCES public.taxon("taxonID");

-- An Taxon may participate in one or more Identifications.
ALTER TABLE ONLY public.taxon_identification
    ADD CONSTRAINT "taxon_identification_taxonID_fkey" 
    FOREIGN KEY ("taxonID") REFERENCES public.taxon("taxonID");

-- An Identification can involve one or more Taxa.
ALTER TABLE ONLY public.taxon_identification
    ADD CONSTRAINT "taxon_identification_identificationID_fkey" 
    FOREIGN KEY ("identificationID") REFERENCES public.identification("identificationID");

-- An Taxon may be indicated by zero or more GeneticSequences.
ALTER TABLE ONLY public.sequence_taxon
    ADD CONSTRAINT "sequence_taxon_taxonID_fkey" 
    FOREIGN KEY ("taxonID") REFERENCES public.taxon("taxonID");

-- A GeneticSequence may refer to one or more Taxa.
ALTER TABLE ONLY public.sequence_taxon
    ADD CONSTRAINT "sequence_taxon_geneticSequenceID_fkey" 
    FOREIGN KEY ("geneticSequenceID") REFERENCES public.genetic_sequence("geneticSequenceID");

-- ----- CONSTRAIN common model tables ------
--    PRIMARY KEYS for common model tables
--
ALTER TABLE ONLY public.agent
    ADD CONSTRAINT pk_agent UNIQUE ("agentID");

ALTER TABLE ONLY public.entity_assertion
    ADD CONSTRAINT pk_entity_assertion UNIQUE ("entityAssertionID");

ALTER TABLE ONLY public.event_assertion
    ADD CONSTRAINT pk_event_assertion UNIQUE ("eventAssertionID");

ALTER TABLE ONLY public.location_assertion
    ADD CONSTRAINT pk_location_assertion UNIQUE ("locationAssertionID");

ALTER TABLE ONLY public.reference
    ADD CONSTRAINT pk_reference UNIQUE ("referenceID");

--    FOREIGN KEYS for common tables
--
-- An Agent may have zero or more Identifiers.
ALTER TABLE ONLY public.agent_identifier
    ADD CONSTRAINT "agent_identifier_agentID_fkey" 
    FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

-- An Collection may have zero or more Identifiers.
ALTER TABLE ONLY public.collection_identifier
    ADD CONSTRAINT "collection_identifier_agentID_fkey" 
    FOREIGN KEY ("collectionID") REFERENCES public.collection("collectionID");

-- An Entity may have zero or more Identifiers.
ALTER TABLE ONLY public.entity_identifier
    ADD CONSTRAINT "entity_identifier_agentID_fkey" 
    FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

-- An Event may have zero or more Identifiers.
ALTER TABLE ONLY public.event_identifier
    ADD CONSTRAINT "event_identifier_agentID_fkey" 
    FOREIGN KEY ("eventID") REFERENCES public.event("eventID");

-- An AgentRelationship has exactly one object Agent.
ALTER TABLE ONLY public.agent_relationship
    ADD CONSTRAINT "agent_relationship_objectAgentID_fkey" 
    FOREIGN KEY ("objectAgentID") REFERENCES public.agent("agentID");

-- An AgentRelationship has exactly one subject Agent.
ALTER TABLE ONLY public.agent_relationship
    ADD CONSTRAINT "agent_relationship_subbjectAgentID_fkey" 
    FOREIGN KEY ("subjectAgentID") REFERENCES public.agent("agentID");

-- A Collection may have zero or more CollectionAgentRoles.
ALTER TABLE ONLY public.collection_agent_role
    ADD CONSTRAINT "collection_agent_role_agentID_fkey" 
    FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

-- An Agent may have zero or more EntityAgentRoles.
ALTER TABLE ONLY public.entity_agent_role
    ADD CONSTRAINT "entity_agent_role_agentID_fkey" 
    FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

-- An Entity may have zero or more EntityAgentRoles.
ALTER TABLE ONLY public.entity_agent_role
    ADD CONSTRAINT "entity_agent_role_entityID_fkey" 
    FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

-- An Agent may have zero or more EventAgentRoles.
ALTER TABLE ONLY public.event_agent_role
    ADD CONSTRAINT "event_agent_role_agentID_fkey" 
    FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

-- An Event may have zero or more EventAgentRoles.
ALTER TABLE ONLY public.event_agent_role
    ADD CONSTRAINT "event_agent_role_eventID_fkey" 
    FOREIGN KEY ("eventID") REFERENCES public.event("eventID");

-- An Agent may have zero or more IdentificationAgentRoles.
ALTER TABLE ONLY public.identification_agent_role
    ADD CONSTRAINT "identification_agent_role_agentID_fkey" 
    FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

-- An Identification may have zero or more IdentificationAgentRoles.
ALTER TABLE ONLY public.identification_agent_role
    ADD CONSTRAINT "identification_agent_role_identificationID_fkey" 
    FOREIGN KEY ("identificationID") REFERENCES public.identification("identificationID");

-- An Agent may have zero or more ReferenceAgentRoles.
ALTER TABLE ONLY public.reference_agent_role
    ADD CONSTRAINT "reference_agent_role_agentID_fkey" 
    FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

-- A Reference may have zero or more ReferenceAgentRoles.
ALTER TABLE ONLY public.reference_agent_role
    ADD CONSTRAINT "reference_agent_role_referenceID_fkey" 
    FOREIGN KEY ("referenceID") REFERENCES public.reference("referenceID");

-- An Entity may have zero or more EntityAssertions.
ALTER TABLE ONLY public.entity_assertion
    ADD CONSTRAINT "entity_assertion_entityID_fkey" 
    FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

-- An EntityAssertion may be made by zero or one Agents.
ALTER TABLE ONLY public.entity_assertion
    ADD CONSTRAINT "entity_assertion_entityAssertionByAgentID_fkey" 
    FOREIGN KEY ("entityAssertionByAgentID") REFERENCES public.agent("agentID");

-- An Event may have zero or more EventAssertions.
ALTER TABLE ONLY public.event_assertion
    ADD CONSTRAINT "event_assertion_eventID_fkey" 
    FOREIGN KEY ("eventID") REFERENCES public.event("eventID");

-- An EventAssertion may be made by zero or one Agents.
ALTER TABLE ONLY public.event_assertion
    ADD CONSTRAINT "event_assertion_eventAssertionByAgentID_fkey" 
    FOREIGN KEY ("eventAssertionByAgentID") REFERENCES public.agent("agentID");

-- A Location may have zero or more LocationAssertions.
ALTER TABLE ONLY public.location_assertion
    ADD CONSTRAINT "location_assertion_locationID_fkey" 
    FOREIGN KEY ("locationID") REFERENCES public.location("locationID");
    
-- A LocationAssertion may be made by zero or one Agents.
ALTER TABLE ONLY public.location_assertion
    ADD CONSTRAINT "location_assertion_locationAssertionByAgentID_fkey" 
    FOREIGN KEY ("locationAssertionByAgentID") REFERENCES public.agent("agentID");

-- An Identification can be documented by zero or more IdentificationCitations.
ALTER TABLE ONLY public.identification_citation
    ADD CONSTRAINT "identification_citation_identificationID_fkey" 
    FOREIGN KEY ("identificationID") REFERENCES public.identification("identificationID");

-- An IdentificationCitation may cire zero or more References.
ALTER TABLE ONLY public.identification_citation
    ADD CONSTRAINT "identification_citation_referenceID_fkey" 
    FOREIGN KEY ("identificationReferenceID") REFERENCES public.reference("referenceID");

-- ----- ALTER core tables for properties ------
--
--CREATE TABLE public.collection (
--    "collectionID" character varying
--);
ALTER TABLE public.collection ADD "collectionCode" character varying;
ALTER TABLE public.collection ADD "institutionCode" character varying;

--CREATE TABLE public.digital_entity (
--    "digitalEntityID" character varying,
--    "digitalEntityType" character varying
--);
ALTER TABLE public.digital_entity ADD "accessURI" character varying;
ALTER TABLE public.digital_entity ADD "webStatement" character varying;
ALTER TABLE public.digital_entity ADD "format" character varying;
ALTER TABLE public.digital_entity ADD "license" character varying;
ALTER TABLE public.digital_entity ADD "accessRights" character varying;
ALTER TABLE public.digital_entity ADD "rightsHolder" character varying;

--CREATE TABLE public.entity (
--    "entityID" character varying,
--    "entityType" character varying
--);
ALTER TABLE public.entity ADD "entityRemarks" character varying;

--CREATE TABLE public.entity_event (
--    "entityID" character varying,
--    "eventID" character varying
--);
ALTER TABLE public.entity_event ADD "occurrenceStatus" character varying;
ALTER TABLE public.entity_event ADD "establishmentMeans" character varying;
ALTER TABLE public.entity_event ADD "pathway" character varying;
ALTER TABLE public.entity_event ADD "degreeOfEstablishment" character varying;
ALTER TABLE public.entity_event ADD "sex" character varying;
ALTER TABLE public.entity_event ADD "lifeStage" character varying;
ALTER TABLE public.entity_event ADD "reproductiveCondition" character varying;
ALTER TABLE public.entity_event ADD "behavior" character varying;
ALTER TABLE public.entity_event ADD "entityEventRemarks" character varying;

--CREATE TABLE public.entity_relationship (
--    "entityRelationshipID" character varying,
--    "dependsOnEntityRelationshipID" character varying,
--    "subjectEntityID" character varying,
--    "entityRelationshipType" character varying,
--    "objectEntityID" character varying,
--    "objectEntityIRI" character varying,
--    "entityRelationshipDate" character varying
--);

--CREATE TABLE public.event (
--    "eventID" character varying,
--    "parentEventID" character varying,
--    "eventType" character varying,
--    "locationID" character varying,
--    "protocolID" character varying,
--    "eventDate" character varying
--);
ALTER TABLE public.event ADD "verbatimEventDate" character varying;
ALTER TABLE public.event ADD "verbatimLocality" character varying;
ALTER TABLE public.event ADD "verbatimElevation" character varying;
ALTER TABLE public.event ADD "verbatimDepth" character varying;
ALTER TABLE public.event ADD "verbatimCoordinates" character varying;
ALTER TABLE public.event ADD "verbatimLatitude" character varying;
ALTER TABLE public.event ADD "verbatimLongitude" character varying;
ALTER TABLE public.event ADD "verbatimCoordinateSystem" character varying;
ALTER TABLE public.event ADD "verbatimSRS" character varying;
ALTER TABLE public.event ADD "protocolDescription" character varying;
ALTER TABLE public.event ADD "habitat" character varying;
ALTER TABLE public.event ADD "eventRemarks" character varying;
ALTER TABLE public.event ADD "eventEffort" character varying;

--CREATE TABLE public.genetic_sequence (
--    "geneticSequenceID" character varying,
--    "sequence" character varying,
--    "geneticSequenceType" character varying
--);

--CREATE TABLE public.geological_context (
--    "locationID" character varying
--);
ALTER TABLE public.geological_context ADD "geologicalContextID" character varying;
ALTER TABLE public.geological_context ADD "earliestEonOrLowestEonothem" character varying;
ALTER TABLE public.geological_context ADD "latestEonOrHighestEonothem" character varying;
ALTER TABLE public.geological_context ADD "earliestEraOrLowestErathem" character varying;
ALTER TABLE public.geological_context ADD "latestEraOrHighestErathem" character varying;
ALTER TABLE public.geological_context ADD "earliestPeriodOrLowestSystem" character varying;
ALTER TABLE public.geological_context ADD "latestPeriodOrHighestSystem" character varying;
ALTER TABLE public.geological_context ADD "earliestEpochOrLowestSeries" character varying;
ALTER TABLE public.geological_context ADD "latestEpochOrHighestSeries" character varying;
ALTER TABLE public.geological_context ADD "earliestAgeOrLowestStage" character varying;
ALTER TABLE public.geological_context ADD "latestAgeOrHighestStage" character varying;
ALTER TABLE public.geological_context ADD "lowestBiostratigraphicZone" character varying;
ALTER TABLE public.geological_context ADD "highestBiostratigraphicZone" character varying;
ALTER TABLE public.geological_context ADD "lithostratigraphicTerms" character varying;
ALTER TABLE public.geological_context ADD "group" character varying;
ALTER TABLE public.geological_context ADD "formation" character varying;
ALTER TABLE public.geological_context ADD "member" character varying;
ALTER TABLE public.geological_context ADD "bed" character varying;

--CREATE TABLE public.georeference (
--    "locationID" character varying
--);
ALTER TABLE public.georeference ADD "decimalLatitude" numeric;
ALTER TABLE public.georeference ADD "decimalLongitude" numeric;
ALTER TABLE public.georeference ADD "geodeticDatum" character varying;
ALTER TABLE public.georeference ADD "coordinateUncertaintyInMeters" numeric;
ALTER TABLE public.georeference ADD "coordinatePrecision" numeric;
ALTER TABLE public.georeference ADD "pointRadiusSpatialFit" numeric;
ALTER TABLE public.georeference ADD "footprintWKT" character varying;
ALTER TABLE public.georeference ADD "footprintSRS" character varying;
ALTER TABLE public.georeference ADD "footprintSpatialFit" numeric;
ALTER TABLE public.georeference ADD "georeferencedBy" character varying;
ALTER TABLE public.georeference ADD "georeferencedDate" character varying;
ALTER TABLE public.georeference ADD "georeferenceProtocol" character varying;
ALTER TABLE public.georeference ADD "georeferenceSources" character varying;
ALTER TABLE public.georeference ADD "georeferenceRemarks" character varying;
ALTER TABLE public.georeference ADD "preferredSpatialRepresentation" character varying;


--CREATE TABLE public.identification (
--    "identificationID" character varying,
--    "identificationType" character varying
--);
ALTER TABLE public.identification ADD "taxonFormula" character varying;
ALTER TABLE public.identification ADD "verbatimIdentification" character varying;
ALTER TABLE public.identification ADD "typeStatus" character varying;
ALTER TABLE public.identification ADD "dateIdentified" character varying;
ALTER TABLE public.identification ADD "identificationVerificationStatus" character varying;
ALTER TABLE public.identification ADD "identificationRemarks" character varying;
ALTER TABLE public.identification ADD "isAcceptedIdentification" boolean;

--CREATE TABLE public.identification_entity (
--    "identificationID" character varying,
--    "entityID" character varying
--);

--CREATE TABLE public.location (
--    "locationID" character varying,
--    "parentLocationID" character varying
--);
ALTER TABLE public.location ADD "higherGeographyID" character varying;
ALTER TABLE public.location ADD "higherGeography" character varying;
ALTER TABLE public.location ADD "continent" character varying;
ALTER TABLE public.location ADD "waterBody" character varying;
ALTER TABLE public.location ADD "islandGroup" character varying;
ALTER TABLE public.location ADD "island" character varying;
ALTER TABLE public.location ADD "country" character varying;
ALTER TABLE public.location ADD "countryCode" character varying;
ALTER TABLE public.location ADD "stateProvince" character varying;
ALTER TABLE public.location ADD "county" character varying;
ALTER TABLE public.location ADD "municipality" character varying;
ALTER TABLE public.location ADD "locality" character varying;
ALTER TABLE public.location ADD "minimumElevationInMeters" numeric;
ALTER TABLE public.location ADD "maximumElevationInMeters" numeric;
ALTER TABLE public.location ADD "verticalDatum" character varying;
ALTER TABLE public.location ADD "minimumDistanceAboveSurfaceInMeters" numeric;
ALTER TABLE public.location ADD "maximumDistanceAboveSurfaceInMeters" numeric;
ALTER TABLE public.location ADD "locationAccordingTo" character varying;
ALTER TABLE public.location ADD "locationRemarks" character varying;

--CREATE TABLE public.material_entity (
--    "materialEntityID" character varying,
--    "materialEntityType" character varying
--);

--CREATE TABLE public.material_group (
--    "materialGroupID" character varying,
--    "materialGroupType" character varying
--);

--CREATE TABLE public.organism (
--    "organismID" character varying,
--    "organismScope" character varying
--);
ALTER TABLE public.organism ADD "organismQuantity" character varying;
ALTER TABLE public.organism ADD "organismQuantityType" character varying;
ALTER TABLE public.organism ADD "organismName" character varying;

--CREATE TABLE public.protocol (
--    "protocolID" character varying,
--    "protocolType" character varying
--);

--CREATE TABLE public.sequence_taxon (
--    "taxonID" character varying,
--    "geneticSequenceID" character varying,
--    "sequenceTaxonAuthorityID" character varying
--);
ALTER TABLE public.sequence_taxon ADD "taxonConfidencePercent" numeric;

--CREATE TABLE public.taxon (
--    "taxonID" character varying,
--    "parentTaxonID" character varying,
--    "scientificName" character varying
--);
ALTER TABLE public.taxon ADD "scientificNameID" character varying;
ALTER TABLE public.taxon ADD "acceptedNameUsageID" character varying;
ALTER TABLE public.taxon ADD "parentNameUsageID" character varying;
ALTER TABLE public.taxon ADD "originalNameUsageID" character varying;
ALTER TABLE public.taxon ADD "taxonConceptID" character varying;
ALTER TABLE public.taxon ADD "acceptedNameUsage" character varying;
ALTER TABLE public.taxon ADD "parentNameUsage" character varying;
ALTER TABLE public.taxon ADD "originalNameUsage" character varying;
ALTER TABLE public.taxon ADD "higherClassification" character varying;
ALTER TABLE public.taxon ADD "kingdom" character varying;
ALTER TABLE public.taxon ADD "phylum" character varying;
ALTER TABLE public.taxon ADD "class" character varying;
ALTER TABLE public.taxon ADD "order" character varying;
ALTER TABLE public.taxon ADD "family" character varying;
ALTER TABLE public.taxon ADD "subfamily" character varying;
ALTER TABLE public.taxon ADD "genericName" character varying;
ALTER TABLE public.taxon ADD "subgenus" character varying;
ALTER TABLE public.taxon ADD "infragenericEpithet" character varying;
ALTER TABLE public.taxon ADD "specificEpithet" character varying;
ALTER TABLE public.taxon ADD "infraspecificEpithet" character varying;
ALTER TABLE public.taxon ADD "cultivarEpithet" character varying;
ALTER TABLE public.taxon ADD "taxonRank" character varying;
ALTER TABLE public.taxon ADD "verbatimTaxonRank" character varying;
ALTER TABLE public.taxon ADD "scientificNameAuthorship" character varying;
ALTER TABLE public.taxon ADD "vernacularName" character varying;
ALTER TABLE public.taxon ADD "nomenclaturalCode" character varying;
ALTER TABLE public.taxon ADD "taxonomicStatus" character varying;
ALTER TABLE public.taxon ADD "nomenclaturalStatus" character varying;
ALTER TABLE public.taxon ADD "taxonRemarks" character varying;

-- ----- ALTER common model tables for properties ------
--