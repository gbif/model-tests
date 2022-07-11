--
-- Script to create the tables once the database is created
-- psql ias_muskrats -f ias_muskrats_create.sql
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
    "accessURI" character varying,
    format character varying,
    "webStatement" character varying
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
    "eventID" character varying,
    "establishmentMeans" character varying,
    "pathway" character varying,
    "degreeOfEstablishment" character varying,
    "entityEventRemarks" character varying
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
    "externalObjectEntityID" character varying,
    "entityRelationshipRemarks" character varying
);

CREATE TABLE public.entity (
    "entityID" character varying,
    "entityType" character varying,
    "collectionID" character varying,
    "entityRemarks" character varying
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
    "eventAssertionType" character varying,
    "eventAssertionValue" character varying,
    "eventAssertionValueNumeric" numeric,
    "eventAssertionUnit" character varying,
    "eventAssertionByAgentID" character varying,
    "eventAssertionDate" character varying,
    "eventAssertionProtocol" character varying,
    "eventAssertionRemarks" character varying
);

CREATE TABLE public.event (
    "eventID" character varying,
    "locationID" character varying,
    "eventType" character varying,
    "eventDate" character varying,
    "parentEventID" character varying,
    "protocolID" character varying,
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

CREATE TABLE public.identification_entity (
    "identificationID" character varying,
    "entityID" character varying
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

CREATE TABLE public.material_entity (
    "materialEntityID" character varying,
    "materialEntityType" character varying
);

CREATE TABLE public.protocol (
    "protocolID" character varying,
    "protocolType" character varying
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
    "referencePeerReviewed" boolean
);

CREATE TABLE public.taxon_identification (
    "identificationID" character varying,
    "taxonID" character varying,
    "taxonOrder" character varying
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