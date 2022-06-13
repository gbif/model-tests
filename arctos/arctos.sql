--
-- Script to create the tables once the database is created
-- psql arctos -f arctos.sql
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

CREATE TABLE public.collection (
    "collectionID" character varying,
    "institutionID" character varying,
    "institutionCode" character varying,
    "collectionCode" character varying
);

CREATE TABLE public.digital_entity (
    "digitalEntityID" character varying,
    "digitalEntityType" character varying,
    "collectionID" character varying,
    "accessURI" character varying,
    format character varying,
    "webStatement" character varying
);

CREATE TABLE public.digital_entity_assertion (
    "digitalEntityID" character varying,
    "digitalEntityAssertionType" character varying,
    "digitalEntityAssertionValue" character varying,
    "digitalEntityAssertionValueNumeric" numeric,
    "digitalEntityAssertionUnit" character varying,
    "digitalEntityAssertionByAgentID" character varying,
    "digitalEntityAssertionDate" character varying,
    "digitalEntityAssertionProtocol" character varying,
    "digitalEntityAssertionRemarks" character varying
);

CREATE TABLE public.entity (
    "entityID" character varying,
    "entityType" character varying
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
    "entityAssertionType" character varying,
    "entityAssertionValue" character varying,
    "entityAssertionValueNumeric" numeric,
    "entityAssertionUnit" character varying,
    "entityAssertionByAgentID" character varying,
    "entityAssertionDate" character varying,
    "entityAssertionProtocol" character varying,
    "entityAssertionRemarks" character varying
);

CREATE TABLE public.entity_event (
    "entityID" character varying,
    "eventID" character varying
);

CREATE TABLE public.entity_identifier (
    "entityID" character varying,
    "entityIdentifier" character varying,
    "entityIdentifierType" character varying
);

CREATE TABLE public.entity_relationship (
    "entityRelationshipID" character varying,
    "dependsOnEntityRelationshipID" character varying,
    "subjectEntityID" character varying,
    "entityRelationshipType" character varying,
    "objectEntityID" character varying,
    "externalObjectEntityID" character varying
);

CREATE TABLE public.event (
    "eventID" character varying,
    "locationID" character varying,
    "eventType" character varying,
    "eventDate" character varying,
    "verbatimEventDate" character varying,
    "verbatimLocality" character varying,
    "verbatimElevation" character varying,
    "verbatimDepth" character varying,
    "verbatimCoordinates" character varying,
    "verbatimLatitude" character varying,
    "verbatimLongitude" character varying,
    "verbatimCoordinateSystem" character varying,
    "verbatimSRS" character varying,
    "eventRemarks" character varying,
    "protocolDescription" character varying,
    habitat character varying
);

CREATE TABLE public.georeference (
    "locationID" character varying,
    "decimalLatitude" numeric,
    "decimalLongitude" numeric,
    "geodeticDatum" character varying,
    "coordinateUncertaintyInMeters" numeric,
    "coordinatePrecision" numeric,
    "pointRadiusSpatialFit" numeric,
    "footprintWKT" character varying,
    "footprintSRS" character varying,
    "footprintSpatialFit" numeric,
    "georeferencedBy" character varying,
    "georeferencedDate" character varying,
    "georeferenceProtocol" character varying,
    "georeferenceSources" character varying,
    "georeferenceRemarks" character varying,
    "preferredSpatialRepresentation" character varying
);

CREATE TABLE public.identification (
    "identificationID" character varying,
    "identificationType" character varying,
    "taxaFormula" character varying,
    "verbatimIdentification" character varying,
    "identificationQualifier" character varying,
    "typeStatus" character varying,
    "dateIdentified" character varying,
    "identificationVerificationStatus" character varying,
    "identificationRemarks" character varying,
    "isAcceptedIdentification" boolean
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
    "referenceID" character varying,
    "citationType" character varying,
    "citationPageNumber" character varying,
    "citationRemarks" character varying
);

CREATE TABLE public.identification_material (
    "identificationID" character varying,
    "materialEntityID" character varying
);

CREATE TABLE public.location (
    "locationID" character varying,
    "higherGeographyID" character varying,
    "higherGeography" character varying,
    continent character varying,
    "waterBody" character varying,
    "islandGroup" character varying,
    island character varying,
    country character varying,
    "countryCode" character varying,
    "stateProvince" character varying,
    county character varying,
    municipality character varying,
    locality character varying,
    "minimumElevationInMeters" numeric,
    "maximumElevationInMeters" numeric,
    "verticalDatum" character varying,
    "minimumDepthInMeters" numeric,
    "maximumDepthInMeters" numeric,
    "minimumDistanceAboveSurfaceInMeters" numeric,
    "maximumDistanceAboveSurfaceInMeters" numeric,
    "locationAccordingTo" character varying,
    "locationRemarks" character varying
);

