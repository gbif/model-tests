
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
> psql arctos -f arctos.sql   
```

## load into pg (order here is important for FKs)
```
csvsql --db postgresql:///arctos --no-create --insert ./files/agent.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/entity.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/location.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/georeference.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/event.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/collection.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/references.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/digital_entity.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/material_entity.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/agent_identifier.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/entity_identifier.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/entity_assertion.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/digital_entity_assertion.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/material_entity_assertion.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/location_assertion.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/entity_agent_role.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/entity_relationship.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/entity_event.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/identification.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/identification_agent_role.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/identification_citation.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/identification_material.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/reference_agent_role.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/taxon.csv
csvsql --db postgresql:///arctos --no-create --insert ./files/taxon_identification.csv
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
