--
-- Script to create the core model constraints 
-- 
-- psql gum -f gum_constrain.sql
--

--
-- Primary keys
--
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

ALTER TABLE ONLY public.genetic_sequence
    ADD CONSTRAINT pk_event UNIQUE ("geneticSequenceID");

ALTER TABLE ONLY public.identification
    ADD CONSTRAINT pk_identification UNIQUE ("identificationID");

ALTER TABLE ONLY public.location
    ADD CONSTRAINT pk_location UNIQUE ("locationID");

ALTER TABLE ONLY public.material_entity
    ADD CONSTRAINT pk_material_entity UNIQUE ("materialEntityID");

ALTER TABLE ONLY public.material_group
    ADD CONSTRAINT pk_material_entity UNIQUE ("materialGroupID");

ALTER TABLE ONLY public.organism
    ADD CONSTRAINT pk_location UNIQUE ("organismID");

ALTER TABLE ONLY public.protocol
    ADD CONSTRAINT pk_location UNIQUE ("protocolID");

ALTER TABLE ONLY public.taxon
    ADD CONSTRAINT pk_taxon UNIQUE ("taxonID");

--
-- Foreign keys
--
-- A Location may have zero or more Georeferences.
ALTER TABLE ONLY public.georeference
    ADD CONSTRAINT "georeference_locationID_fkey" 
    FOREIGN KEY ("locationID") REFERENCES public.location("locationID");

-- A Location may have zero or one GeologicalContexts.
ALTER TABLE ONLY public.geological_context
    ADD CONSTRAINT "geological_context_locationID_fkey" 
    FOREIGN KEY ("locationID") REFERENCES public.location("locationID");

-- The parentLocationID supports an arbitrary Location hierarchy
ALTER TABLE ONLY public.location
    ADD CONSTRAINT "location_locationID_fkey" 
    FOREIGN KEY ("parentLocationID") REFERENCES public.location("locationID");

-- An Event happens at a Location whether declared or not.
ALTER TABLE ONLY public.event
    ADD CONSTRAINT "event_locationID_fkey" 
    FOREIGN KEY ("locationID") REFERENCES public.location("locationID");

-- The parentEventID supports an arbitrary Event hierarchy. Parent Events are expected to
-- contain child Events both spatially and temporally.
ALTER TABLE ONLY public.event
    ADD CONSTRAINT "event_eventID_fkey" 
    FOREIGN KEY ("parentEventID") REFERENCES public.event("eventID");

-- An Event may have a declared Protocol.
ALTER TABLE ONLY public.event
    ADD CONSTRAINT "event_protocolID_fkey" 
    FOREIGN KEY ("protocolID") REFERENCES public.protocol("protocolID");

-- An Entity may participate in one or more Events.
ALTER TABLE ONLY public.entity_event
    ADD CONSTRAINT "entity_event_entityID_fkey" 
    FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

-- An Event may target zero or more Entities.
ALTER TABLE ONLY public.entity_event
    ADD CONSTRAINT "entity_event_eventID_fkey" 
    FOREIGN KEY ("eventID") REFERENCES public.event("eventID");

-- An EntityRelationship may depend on zero or one other EntityRelationships.
ALTER TABLE ONLY public.entity_relationship
    ADD CONSTRAINT "entity_relationship_dependsOnEntityRelationshipID_fkey" 
    FOREIGN KEY ("dependsOnEntityRelationshipID") REFERENCES public.entity_relationship("entityRelationshipID");

-- An EntityRelationship has exactly one object Entity.
ALTER TABLE ONLY public.entity_relationship
    ADD CONSTRAINT "entity_relationship_objectEntityID_fkey" 
    FOREIGN KEY ("objectEntityID") REFERENCES public.entity("entityID");

-- An EntityRelationship has exactly one subject Entity.
ALTER TABLE ONLY public.entity_relationship
    ADD CONSTRAINT "entity_relationship_subjectEntityID_fkey" 
    FOREIGN KEY ("subjectEntityID") REFERENCES public.entity("entityID");

-- A Collection is a subtype of Entity.
ALTER TABLE ONLY public.collection
    ADD CONSTRAINT "collection_collectionID_fkey" 
    UNIQUE FOREIGN KEY ("collectionID") REFERENCES public.entity("entityID");

-- A DigitalEntity is a subtype of Entity.
ALTER TABLE ONLY public.digital_entity
    ADD CONSTRAINT "digital_entity_digitalEntityID_fkey" 
    UNIQUE FOREIGN KEY ("digitalEntityID") REFERENCES public.entity("entityID");

-- A GeneticSequence is a subtype of DigitalEntity.
ALTER TABLE ONLY public.genetic_sequence
    ADD CONSTRAINT "genetic_sequence_geneticSequenceID_fkey" 
    UNIQUE FOREIGN KEY ("geneticSequenceID") REFERENCES public.entity("digitalEntityID");

-- A MaterialEntity is a subtype of Entity.
ALTER TABLE ONLY public.material_entity
    ADD CONSTRAINT "material_entity_materialEntityID_fkey" 
    UNIQUE FOREIGN KEY ("materialEntityID") REFERENCES public.entity("entityID");

-- A MaterialGroup is a subtype of MaterialEntity.
ALTER TABLE ONLY public.material_group
    ADD CONSTRAINT "material_group_materialGroupID_fkey" 
    UNIQUE FOREIGN KEY ("materialGroupID") REFERENCES public.entity("materialEntityID");

-- An Organism is a subtype of Entity.
ALTER TABLE ONLY public.organism
    ADD CONSTRAINT "organism_organismID_fkey" 
    UNIQUE FOREIGN KEY ("organismID") REFERENCES public.entity("entityID");

-- An Identification can apply to one or more Entities.
ALTER TABLE ONLY public.identification_entity
    ADD CONSTRAINT "identification_entity_identificationID_fkey" 
    FOREIGN KEY ("identificationID") REFERENCES public.identification("identificationID");

-- An Entity may participate in one or more Identifications.
ALTER TABLE ONLY public.identification_entity
    ADD CONSTRAINT "identification_entity_entityID_fkey" 
    FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

-- The parentTaxonID supports an arbitrary Taxon hierarchy.
ALTER TABLE ONLY public.taxon
    ADD CONSTRAINT "taxon_taxonID_fkey" 
    FOREIGN KEY ("parentTaxonID") REFERENCES public.taxon("taxonID");

-- An Taxon may participate in one or more Identifications.
ALTER TABLE ONLY public.taxon_identification
    ADD CONSTRAINT "taxon_identification_taxonID_fkey" 
    FOREIGN KEY ("taxonID") REFERENCES public.taxon("taxonID");

-- An Identification can involve one or more Taxa.
ALTER TABLE ONLY public.taxon_identification
    ADD CONSTRAINT "taxon_identification_identificationID_fkey" 
    FOREIGN KEY ("identificationID") REFERENCES public.identification("identificationID");

-- An Taxon may be indicated by zero or more GeneticSequences.
ALTER TABLE ONLY public.sequence_taxon
    ADD CONSTRAINT "sequence_taxon_taxonID_fkey" 
    FOREIGN KEY ("taxonID") REFERENCES public.taxon("taxonID");

-- A GeneticSequence may refer to one or more Taxa.
ALTER TABLE ONLY public.sequence_taxon
    ADD CONSTRAINT "sequence_taxon_geneticSequenceID_fkey" 
    FOREIGN KEY ("geneticSequenceID") REFERENCES public.geneticSequence("geneticSequenceID");