CREATE TABLE public.location_assertion (
    "locationID" character varying,
    "locationAssertionType" character varying,
    "locationAssertionValue" character varying,
    "locationAssertionValueNumeric" numeric,
    "locationAssertionUnit" character varying,
    "locationAssertionByAgentID" character varying,
    "locationAssertionDate" character varying,
    "locationAssertionProtocol" character varying,
    "locationAssertionRemarks" character varying
);

CREATE TABLE public.material_entity (
    "materialEntityID" character varying,
    "materialEntityType" character varying,
    "collectionID" character varying
);

CREATE TABLE public.material_entity_assertion (
    "materialEntityID" character varying,
    "materialEntityAssertionType" character varying,
    "materialEntityAssertionValue" character varying,
    "materialEntityAssertionValueNumeric" numeric,
    "materialEntityAssertionUnit" character varying,
    "materialEntityAssertionByAgentID" character varying,
    "materialEntityAssertionDate" character varying,
    "materialEntityAssertionProtocol" character varying,
    "materialEntityAssertionRemarks" character varying
);

CREATE TABLE public.reference_agent_role (
    "referenceID" character varying,
    "agentID" character varying,
    "referenceAgentRole" character varying,
    "referenceAgentRoleBegan" character varying,
    "referenceAgentRoleEnded" character varying,
    "referenceAgentRoleOrder" integer
);

CREATE TABLE public."references" (
    "referenceID" character varying,
    "referenceType" character varying,
    "bibliographicCitation" character varying,
    "referenceYear" integer,
    "referenceDOI" character varying,
    "referencePeerReviewed" boolean
);

CREATE TABLE public.taxon (
    "taxonID" character varying,
    "parentTaxonID" character varying,
    "scientificName" character varying,
    "nomenclaturalCode" character varying,
    "taxonRank" character varying,
    kingdom character varying,
    phylum character varying,
    class character varying,
    "order" character varying,
    family character varying,
    subfamily character varying,
    "genericName" character varying,
    "specificEpithet" character varying,
    "infraspecificEpithet" character varying,
    "scientifcNameAuthorship" character varying
);

CREATE TABLE public.taxon_identification (
    "identificationID" character varying,
    "taxonID" character varying,
    "taxonOrder" character varying
);

ALTER TABLE ONLY public.agent
    ADD CONSTRAINT pk_agent UNIQUE ("agentID");

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

ALTER TABLE ONLY public.identification
    ADD CONSTRAINT pk_identification UNIQUE ("identificationID");

ALTER TABLE ONLY public.location
    ADD CONSTRAINT pk_location UNIQUE ("locationID");

ALTER TABLE ONLY public.material_entity
    ADD CONSTRAINT pk_material_entity UNIQUE ("materialEntityID");

ALTER TABLE ONLY public."references"
    ADD CONSTRAINT pk_references UNIQUE ("referenceID");

ALTER TABLE ONLY public.taxon
    ADD CONSTRAINT pk_taxon UNIQUE ("taxonID");

ALTER TABLE ONLY public.agent_identifier
    ADD CONSTRAINT "agent_identifier_agentID_fkey" FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

ALTER TABLE ONLY public.digital_entity_assertion
    ADD CONSTRAINT "digital_entity_assertion_digitalEntityID_fkey" FOREIGN KEY ("digitalEntityID") REFERENCES public.digital_entity("digitalEntityID");

ALTER TABLE ONLY public.digital_entity_assertion
    ADD CONSTRAINT "digital_entityy_assertion_digitalEntityAssertionByAgentID_fkey" FOREIGN KEY ("digitalEntityAssertionByAgentID") REFERENCES public.agent("agentID");

ALTER TABLE ONLY public.digital_entity
    ADD CONSTRAINT "digital_entity_collectionID_fkey" FOREIGN KEY ("collectionID") REFERENCES public.collection("collectionID");

ALTER TABLE ONLY public.digital_entity
    ADD CONSTRAINT "digital_entity_digitalEntityID_fkey" FOREIGN KEY ("digitalEntityID") REFERENCES public.entity("entityID");

ALTER TABLE ONLY public.entity_agent_role
    ADD CONSTRAINT "entity_agent_role_agentID_fkey" FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

ALTER TABLE ONLY public.entity_agent_role
    ADD CONSTRAINT "entity_agent_role_entityID_fkey" FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

