
# GraphQL exploration

Exploring CSV using postgres and graphql.


## set up and start postgres
```
brew install postgres
postgres -D /usr/local/var/postgres
psql postgres
CREATE DATABASE arctos_v2;
```

## set up csvkit

```
sudo pip3 install csvkit
sudo pip3 install psycopg2 
```

## create tables
From ./arctos_v2/
```
> psql arctos_v2 -f arctos_v2_create.sql
```

## load into pg
```
> sh load_data.sh
```

## constraints for tables
From ./arctos_v2/
```
> psql arctos_v2 -f arctos_v2_constrain.sql
```

## setup the graphql server (I have node setup already)
```
npx postgraphile -c 'postgresql://localhost/arctos_v2' --watch --enhance-graphiql --dynamic-json --show-error-stack -p 7001 
```

http://localhost:7001/graphiql

NOTE: This needs to be modified to function with arctos_v2 - MaterialAssertions were aggregated into EntityAssertions.

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
