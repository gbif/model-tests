
# GraphQL exploration

Exploring CSV using postgres and graphql.


## set up and start postgres
```
brew install postgres
postgres -D /usr/local/var/postgres
psql postgres
CREATE DATABASE ias_muskrats;
```

## set up csvkit

```
sudo pip3 install csvkit
sudo pip3 install psycopg2 
```

## create tables
From ./ias_muskrats/
```
> psql ias_muskrats -f ias_muskrats_create.sql
```

## load into pg
```
> sh load_data.sh
```

## constraints for tables
From ./ias_muskrats/
```
> psql ias_muskrats -f ias_muskrats_constrain.sql
```

## NOTE: From here down needs to be updated for an appropriate query
## setup the graphql server (I have node setup already)
```
npx postgraphile -c 'postgresql://localhost/ias_muskrats' --watch --enhance-graphiql --dynamic-json --show-error-stack -p 7001 
```

http://localhost:7001/graphiql

Run a query:

```
query {
  # the entity can have many IDs, so we need to ask for the entity through an entity identifiers table
  specimensIDs: allEntityIdentifiers(condition: {
    entityIdentifier: "https://arctos.database.museum/guid/DMNS:Mamm:11098"
  }) {
    # there should only be one entity with this ID
    nodes {
      entityId
      entityIdentifier
      entityIdentifierType
      specimen: entityByEntityId {
        entityId
        entityType
        
        # get identifications
        identificationEntitiesByEntityId {
            totalCount
            nodes {
              identificationByIdentificationId {
                taxonIdentificationsByIdentificationId {
                  totalCount
                  nodes {
                    taxonByTaxonId {
                      scientificName
                      kingdom
                      phylum
                      class
                      order
                      family
                      subfamily
                      # what happened to genus?
                      genericName
                      specificEpithet
                      infraspecificEpithet
                      scientifcNameAuthorship
                      parentTaxonId # this should be linked in the graph as well
                      # The UI has a longer classification, but I assume that is just because they use a different taxonomy?
                    }
                  }
                }
                
                verbatimIdentification
                # vernacular name: Colorado chipmunk is not in the data
                dateIdentified
                identificationAgentRolesByIdentificationId {
                  totalCount
                  nodes {
                    agentId
                    identificationAgentRole
                    identificationAgentRoleBegan
                    identificationAgentRoleEnded
                    agentByAgentId {
                      preferredAgentName
                    }
                  }
                }
                
                identificationType
                identificationVerificationStatus
                identificationRemarks
                
                taxaFormula # value : A - I do not know what it means, but perhaps meaningful
                isAcceptedIdentification
                
                
                # Citations section. I'm surprised this is sitting on the Identification. I would have thought it was attached to the specimen
                identificationCitationsByIdentificationId {
                  nodes {
                    citationType
                    citationPageNumber
                    citationRemarks
                    # The citations reference the species name, but since they hangs of the Identification it must come from there.
                    referenceByReferenceId {
                      referenceType
                      referenceDoi # I do not know enough about this, but is DOIs the only thing that is used to link?
                      bibliographicCitation # The UI shows like "Bell et al. 2015" - but I assume that is just something that parse the full string?
                    }
                  }
                }
              }
            }
          }
        
        # typed data for material
        materialEntityByMaterialEntityId {
          materialEntityType         
        }
        
        # collector and preparator
        entityAgentRolesByEntityId {
          totalCount
          nodes {
            agentId
            entityAgentRole
            entityAgentRoleBegan
            entityAgentRoleEnded
            entityAgentRoleOrder
            agentByAgentId {
              preferredAgentName
            }
          }
        }
        
        # facts and meassurements about the specimen
        entityAssertionsByEntityId {
          totalCount
          nodes {
            entityAssertionType
            entityAssertionValue
            entityAssertionValueNumeric
            entityAssertionUnit
            entityAssertionDate
            entityAssertionProtocol
            entityAssertionRemarks
            agentByEntityAssertionByAgentId {
              preferredAgentName
            }
          }
        }

        # Identifiers section 
        # This is missing 2/5 columns: "relationsship" and "ID value" and "assignedBy" is missing. But might be inferred from the others?
        entityIdentifiersByEntityId {
          nodes {
            entityIdentifier
            entityIdentifierType
          }
        }
        # above identifiers include the parasites
        # I can also get to those via the related entities path like below
        entityRelationshipsBySubjectEntityId {
          nodes {
            externalObjectEntityId
          }
        }

        
        # Get media linked to this Cataloged Item.
        # The condition type is currently just the arctos free text, but I assume it would have a vocab
        # Search for entities with a relationsship to the current item. And filter on media of the catalogued item
        mediaItems: entityRelationshipsByObjectEntityId(condition: {
          entityRelationshipType: "shows cataloged_item" 
        }) {
          list: nodes {
            entityBySubjectEntityId {
              
              entityAssertionsByEntityId {
                  nodes {
                    entityAssertionType
                    entityAssertionValue
                    entityAssertionValueNumeric
                    entityAssertionUnit
                    entityAssertionUnit
                    entityAssertionDate
                    entityAssertionProtocol
                    entityAssertionRemarks
                  }                
              }
              
              # typed data
              digitalEntityByDigitalEntityId {
                accessUri
                format
                webStatement
                digitalEntityType
              }
            }
          }
        }
        # media section END

        # get the event data
        entityEventsByEntityId {
          totalCount
          nodes {
            eventByEventId {
              eventType
              # I'm unable to find the agent that appears in the arctos site
              # verification status is left out it seems
              # collection source: wild is not to be found either
              eventDate
              verbatimEventDate
              
              locationByLocationId {
                higherGeography
                locationAccordingTo # in the UI this is attached to the higher Geography which I think it also what the source is about
                locality
              }
              verbatimLocality
              #Associated Names - i do not see the data anywhere. Perhaps left out?
              
              locationByLocationId {
                georeferencesByLocationId { # I'm surprised to get back a list of georeferences for my location. How Do I choose?
                  nodes {
                    decimalLatitude
                    decimalLongitude
                    preferredSpatialRepresentation # I guess this is primary_spatial_data: point-radius
                    geodeticDatum
                    coordinateUncertaintyInMeters
                    georeferenceSources # why is this plural?
                    georeferenceProtocol
                  }
                }
                minimumElevationInMeters
                maximumElevationInMeters
              }
              verbatimLatitude # filled with collectionMethod
              verbatimLongitude # filled with habitat
              
              # collectionMethod not there # "verbatimLatitude": "Sherman trap" - I see it in latitude though
              habitat # not filled 
              
              # list of images from event/place - those I cannot figure out how to get to. See https://github.com/timrobertson100/model-tests/issues/11
              
            }
          }
        }
        # event section END
        
        # Parts section
        entityRelationshipsByObjectEntityId(condition: {
          entityRelationshipType: "part of"
        }) {
          nodes {
            entityBySubjectEntityId {
              entityType
              entityId
              digitalEntityByDigitalEntityId {
                digitalEntityId
              }
              collectionByCollectionId {
                institutionCode
              }
                
              entityAssertionsByEntityId {
                nodes {
                  entityAssertionType
                  entityAssertionValue
                  entityAssertionValueNumeric
                  entityAssertionUnit
                  entityAssertionProtocol
                  entityAssertionRemarks
                  entityAssertionDate
                  agentByEntityAssertionByAgentId {
                    preferredAgentName
                  }
                }
              }
                
              #typed data
              materialEntityByMaterialEntityId {
                materialEntityType
              }
            }
          }
        }
        # Parts section END

      }
    }
  }
}
```