ALTER TABLE ONLY public.entity_assertion
    ADD CONSTRAINT "entity_assertion_entityID_fkey" FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

ALTER TABLE ONLY public.entity_assertion
    ADD CONSTRAINT "entity_assertion_entityAssertionByAgentID_fkey" FOREIGN KEY ("entityAssertionByAgentID") REFERENCES public.agent("agentID");

ALTER TABLE ONLY public.entity_event
    ADD CONSTRAINT "entity_event_entityID_fkey" FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

ALTER TABLE ONLY public.entity_event
    ADD CONSTRAINT "entity_event_eventID_fkey" FOREIGN KEY ("eventID") REFERENCES public.event("eventID");

ALTER TABLE ONLY public.entity_identifier
    ADD CONSTRAINT "entity_identifier_entityID_fkey" FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

ALTER TABLE ONLY public.entity_relationship
    ADD CONSTRAINT "entity_relationship_dependsOnEntityRelationshipID_fkey" FOREIGN KEY ("dependsOnEntityRelationshipID") REFERENCES public.entity_relationship("entityRelationshipID");

ALTER TABLE ONLY public.entity_relationship
    ADD CONSTRAINT "entity_relationship_objectEntityID_fkey" FOREIGN KEY ("objectEntityID") REFERENCES public.entity("entityID");

ALTER TABLE ONLY public.entity_relationship
    ADD CONSTRAINT "entity_relationship_subjectEntityID_fkey" FOREIGN KEY ("subjectEntityID") REFERENCES public.entity("entityID");

ALTER TABLE ONLY public.event
    ADD CONSTRAINT "event_locationID_fkey" FOREIGN KEY ("locationID") REFERENCES public.location("locationID");

ALTER TABLE ONLY public.georeference
    ADD CONSTRAINT "georeference_locationID_fkey" FOREIGN KEY ("locationID") REFERENCES public.location("locationID");

ALTER TABLE ONLY public.identification_agent_role
    ADD CONSTRAINT "identification_agent_role_agentID_fkey" FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

ALTER TABLE ONLY public.identification_agent_role
    ADD CONSTRAINT "identification_agent_role_identificationID_fkey" FOREIGN KEY ("identificationID") REFERENCES public.identification("identificationID");

ALTER TABLE ONLY public.identification_citation
    ADD CONSTRAINT "identification_citation_identificationID_fkey" FOREIGN KEY ("identificationID") REFERENCES public.identification("identificationID");

ALTER TABLE ONLY public.identification_citation
    ADD CONSTRAINT "identification_citation_referenceID_fkey" FOREIGN KEY ("referenceID") REFERENCES public."references"("referenceID");

ALTER TABLE ONLY public.identification_material
    ADD CONSTRAINT "identification_material_identificationID_fkey" FOREIGN KEY ("identificationID") REFERENCES public.identification("identificationID");

ALTER TABLE ONLY public.identification_material
    ADD CONSTRAINT "identification_material_materialEntityID_fkey" FOREIGN KEY ("materialEntityID") REFERENCES public.material_entity("materialEntityID");

ALTER TABLE ONLY public.location_assertion
    ADD CONSTRAINT "location_assertion_locationID_fkey" FOREIGN KEY ("locationID") REFERENCES public.location("locationID");

ALTER TABLE ONLY public.material_entity_assertion
    ADD CONSTRAINT "material_entity_assertion_materialEntityID_fkey" FOREIGN KEY ("materialEntityID") REFERENCES public.material_entity("materialEntityID");

ALTER TABLE ONLY public.material_entity_assertion
    ADD CONSTRAINT "material_entity_assertion_materialEntityAssertionByAgentID_fkey" FOREIGN KEY ("materialEntityAssertionByAgentID") REFERENCES public.agent("agentID");

ALTER TABLE ONLY public.material_entity
    ADD CONSTRAINT "material_entity_collectionID_fkey" FOREIGN KEY ("collectionID") REFERENCES public.collection("collectionID");

ALTER TABLE ONLY public.material_entity
    ADD CONSTRAINT "material_entity_materialEntityID_fkey" FOREIGN KEY ("materialEntityID") REFERENCES public.entity("entityID");

ALTER TABLE ONLY public.reference_agent_role
    ADD CONSTRAINT "reference_agent_role_agentID_fkey" FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

ALTER TABLE ONLY public.reference_agent_role
    ADD CONSTRAINT "reference_agent_role_referenceID_fkey" FOREIGN KEY ("referenceID") REFERENCES public."references"("referenceID");

