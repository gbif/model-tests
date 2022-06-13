
# GraphQL exploration

Exploring CSV using postgres and graphql.


## set up and start postgres
```
brew install postgres
postgres -D /usr/local/var/postgres
psql postgres
CREATE DATABASE arctos;
```

## set up csvkit

```
sudo pip3 install csvkit
sudo pip3 install psycopg2 
```

## create tables
```
> psql arctos    
CREATE TABLE IF NOT EXISTS agent_identifier ("agentID" character varying, "agentIdentifier" character varying, "agentIdentifierType" character varying);
CREATE TABLE IF NOT EXISTS agent ("agentID" character varying, "agentType" character varying, "preferredAgentName" character varying);
CREATE TABLE IF NOT EXISTS collection("collectionID" character varying, "institutionID" character varying, "institutionCode" character varying, "collectionCode" character varying);
CREATE TABLE IF NOT EXISTS digital_entity_assertion ("digitalEntityID" character varying, "digitalEntityAssertionType" character varying, "digitalEntityAssertionValue" character varying, "digitalEntityAssertionValueNumeric" numeric, "digitalEntityAssertionUnit" character varying, "digitalEntityAssertionByAgentID" character varying, "digitalEntityAssertionDate" character varying, "digitalEntityAssertionProtocol" character varying, "digitalEntityAssertionRemarks" character varying);
CREATE TABLE IF NOT EXISTS digital_entity ("digitalEntityID" character varying, "digitalEntityType" character varying, "collectionID" character varying, "accessURI" character varying, "format" character varying, "webStatement" character varying);
CREATE TABLE IF NOT EXISTS entity_agent_role ("entityID" character varying, "agentID" character varying, "entityAgentRole" character varying, "entityAgentRoleBegan" character varying, "entityAgentRoleEnded" character varying, "entityAgentRoleOrder" integer);
CREATE TABLE IF NOT EXISTS entity_assertion ("entityID" character varying, "entityAssertionType" character varying, "entityAssertionValue" character varying, "entityAssertionValueNumeric" numeric, "entityAssertionUnit" character varying, "entityAssertionByAgentID" character varying, "entityAssertionDate" character varying, "entityAssertionProtocol" character varying, "entityAssertionRemarks" character varying);
CREATE TABLE IF NOT EXISTS entity_event ("entityID" character varying, "eventID" character varying);
CREATE TABLE IF NOT EXISTS entity_identifier ("entityID" character varying, "entityIdentifier" character varying, "entityIdentifierType" character varying);
CREATE TABLE IF NOT EXISTS entity_relationship ("entityRelationshipID" character varying, "dependsOnEntityRelationshipID" character varying, "subjectEntityID" character varying, "entityRelationshipType" character varying, "objectEntityID" character varying, "externalObjectEntityID" character varying);
CREATE TABLE IF NOT EXISTS entity ("entityID" character varying, "entityType" character varying);
CREATE TABLE IF NOT EXISTS event ("eventID" character varying, "locationID" character varying, "eventType" character varying, "eventDate" character varying, "verbatimEventDate" character varying, "verbatimLocality" character varying, "verbatimElevation" character varying, "verbatimDepth" character varying, "verbatimCoordinates" character varying, "verbatimLatitude" character varying, "verbatimLongitude" character varying, "verbatimCoordinateSystem" character varying, "verbatimSRS" character varying, "eventRemarks" character varying, "protocolDescription" character varying, "habitat" character varying);
CREATE TABLE IF NOT EXISTS georeference ("locationID" character varying, "decimalLatitude" numeric, "decimalLongitude" numeric, "geodeticDatum" character varying, "coordinateUncertaintyInMeters" numeric, "coordinatePrecision" numeric, "pointRadiusSpatialFit" numeric, "footprintWKT" character varying, "footprintSRS" character varying, "footprintSpatialFit" numeric, "georeferencedBy" character varying, "georeferencedDate" character varying, "georeferenceProtocol" character varying, "georeferenceSources" character varying, "georeferenceRemarks" character varying, "preferredSpatialRepresentation" character varying);
CREATE TABLE IF NOT EXISTS identification_agent_role ("identificationID" character varying, "agentID" character varying, "identificationAgentRole" character varying, "identificationAgentRoleBegan" character varying, "identificationAgentRoleEnded" character varying, "identificationAgentRoleOrder" integer);
CREATE TABLE IF NOT EXISTS identification_citation ("identificationID" character varying, "referenceID" character varying, "citationType" character varying, "citationPageNumber" character varying, "citationRemarks" character varying);
CREATE TABLE IF NOT EXISTS identification_material ("identificationID" character varying, "materialEntityID" character varying);
CREATE TABLE IF NOT EXISTS identification ("identificationID" character varying, "identificationType" character varying, "taxaFormula" character varying, "verbatimIdentification" character varying, "identificationQualifier" character varying, "typeStatus" character varying, "dateIdentified" character varying, "identificationVerificationStatus" character varying, "identificationRemarks" character varying, "isAcceptedIdentification" boolean);
CREATE TABLE IF NOT EXISTS location_assertion ("locationID" character varying, "locationAssertionType" character varying, "locationAssertionValue" character varying, "locationAssertionValueNumeric" numeric, "locationAssertionUnit" character varying, "locationAssertionByAgentID" character varying, "locationAssertionDate" character varying, "locationAssertionProtocol" character varying, "locationAssertionRemarks" character varying);
CREATE TABLE IF NOT EXISTS location ("locationID" character varying, "higherGeographyID" character varying, "higherGeography" character varying, "continent" character varying, "waterBody" character varying, "islandGroup" character varying, "island" character varying, "country" character varying, "countryCode" character varying, "stateProvince" character varying, "county" character varying, "municipality" character varying, "locality" character varying, "minimumElevationInMeters" numeric, "maximumElevationInMeters" numeric, "verticalDatum" character varying, "minimumDepthInMeters" numeric, "maximumDepthInMeters" numeric, "minimumDistanceAboveSurfaceInMeters" numeric, "maximumDistanceAboveSurfaceInMeters" numeric, "locationAccordingTo" character varying, "locationRemarks" character varying);
CREATE TABLE IF NOT EXISTS material_entity_assertion ("materialEntityID" character varying, "materialEntityAssertionType" character varying, "materialEntityAssertionValue" character varying, "materialEntityAssertionValueNumeric" numeric, "materialEntityAssertionUnit" character varying, "materialEntityAssertionByAgentID" character varying, "materialEntityAssertionDate" character varying, "materialEntityAssertionProtocol" character varying, "materialEntityAssertionRemarks" character varying);
CREATE TABLE IF NOT EXISTS material_entity ("materialEntityID" character varying, "materialEntityType" character varying, "collectionID" character varying);
CREATE TABLE IF NOT EXISTS reference_agent_role ("referenceID" character varying, "agentID" character varying, "referenceAgentRole" character varying, "referenceAgentRoleBegan" character varying, "referenceAgentRoleEnded" character varying, "referenceAgentRoleOrder" integer);
CREATE TABLE IF NOT EXISTS "references" ("referenceID" character varying, "referenceType" character varying, "bibliographicCitation" character varying, "referenceYear" integer, "referenceDOI" character varying, "referencePeerReviewed" boolean);
CREATE TABLE IF NOT EXISTS taxon_identification ("identificationID" character varying, "taxonID" character varying, "taxonOrder" character varying);
CREATE TABLE IF NOT EXISTS taxon ("taxonID" character varying, "parentTaxonID" character varying, "scientificName" character varying, "nomenclaturalCode" character varying, "taxonRank" character varying, "kingdom" character varying, "phylum" character varying, "class" character varying, "order" character varying, "family" character varying, "subfamily" character varying, "genericName" character varying, "specificEpithet" character varying, "infraspecificEpithet" character varying, "scientifcNameAuthorship" character varying);
```

