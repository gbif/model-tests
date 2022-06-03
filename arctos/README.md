
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

## load into pg
```
csvsql --db postgresql:///arctos --insert ./files/agent.csv
csvsql --db postgresql:///arctos --insert ./files/agent_identifier.csv
csvsql --db postgresql:///arctos --insert ./files/collection.csv
csvsql --db postgresql:///arctos --insert ./files/digital_entity.csv
csvsql --db postgresql:///arctos --insert ./files/digital_entity_assertion.csv
csvsql --db postgresql:///arctos --insert ./files/entity_assertion.csv
csvsql --db postgresql:///arctos --insert ./files/entity_of_interest.csv
csvsql --db postgresql:///arctos --insert ./files/entity_of_interest_agent_role.csv
csvsql --db postgresql:///arctos --insert ./files/entity_of_interest_event.csv
csvsql --db postgresql:///arctos --insert ./files/entity_of_interest_identifier.csv
csvsql --db postgresql:///arctos --insert ./files/entity_relationship.csv
csvsql --db postgresql:///arctos --insert ./files/event.csv
csvsql --db postgresql:///arctos --insert ./files/georeference.csv
csvsql --db postgresql:///arctos --insert ./files/identification.csv
csvsql --db postgresql:///arctos --insert ./files/identification_agent_role.csv
csvsql --db postgresql:///arctos --insert ./files/identification_citation.csv
csvsql --db postgresql:///arctos --insert ./files/identification_material.csv
csvsql --db postgresql:///arctos --insert ./files/location.csv
csvsql --db postgresql:///arctos --insert ./files/location_assertion.csv
csvsql --db postgresql:///arctos --insert ./files/material_entity.csv
csvsql --db postgresql:///arctos --insert ./files/material_entity_assertion.csv
csvsql --db postgresql:///arctos --insert ./files/reference_agent_role.csv
csvsql --db postgresql:///arctos --insert ./files/references.csv
```

## add unique and foreign keys
```
> psql arctos    

ALTER TABLE agent ADD CONSTRAINT pk_agent UNIQUE ("agentID");
ALTER TABLE collection ADD CONSTRAINT pk_collection UNIQUE ("collectionID");
ALTER TABLE digital_entity ADD CONSTRAINT pk_digital_entity UNIQUE ("digitalEntityID");
ALTER TABLE entity_of_interest ADD CONSTRAINT pk_entity UNIQUE ("entityID");
ALTER TABLE entity_relationship ADD CONSTRAINT pk_entity_relationshipID UNIQUE ("entityRelationshipID");
ALTER TABLE event ADD CONSTRAINT pk_event UNIQUE ("eventID");
	ALTER TABLE identification ADD CONSTRAINT pk_identification UNIQUE ("identificationID");
ALTER TABLE location ADD CONSTRAINT pk_location UNIQUE ("locationID");
ALTER TABLE material_entity ADD CONSTRAINT pk_material_entity UNIQUE ("materialEntityID");
ALTER TABLE "references" ADD CONSTRAINT pk_references UNIQUE ("referenceID");

ALTER TABLE agent_identifier ADD CONSTRAINT fk_agent FOREIGN KEY ("agentID") REFERENCES agent ("agentID");
ALTER TABLE digital_entity_assertion ADD CONSTRAINT fk_digital_entity FOREIGN KEY ("digitalEntityID") REFERENCES digital_entity ("digitalEntityID");
ALTER TABLE entity_assertion ADD CONSTRAINT fk_entity_of_interest FOREIGN KEY ("entityID") REFERENCES entity_of_interest ("entityID");
ALTER TABLE entity_of_interest_agent_role ADD CONSTRAINT fk_eoiar_entity FOREIGN KEY ("entityID") REFERENCES entity_of_interest ("entityID");
ALTER TABLE entity_of_interest_agent_role ADD CONSTRAINT fk_eoiar_agent FOREIGN KEY ("agentID") REFERENCES agent ("agentID");
ALTER TABLE entity_of_interest_event ADD CONSTRAINT fk_entity_of_interest_event_event FOREIGN KEY ("eventID") REFERENCES event ("eventID");
ALTER TABLE entity_of_interest_event ADD CONSTRAINT fk_entity_of_interest_event_entity FOREIGN KEY ("entityID") REFERENCES entity_of_interest ("entityID");
ALTER TABLE entity_of_interest_identifier ADD CONSTRAINT fk_entity_of_interest_identifier_entity FOREIGN KEY ("entityID") REFERENCES entity_of_interest ("entityID");
ALTER TABLE entity_relationship ADD CONSTRAINT fk_entity_relationship_depends FOREIGN KEY ("dependsOnEntityRelationshipID") REFERENCES entity_relationship ("entityRelationshipID");
	ALTER TABLE entity_relationship ADD CONSTRAINT fk_entity_relationship_subject FOREIGN KEY ("subjectEntityID") REFERENCES entity_of_interest ("entityID");
	ALTER TABLE entity_relationship ADD CONSTRAINT fk_entity_relationship_object FOREIGN KEY ("objectEntityID") REFERENCES entity_of_interest ("entityID");
ALTER TABLE event ADD CONSTRAINT fk_event_location FOREIGN KEY ("locationID") REFERENCES location ("locationID");
ALTER TABLE georeference ADD CONSTRAINT fk_georeference_location FOREIGN KEY ("locationID") REFERENCES location ("locationID");
	ALTER TABLE identification_agent_role ADD CONSTRAINT fk_identification_agent_role_identification FOREIGN KEY ("identificationID") REFERENCES identification ("identificationID");
	ALTER TABLE identification_agent_role ADD CONSTRAINT fk_identification_agent_role_agent FOREIGN KEY ("agentID") REFERENCES agent ("agentID");	
	ALTER TABLE identification_citation ADD CONSTRAINT fk_identification_citation_identification FOREIGN KEY ("identificationID") REFERENCES identification ("identificationID");	
ALTER TABLE identification_citation ADD CONSTRAINT fk_identification_citation_references FOREIGN KEY ("identificationCitationReferenceID") REFERENCES "references" ("referenceID");		
	ALTER TABLE identification_material ADD CONSTRAINT fk_identification_material_identification FOREIGN KEY ("identificationID") REFERENCES identification ("identificationID");	
ALTER TABLE identification_material ADD CONSTRAINT fk_identification_material_material FOREIGN KEY ("materialEntityID") REFERENCES material_entity ("materialEntityID");		
ALTER TABLE location_assertion ADD CONSTRAINT fk_location_assertion_location FOREIGN KEY ("locationID") REFERENCES location ("locationID");		
ALTER TABLE material_entity ADD CONSTRAINT fk_material_entity_collection FOREIGN KEY ("collectionID") REFERENCES collection ("collectionID");
ALTER TABLE material_entity_assertion ADD CONSTRAINT fk_material_entity FOREIGN KEY ("materialEntityID") REFERENCES material_entity ("materialEntityID");
ALTER TABLE reference_agent_role ADD CONSTRAINT fk_reference_agent_role_reference FOREIGN KEY ("referenceID") REFERENCES "references" ("referenceID");
ALTER TABLE reference_agent_role ADD CONSTRAINT fk_reference_agent_role_agent FOREIGN KEY ("agentID") REFERENCES agent ("agentID");	


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
