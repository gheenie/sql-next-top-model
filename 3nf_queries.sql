\c topmodelsql
-- all the models from London

WITH london_agents AS (SELECT * FROM thirdnf_agents WHERE area = 'London'),
london_models AS
(SELECT model_id FROM thirdnf_models WHERE thirdnf_models.agent IN (SELECT agent FROM london_agents))
INSERT INTO thirdnf_brands
(brand, model_id)
SELECT 'Atlantis Doromania', model_id AS new_model
FROM london_models
RETURNING *;