## load into pg
```
csvsql --db postgresql:///arctos --no-create --insert ./files/agent.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/agent_identifier.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/collection.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/digital_entity.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/digital_entity_assertion.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/entity.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/entity_agent_role.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/entity_assertion.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/entity_event.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/entity_identifier.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/entity_relationship.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/event.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/georeference.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/identification.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/identification_agent_role.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/identification_citation.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/identification_material.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/location.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/location_assertion.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/material_entity.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/material_entity_assertion.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/reference_agent_role.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/references.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/taxon.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/taxon_identification.csv
```

## add unique and foreign keys
```
> psql arctos    

ALTER TABLE agent ADD CONSTRAINT pk_agent UNIQUE ("agentID");
ALTER TABLE collection ADD CONSTRAINT pk_collection UNIQUE ("collectionID");
ALTER TABLE digital_entity ADD CONSTRAINT pk_digital_entity UNIQUE ("digitalEntityID");
ALTER TABLE entity ADD CONSTRAINT pk_entity UNIQUE ("entityID");
ALTER TABLE entity_relationship ADD CONSTRAINT pk_entity_relationshipID UNIQUE ("entityRelationshipID");
ALTER TABLE event ADD CONSTRAINT pk_event UNIQUE ("eventID");
ALTER TABLE identification ADD CONSTRAINT pk_identification UNIQUE ("identificationID");
ALTER TABLE location ADD CONSTRAINT pk_location UNIQUE ("locationID");
ALTER TABLE material_entity ADD CONSTRAINT pk_material_entity UNIQUE ("materialEntityID");
ALTER TABLE "references" ADD CONSTRAINT pk_references UNIQUE ("referenceID");
ALTER TABLE taxon ADD CONSTRAINT pk_taxon UNIQUE ("taxonID");

ALTER TABLE agent_identifier ADD FOREIGN KEY ("agentID") REFERENCES agent ("agentID");
ALTER TABLE reference_agent_role ADD FOREIGN KEY ("agentID") REFERENCES agent ("agentID");
ALTER TABLE reference_agent_role ADD FOREIGN KEY ("referenceID") REFERENCES "references" ("referenceID");
ALTER TABLE entity_agent_role ADD FOREIGN KEY ("agentID") REFERENCES agent ("agentID");
ALTER TABLE identification_agent_role ADD FOREIGN KEY ("agentID") REFERENCES agent ("agentID");
ALTER TABLE location_assertion ADD FOREIGN KEY ("locationID") REFERENCES location ("locationID");
ALTER TABLE event ADD FOREIGN KEY ("locationID") REFERENCES location ("locationID");
ALTER TABLE georeference ADD FOREIGN KEY ("locationID") REFERENCES location ("locationID");
ALTER TABLE entity_event ADD FOREIGN KEY ("eventID") REFERENCES event ("eventID");

ALTER TABLE entity_assertion ADD FOREIGN KEY ("entityID") REFERENCES entity ("entityID");
ALTER TABLE entity_agent_role ADD FOREIGN KEY ("entityID") REFERENCES entity ("entityID");
ALTER TABLE entity_event ADD FOREIGN KEY ("entityID") REFERENCES entity ("entityID");
ALTER TABLE entity_identifier ADD FOREIGN KEY ("entityID") REFERENCES entity ("entityID");
ALTER TABLE entity_relationship ADD FOREIGN KEY ("subjectEntityID") REFERENCES entity ("entityID");
ALTER TABLE entity_relationship ADD FOREIGN KEY ("objectEntityID") REFERENCES entity ("entityID");
ALTER TABLE entity_relationship ADD FOREIGN KEY ("dependsOnEntityRelationshipID") REFERENCES entity_relationship ("entityRelationshipID");

ALTER TABLE digital_entity ADD FOREIGN KEY ("digitalEntityID") REFERENCES entity ("entityID");
ALTER TABLE digital_entity ADD FOREIGN KEY ("collectionID") REFERENCES collection ("collectionID");
ALTER TABLE digital_entity_assertion ADD FOREIGN KEY ("digitalEntityID") REFERENCES digital_entity ("digitalEntityID");

ALTER TABLE material_entity ADD FOREIGN KEY ("materialEntityID") REFERENCES entity ("entityID");
ALTER TABLE material_entity ADD FOREIGN KEY ("collectionID") REFERENCES collection ("collectionID");
ALTER TABLE material_entity_assertion ADD FOREIGN KEY ("materialEntityID") REFERENCES material_entity ("materialEntityID");

ALTER TABLE identification_agent_role ADD FOREIGN KEY ("identificationID") REFERENCES identification ("identificationID");
ALTER TABLE identification_citation ADD FOREIGN KEY ("identificationID") REFERENCES identification ("identificationID");
ALTER TABLE identification_citation ADD FOREIGN KEY ("referenceID") REFERENCES "references" ("referenceID");
ALTER TABLE identification_material ADD FOREIGN KEY ("identificationID") REFERENCES identification ("identificationID");
ALTER TABLE identification_material ADD FOREIGN KEY ("materialEntityID") REFERENCES material_entity ("materialEntityID");
```

