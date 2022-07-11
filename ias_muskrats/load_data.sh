csvsql --db postgresql:///ias_muskrats --no-create --insert ./files/agent.csv
csvsql --db postgresql:///ias_muskrats --no-create --insert ./files/digital_entity.csv
csvsql --db postgresql:///ias_muskrats --no-create --insert ./files/entity_assertion.csv
csvsql --db postgresql:///ias_muskrats --no-create --insert ./files/entity_event.csv
csvsql --db postgresql:///ias_muskrats --no-create --insert ./files/entity_identifier.csv
csvsql --db postgresql:///ias_muskrats --no-create --insert ./files/entity_relationship.csv
csvsql --db postgresql:///ias_muskrats --no-create --insert ./files/entity.csv
csvsql --db postgresql:///ias_muskrats --no-create --no-inference --insert ./files/event_agent_role.csv
csvsql --db postgresql:///ias_muskrats --no-create --insert ./files/event_assertion.csv
csvsql --db postgresql:///ias_muskrats --no-create --insert ./files/event.csv
csvsql --db postgresql:///ias_muskrats --no-create --no-inference --insert ./files/identification_agent_role.csv
csvsql --db postgresql:///ias_muskrats --no-create --insert ./files/identification_entity.csv
csvsql --db postgresql:///ias_muskrats --no-create --insert ./files/identification.csv
csvsql --db postgresql:///ias_muskrats --no-create --insert ./files/location_assertion.csv
csvsql --db postgresql:///ias_muskrats --no-create --insert ./files/location.csv
csvsql --db postgresql:///ias_muskrats --no-create --insert ./files/material_entity.csv
csvsql --db postgresql:///ias_muskrats --no-create --insert ./files/taxon_identification.csv
csvsql --db postgresql:///ias_muskrats --no-create --insert ./files/taxon.csv