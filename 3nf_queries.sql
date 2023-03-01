\c topmodelsql

WITH london_agents AS (SELECT agent FROM thirdnf_agents WHERE area = 'London'),
london_models AS
(SELECT model_id FROM thirdnf_models WHERE agent IN (SELECT agent FROM london_agents))
INSERT INTO thirdnf_brands
    (brand, model_id)
    SELECT 'Atlantis Doromania', model_id
    FROM london_models
RETURNING *;

INSERT INTO thirdnf_agents
    (area, agent, category)
VALUES
    ('Milan', 'Vivian', 'Fashion')
RETURNING *;

WITH louboutin_models AS (SELECT model_id FROM thirdnf_brands WHERE brand = 'Louboutin')
UPDATE thirdnf_models
SET agent = 'Vivian'
WHERE agent = 'Verity'
AND model_id IN (SELECT model_id FROM louboutin_models)
RETURNING *;
\c topmodelsql
-- all the models from London