Which returns:

```
{
  "data": {
    "specimensIDs": {
      "nodes": [
        {
          "entityId": "21714980",
          "entityIdentifier": "https://arctos.database.museum/guid/DMNS:Mamm:11098",
          "entityIdentifierType": "Arctos object",
          "specimen": {
            "entityId": "21714980",
            "entityType": "Organism",
            "identificationEntitiesByEntityId": {
              "totalCount": 1,
              "nodes": [
                {
                  "identificationByIdentificationId": {
                    "taxonIdentificationsByIdentificationId": {
                      "totalCount": 1,
                      "nodes": [
                        {
                          "taxonByTaxonId": {
                            "scientificName": "Tamias quadrivittatus (Say, 1823)",
                            "kingdom": "Animalia",
                            "phylum": "Chordata",
                            "class": "Mammalia",
                            "order": "Rodentia",
                            "family": "Sciuridae",
                            "subfamily": "Sciurinae",
                            "genericName": "Tamias",
                            "specificEpithet": "quadrivittatus",
                            "infraspecificEpithet": null,
                            "scientifcNameAuthorship": "(Say, 1823)",
                            "parentTaxonId": null
                          }
                        }
                      ]
                    },
                    "verbatimIdentification": "Tamias quadrivittatus",
                    "dateIdentified": "2007-07-13",
                    "identificationAgentRolesByIdentificationId": {
                      "totalCount": 1,
                      "nodes": [
                        {
                          "agentId": "796",
                          "identificationAgentRole": "determiner",
                          "identificationAgentRoleBegan": null,
                          "identificationAgentRoleEnded": null,
                          "agentByAgentId": {
                            "preferredAgentName": "John R. Demboski"
                          }
                        }
                      ]
                    },
   ... etc
```
