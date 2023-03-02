\c topmodelsql

DROP TABLE IF EXISTS secondnf_brands;
DROP TABLE IF EXISTS secondnf_models;

CREATE TABLE secondnf_models
( 
    model_id SERIAL PRIMARY KEY,
    model_name VARCHAR(100),
    area VARCHAR(50),
    price_per_event FLOAT,
    category VARCHAR(100),
    agent VARCHAR(50),
    trait VARCHAR(60),
    rating INT, 
    event_date TEXT, 
    revenue  FLOAT
);

CREATE TABLE secondnf_brands
(
    brand TEXT,
    model_id INT REFERENCES secondnf_models(model_id)
);

INSERT INTO secondnf_models
    (model_id, model_name, area, price_per_event, category, agent, trait, rating, event_date, revenue ) 
    SELECT DISTINCT model_id, model_name, area, price_per_event, category, agent, trait, rating, event_date, revenue 
    FROM firstnf_models
RETURNING *;

INSERT INTO secondnf_brands
    (brand, model_id)
    SELECT brand, model_id 
    FROM firstnf_models
RETURNING *;
