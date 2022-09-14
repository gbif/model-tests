--
-- Script to create the common model tables once the database is created
--
-- psql gum -f gum_common_create.sql
--

-- Common Table list:
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
