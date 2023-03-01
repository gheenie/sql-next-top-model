\c topmodelsql

DROP TABLE IF EXISTS thirdnf_brands;
DROP TABLE IF EXISTS thirdnf_models;
DROP TABLE IF EXISTS thirdnf_agents;

CREATE TABLE thirdnf_agents
(
    area VARCHAR(50),
    agent VARCHAR(50) UNIQUE,
    category VARCHAR(100)
);

CREATE TABLE thirdnf_models
( 
    model_id SERIAL PRIMARY KEY,
    model_name VARCHAR(100),
    price_per_event FLOAT,
    agent VARCHAR(50) REFERENCES thirdnf_agents(agent),
    trait VARCHAR(60),
    rating INT, 
    event_date TEXT, 
    revenue  FLOAT
);

CREATE TABLE thirdnf_brands
(
    brand TEXT,
    model_id INT REFERENCES thirdnf_models(model_id)
);

INSERT INTO thirdnf_agents
    (area, agent, category)
    SELECT DISTINCT area, agent, category FROM secondnf_models RETURNING *;


INSERT INTO thirdnf_models
    (model_id, model_name, price_per_event, agent, trait, rating, event_date, revenue)
    SELECT model_id, model_name, price_per_event, agent, trait, rating, event_date, revenue FROM secondnf_models RETURNING *;

INSERT INTO thirdnf_brands
    (brand, model_id)
    SELECT brand, model_id FROM secondnf_brands RETURNING *;