## setup the graphql server (I have node setup already)
```
npx postgraphile -c 'postgresql://localhost/arctos' --watch --enhance-graphiql --dynamic-json --show-error-stack -p 7001 
```

http://localhost:7001/graphiql

Run a query:

```
query material_with_assertions {
  allMaterialEntities {
    nodes {
      collectionId
      materialEntityId
      materialEntityType
      materialEntityAssertionsByMaterialEntityId {
        nodes {
          materialEntityAssertionByAgentId
          materialEntityAssertionDate
          materialEntityAssertionProtocol
          materialEntityAssertionRemarks
          materialEntityAssertionType
          materialEntityAssertionUnit
          materialEntityAssertionValue
          materialEntityAssertionValueNumeric
          materialEntityId
        }
      }
    }
  }
}



{
  "data": {
    "allMaterialEntities": {
      "nodes": [
        {
          "collectionId": "https://arctos.database.museum/collection/DMNS:Mamm",
          "materialEntityId": "21714980",
          "materialEntityType": "dwc:Organism",
          "materialEntityAssertionsByMaterialEntityId": {
            "nodes": []
          }
        },
        {
          "collectionId": "https://arctos.database.museum/collection/DMNS:Mamm",
          "materialEntityId": "21714987",
          "materialEntityType": "baculum",
          "materialEntityAssertionsByMaterialEntityId": {
            "nodes": []
          }
        },
        {
          "collectionId": "https://arctos.database.museum/collection/DMNS:Mamm",
          "materialEntityId": "21714983",
          "materialEntityType": "heart, kidney",
          "materialEntityAssertionsByMaterialEntityId": {
            "nodes": [
              {
                "materialEntityAssertionByAgentId": null,
                "materialEntityAssertionDate": "2021-07-01",
                "materialEntityAssertionProtocol": null,
                "materialEntityAssertionRemarks": "Added from original part heart, kidney (frozen).",
                "materialEntityAssertionType": "preservation",
                "materialEntityAssertionUnit": null,
                "materialEntityAssertionValue": "frozen",
                "materialEntityAssertionValueNumeric": null,
                "materialEntityId": "21714983"
              }
            ]
          }
        },
        {
          "collectionId": "https://arctos.database.museum/collection/DMNS:Mamm",
          "materialEntityId": "21714984",
          "materialEntityType": "liver",
          "materialEntityAssertionsByMaterialEntityId": {
            "nodes": [
              {
                "materialEntityAssertionByAgentId": null,
                "materialEntityAssertionDate": "2021-07-01",
                "materialEntityAssertionProtocol": null,
                "materialEntityAssertionRemarks": "Added from original part liver (frozen).",
                "materialEntityAssertionType": "preservation",
                "materialEntityAssertionUnit": null,
                "materialEntityAssertionValue": "frozen",
                "materialEntityAssertionValueNumeric": null,
                "materialEntityId": "21714984"
              }
            ]
          }
        },
   ...
```
