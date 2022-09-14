--
-- Script to create core tables with minimal key and type properties once the database 
-- is created.
--
-- psql gum -f gum_create.sql
--
-- Core Table list:s   
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
    "collecionType" character varying
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