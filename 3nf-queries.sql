\c topmodelsql

WITH london_agents AS (
    SELECT agent 
    FROM thirdnf_agents 
    WHERE area = 'London'
),
london_models AS (
    SELECT model_id 
    FROM thirdnf_models 
    WHERE agent IN (
        SELECT agent FROM london_agents
    )
)
INSERT INTO thirdnf_brands
    (brand, model_id)
    SELECT 'Atlantis Doromania', model_id
    FROM london_models
RETURNING *;

INSERT INTO thirdnf_agents
    (area, agent, category)
    SELECT area, 'Vivian', category
    FROM thirdnf_agents
    WHERE agent = 'Verity'
RETURNING *;

WITH dior_models AS (
    SELECT model_id 
    FROM thirdnf_brands 
    WHERE brand = 'Dior'
)
UPDATE thirdnf_models
SET agent = 'Vivian'
WHERE agent = 'Verity'
AND model_id IN (
    SELECT model_id FROM dior_models
)
RETURNING *;

WITH sam_pagne_id AS (
    SELECT model_id 
    FROM thirdnf_models 
    WHERE model_name = 'Sam Pagne'
)
DELETE FROM thirdnf_brands
WHERE brand = 'Harrods'
AND model_id = (
    SELECT * FROM sam_pagne_id
)
RETURNING *;
