--
-- Script to create the constraints once the database are loaded
-- psql ias_muskrats -f ias_muskrats_constrain.sql
--

ALTER TABLE ONLY public.agent
    ADD CONSTRAINT pk_agent UNIQUE ("agentID");

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

ALTER TABLE ONLY public.identification
    ADD CONSTRAINT pk_identification UNIQUE ("identificationID");

ALTER TABLE ONLY public.location
    ADD CONSTRAINT pk_location UNIQUE ("locationID");

ALTER TABLE ONLY public.material_entity
    ADD CONSTRAINT pk_material_entity UNIQUE ("materialEntityID");

ALTER TABLE ONLY public.reference
    ADD CONSTRAINT pk_reference UNIQUE ("referenceID");

ALTER TABLE ONLY public.protocol
    ADD CONSTRAINT pk_protocol UNIQUE ("protocolID");

ALTER TABLE ONLY public.taxon
    ADD CONSTRAINT pk_taxon UNIQUE ("taxonID");

ALTER TABLE ONLY public.agent_identifier
    ADD CONSTRAINT "agent_identifier_agentID_fkey" FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

ALTER TABLE ONLY public.digital_entity
    ADD CONSTRAINT "digital_entity_digitalEntityID_fkey" FOREIGN KEY ("digitalEntityID") REFERENCES public.entity("entityID");

ALTER TABLE ONLY public.entity
    ADD CONSTRAINT "entity_collectionID_fkey" FOREIGN KEY ("collectionID") REFERENCES public.collection("collectionID");

ALTER TABLE ONLY public.entity_agent_role
    ADD CONSTRAINT "entity_agent_role_agentID_fkey" FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

ALTER TABLE ONLY public.entity_agent_role
    ADD CONSTRAINT "entity_agent_role_entityID_fkey" FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

ALTER TABLE ONLY public.entity_assertion
    ADD CONSTRAINT "entity_assertion_entityID_fkey" FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

ALTER TABLE ONLY public.entity_assertion
    ADD CONSTRAINT "entity_assertion_entityAssertionByAgentID_fkey" FOREIGN KEY ("entityAssertionByAgentID") REFERENCES public.agent("agentID");

ALTER TABLE ONLY public.entity_event
    ADD CONSTRAINT "entity_event_entityID_fkey" FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

ALTER TABLE ONLY public.entity_event
    ADD CONSTRAINT "entity_event_eventID_fkey" FOREIGN KEY ("eventID") REFERENCES public.event("eventID");

ALTER TABLE ONLY public.entity_identifier
    ADD CONSTRAINT "entity_identifier_entityID_fkey" FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

ALTER TABLE ONLY public.entity_relationship
    ADD CONSTRAINT "entity_relationship_dependsOnEntityRelationshipID_fkey" FOREIGN KEY ("dependsOnEntityRelationshipID") REFERENCES public.entity_relationship("entityRelationshipID");

ALTER TABLE ONLY public.entity_relationship
    ADD CONSTRAINT "entity_relationship_objectEntityID_fkey" FOREIGN KEY ("objectEntityID") REFERENCES public.entity("entityID");

ALTER TABLE ONLY public.entity_relationship
    ADD CONSTRAINT "entity_relationship_subjectEntityID_fkey" FOREIGN KEY ("subjectEntityID") REFERENCES public.entity("entityID");

ALTER TABLE ONLY public.event
    ADD CONSTRAINT "event_locationID_fkey" FOREIGN KEY ("locationID") REFERENCES public.location("locationID");

ALTER TABLE ONLY public.event
    ADD CONSTRAINT "event_parentEventID_fkey" FOREIGN KEY ("eventID") REFERENCES public.event("eventID");

ALTER TABLE ONLY public.event
    ADD CONSTRAINT "event_protocolID_fkey" FOREIGN KEY ("protocolID") REFERENCES public.protocol("protocolID");

ALTER TABLE ONLY public.event_agent_role
    ADD CONSTRAINT "event_agent_role_agentID_fkey" FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

ALTER TABLE ONLY public.event_agent_role
    ADD CONSTRAINT "event_agent_role_eventID_fkey" FOREIGN KEY ("eventID") REFERENCES public.event("eventID");

ALTER TABLE ONLY public.event_assertion
    ADD CONSTRAINT "event_assertion_eventID_fkey" FOREIGN KEY ("eventID") REFERENCES public.event("eventID");

ALTER TABLE ONLY public.event_assertion
    ADD CONSTRAINT "event_assertion_eventAssertionByAgentID_fkey" FOREIGN KEY ("eventAssertionByAgentID") REFERENCES public.agent("agentID");

ALTER TABLE ONLY public.georeference
    ADD CONSTRAINT "georeference_locationID_fkey" FOREIGN KEY ("locationID") REFERENCES public.location("locationID");

ALTER TABLE ONLY public.identification_agent_role
    ADD CONSTRAINT "identification_agent_role_agentID_fkey" FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

ALTER TABLE ONLY public.identification_agent_role
    ADD CONSTRAINT "identification_agent_role_identificationID_fkey" FOREIGN KEY ("identificationID") REFERENCES public.identification("identificationID");

ALTER TABLE ONLY public.identification_citation
    ADD CONSTRAINT "identification_citation_identificationID_fkey" FOREIGN KEY ("identificationID") REFERENCES public.identification("identificationID");

ALTER TABLE ONLY public.identification_citation
    ADD CONSTRAINT "identification_citation_referenceID_fkey" FOREIGN KEY ("referenceID") REFERENCES public.reference("referenceID");

ALTER TABLE ONLY public.identification_entity
    ADD CONSTRAINT "identification_entity_identificationID_fkey" FOREIGN KEY ("identificationID") REFERENCES public.identification("identificationID");

ALTER TABLE ONLY public.identification_entity
    ADD CONSTRAINT "identification_entity_entityID_fkey" FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

ALTER TABLE ONLY public.location_assertion
    ADD CONSTRAINT "location_assertion_locationID_fkey" FOREIGN KEY ("locationID") REFERENCES public.location("locationID");

ALTER TABLE ONLY public.material_entity
    ADD CONSTRAINT "material_entity_materialEntityID_fkey" FOREIGN KEY ("materialEntityID") REFERENCES public.entity("entityID");

ALTER TABLE ONLY public.reference_agent_role
    ADD CONSTRAINT "reference_agent_role_agentID_fkey" FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

ALTER TABLE ONLY public.reference_agent_role
    ADD CONSTRAINT "reference_agent_role_referenceID_fkey" FOREIGN KEY ("referenceID") REFERENCES public.reference("referenceID");

ALTER TABLE ONLY public.taxon_identification
    ADD CONSTRAINT "taxon_identification_taxonID_fkey" FOREIGN KEY ("taxonID") REFERENCES public.taxon("taxonID");

ALTER TABLE ONLY public.taxon_identification
    ADD CONSTRAINT "taxon_identification_identificationID_fkey" FOREIGN KEY ("identificationID") REFERENCES public.identification("identificationID");
