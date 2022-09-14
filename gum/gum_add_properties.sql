--
-- Script to add properties to core tables
--
-- psql gum -f gum_add_properties.sql
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
ALTER TABLE public.entity_event ADD "degreeOfEstablishment" character varying;
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
ALTER TABLE public.georeference ADD "footprintSRS" character varying;
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