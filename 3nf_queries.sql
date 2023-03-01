\c topmodelsql

INSERT INTO thirdnf_brands
    (brand, model_id)
VALUES
    ('Atlantis Doromania', 4)
RETURNING *;

-- WITH london_agents AS (SELECT agent FROM thirdnf_agents WHERE area = 'London')
-- INSERT INTO thirdnf_brands
--     (VALUES ('Atlantis Doromania') FULL JOIN (SELECT model_id FROM thirdnf_models WHERE agent IN (SELECT * FROM london_agents)) ON True)

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
