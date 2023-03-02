-- dim_models(model_id, model_name)
-- dim_agents(agent_id, agent)
-- dim_dates(date_id, day_of_month, month, year, weekday, quarter)
-- dim_brands(brand_id, brand)
-- dim_area(area_id, area)
-- dim_category(category_id, category)

-- fact_revenue: revenue, model_id, agent_id, date_id, category_id
-- fact_models : rating, price, trait, model_id, agent_id, brand_id, area_id, category_id

\c topmodelsql

DROP TABLE IF EXISTS fact_revenue;
DROP TABLE IF EXISTS fact_models;
DROP TABLE IF EXISTS dim_area;
DROP TABLE IF EXISTS dim_brands;
DROP TABLE IF EXISTS dim_dates;
DROP TABLE IF EXISTS dim_agents;
DROP TABLE IF EXISTS dim_models;
DROP TABLE IF EXISTS dim_category;

CREATE TABLE dim_area(
    area_id SERIAL PRIMARY KEY,
    area VARCHAR(50)
);

CREATE TABLE dim_models(
    model_id SERIAL PRIMARY KEY,
    model_name VARCHAR(100)
);

CREATE TABLE dim_brands(
    brand_id SERIAL PRIMARY KEY,
    brand TEXT,
    model_id INT REFERENCES dim_models(model_id)
);

CREATE TABLE dim_dates AS
SELECT
    ts_seq AS date_id,
    EXTRACT(day FROM ts_seq) AS day_of_month,
    TO_CHAR(ts_seq, 'TMDay') AS day_name,
    EXTRACT(isodow FROM ts_seq) AS day_of_week,
    EXTRACT(month from ts_seq) AS month_number,
    TO_CHAR(ts_seq, 'TMMonth') AS month_name,
    EXTRACT(year FROM ts_seq) AS year,
    EXTRACT(quarter FROM ts_seq) AS quarter,
    'FY' || EXTRACT(year FROM ts_seq - interval '3 month')::VARCHAR AS financial_year
FROM
    (SELECT '2020-01-01'::DATE + sequence.day AS ts_seq
        FROM GENERATE_SERIES(0,2000) AS sequence(day)) dq;

ALTER TABLE dim_dates ADD CONSTRAINT dim_dates_pk PRIMARY KEY(date_id);

CREATE TABLE dim_agents(
    agent_id SERIAL PRIMARY KEY,
    agent VARCHAR(50)
);

CREATE TABLE dim_category(
    category_id SERIAL PRIMARY KEY,
    category VARCHAR(100)
);

CREATE TABLE fact_models(
    rating INT,
    price_per_event FLOAT,
    trait VARCHAR(60),
    model_id INT REFERENCES dim_models(model_id),
    agent_id INT REFERENCES dim_agents(agent_id),
    brand_id INT REFERENCES dim_brands(brand_id),
    category_id INT REFERENCES dim_category(category_id)
);

CREATE TABLE fact_revenue(
    revenue FLOAT,
    model_id INT references dim_models(model_id),
    agent_id INT references dim_agents(agent_id),
    date_id DATE references dim_dates(date_id),
    category_id INT REFERENCES dim_category(category_id)
);


INSERT INTO dim_models
    (model_id, model_name)
    SELECT DISTINCT model_id, model_name FROM models
RETURNING *;

INSERT INTO dim_agents
    (agent)
    SELECT DISTINCT(agent) FROM models
RETURNING *;

INSERT INTO dim_category
    (category)
    SELECT DISTINCT(category) FROM models
RETURNING *;

INSERT INTO dim_area
    (area)
    SELECT area FROM models
RETURNING *;

INSERT INTO dim_brands
    (brand, model_id)
    SELECT brand, model_id FROM thirdnf_brands
RETURNING *;

INSERT INTO fact_revenue
    (revenue, model_id, date_id)
    SELECT revenue, model_id, CAST(event_date AS DATE) FROM models
RETURNING *;

WITH agents AS (SELECT agent_id, model_id FROM dim_agents JOIN models USING (agent))
UPDATE fact_revenue
SET agent_id = (SELECT agent_id FROM agents WHERE fact_revenue.model_id = agents.model_id);

WITH categories AS (SELECT category_id, model_id FROM dim_category JOIN models USING (category))
UPDATE fact_revenue
SET category_id = (SELECT category_id FROM categories WHERE fact_revenue.model_id = categories.model_id);

SELECT * FROM fact_revenue;

-- INSERT INTO fact_models
--     (rating, price_per_event, trait, model_id, agent_id, category_id)
--     SELECT 
