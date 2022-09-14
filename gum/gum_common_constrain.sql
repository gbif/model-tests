--
-- Script to create the core model constraints 
-- 
-- psql gum -f gum_common_constrain.sql
--
--
-- Primary keys
--
ALTER TABLE ONLY public.agent
    ADD CONSTRAINT pk_agent UNIQUE ("agentID");

ALTER TABLE ONLY public.entity_assertion
    ADD CONSTRAINT pk_agent UNIQUE ("entityAssertionID");

ALTER TABLE ONLY public.event_assertion
    ADD CONSTRAINT pk_agent UNIQUE ("eventAssertionID");

ALTER TABLE ONLY public.location_assertion
    ADD CONSTRAINT pk_agent UNIQUE ("locationAssertionID");

ALTER TABLE ONLY public.reference
    ADD CONSTRAINT pk_reference UNIQUE ("referenceID");

--
-- Foreign keys
--
-- An Agent may have zero or more Identifiers.
ALTER TABLE ONLY public.agent_identifier
    ADD CONSTRAINT "agent_identifier_agentID_fkey" 
    FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

-- An Collection may have zero or more Identifiers.
ALTER TABLE ONLY public.collection_identifier
    ADD CONSTRAINT "collection_identifier_agentID_fkey" 
    FOREIGN KEY ("collectionID") REFERENCES public.collecion("collectionID");

-- An Entity may have zero or more Identifiers.
ALTER TABLE ONLY public.entity_identifier
    ADD CONSTRAINT "entity_identifier_agentID_fkey" 
    FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

-- An Event may have zero or more Identifiers.
ALTER TABLE ONLY public.event_identifier
    ADD CONSTRAINT "event_identifier_agentID_fkey" 
    FOREIGN KEY ("eventID") REFERENCES public.event("eventID");

-- An AgentRelationship has exactly one object Agent.
ALTER TABLE ONLY public.agent_relationship
    ADD CONSTRAINT "agent_relationship_objectAgentID_fkey" 
    FOREIGN KEY ("objectAgentID") REFERENCES public.agent("agentID");

-- An AgentRelationship has exactly one subject Agent.
ALTER TABLE ONLY public.agent_relationship
    ADD CONSTRAINT "agent_relationship_subbjectAgentID_fkey" 
    FOREIGN KEY ("subjectAgentID") REFERENCES public.agent("agentID");

-- An Agent may have zero or more CollectionAgentRoles.
ALTER TABLE ONLY public.collection_agent_role
    ADD CONSTRAINT "collection_agent_role_agentID_fkey" 
    FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

-- A Collection may have zero or more CollectionAgentRoles.
ALTER TABLE ONLY public.collection_agent_role
    ADD CONSTRAINT "collection_agent_role_agentID_fkey" 
    FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

-- An Agent may have zero or more EntityAgentRoles.
ALTER TABLE ONLY public.entity_agent_role
    ADD CONSTRAINT "entity_agent_role_agentID_fkey" 
    FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

-- An Entity may have zero or more EntityAgentRoles.
ALTER TABLE ONLY public.entity_agent_role
    ADD CONSTRAINT "entity_agent_role_entityID_fkey" 
    FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

-- An Agent may have zero or more EventAgentRoles.
ALTER TABLE ONLY public.event_agent_role
    ADD CONSTRAINT "event_agent_role_agentID_fkey" 
    FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

-- An Event may have zero or more EventAgentRoles.
ALTER TABLE ONLY public.event_agent_role
    ADD CONSTRAINT "event_agent_role_entityID_fkey" 
    FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

-- An Agent may have zero or more IdentificationAgentRoles.
ALTER TABLE ONLY public.identification_agent_role
    ADD CONSTRAINT "identification_agent_role_agentID_fkey" 
    FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

-- An Identification may have zero or more IdentificationAgentRoles.
ALTER TABLE ONLY public.identification_agent_role
    ADD CONSTRAINT "identification_agent_role_identificationID_fkey" 
    FOREIGN KEY ("identificationID") REFERENCES public.identification("identificationID");

-- An Agent may have zero or more ReferenceAgentRoles.
ALTER TABLE ONLY public.reference_agent_role
    ADD CONSTRAINT "reference_agent_role_agentID_fkey" 
    FOREIGN KEY ("agentID") REFERENCES public.agent("agentID");

-- A Reference may have zero or more ReferenceAgentRoles.
ALTER TABLE ONLY public.reference_agent_role
    ADD CONSTRAINT "reference_agent_role_referenceID_fkey" 
    FOREIGN KEY ("referenceID") REFERENCES public.reference("referenceID");

-- An Entity may have zero or more EntityAssertions.
ALTER TABLE ONLY public.entity_assertion
    ADD CONSTRAINT "entity_assertion_entityID_fkey" 
    FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

-- An EntityAssertion may be made by zero or one Agents.
ALTER TABLE ONLY public.entity_assertion
    ADD CONSTRAINT "entity_assertion_entityAssertionByAgentID_fkey" 
    FOREIGN KEY ("entityAssertionByAgentID") REFERENCES public.agent("agentID");

-- An Event may have zero or more EventAssertions.
ALTER TABLE ONLY public.event_assertion
    ADD CONSTRAINT "event_assertion_entityID_fkey" 
    FOREIGN KEY ("entityID") REFERENCES public.entity("entityID");

-- An EventAssertion may be made by zero or one Agents.
ALTER TABLE ONLY public.event_assertion
    ADD CONSTRAINT "event_assertion_eventAssertionByAgentID_fkey" 
    FOREIGN KEY ("eventAssertionByAgentID") REFERENCES public.agent("agentID");

-- A Location may have zero or more LocationAssertions.
ALTER TABLE ONLY public.location_assertion
    ADD CONSTRAINT "location_assertion_locationID_fkey" 
    FOREIGN KEY ("locationID") REFERENCES public.location("locationID");
    
-- A LocationAssertion may be made by zero or one Agents.
ALTER TABLE ONLY public.location_assertion
    ADD CONSTRAINT "location_assertion_locationAssertionByAgentID_fkey" 
    FOREIGN KEY ("locationAssertionByAgentID") REFERENCES public.agent("agentID");

-- An Identification can be documented by zero or more IdentificationCitations.
ALTER TABLE ONLY public.identification_citation
    ADD CONSTRAINT "identification_citation_identificationID_fkey" 
    FOREIGN KEY ("identificationID") REFERENCES public.identification("identificationID");

-- An IdentificationCitation may cire zero or more References.
ALTER TABLE ONLY public.identification_citation
    ADD CONSTRAINT "identification_citation_referenceID_fkey" 
    FOREIGN KEY ("referenceID") REFERENCES public.reference("referenceID");

