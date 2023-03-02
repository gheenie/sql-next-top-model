\c topmodelsql

SELECT agent, AVG(rating) OVER (PARTITION BY agent_id) AS agent_average_rating
FROM fact_models
JOIN dim_agents USING (agent_id)
ORDER BY agent_average_rating
LIMIT 1;

WITH events_worked_per_model AS (
    SELECT model_name, COUNT(model_id) AS events_worked
    FROM fact_revenues
    JOIN dim_models USING (model_id)
    GROUP BY model_name, model_id
),
max_events_worked AS (
    SELECT MAX(events_worked)
    FROM events_worked_per_model
)
SELECT model_name
FROM events_worked_per_model
WHERE events_worked = (
    SELECT * FROM max_events_worked
);

WITH events_per_quarter AS (
    SELECT quarter, COUNT(quarter) AS events_count
    FROM fact_revenues
    JOIN dim_dates USING (date_id)
    GROUP BY quarter
),
max_events_count AS (
    SELECT MAX(events_count)
    FROM events_per_quarter
)
SELECT quarter
FROM events_per_quarter
WHERE events_count = (
    SELECT * FROM max_events_count
);

WITH events_per_quarter AS (
    SELECT quarter, COUNT(quarter) AS events_count, SUM(revenue) AS total_revenue_per_quarter
    FROM fact_revenues
    JOIN dim_dates USING (date_id)
    GROUP BY quarter
),
max_events_count AS (
    SELECT MAX(events_count)
    FROM events_per_quarter
),
busiest_quarter AS (
    SELECT quarter
    FROM events_per_quarter
    WHERE events_count = (
        SELECT * FROM max_events_count
    )
)
SELECT total_revenue_per_quarter
FROM events_per_quarter
WHERE quarter = (
    SELECT quarter FROM busiest_quarter
);

-- SELECT agent_name FROM fact_rating JOIN agents ON fact_rating.agent_id = agents.agent_id GROUP BY agents.agent_id ORDER BY AVG(fact_rating.rating) ASC LIMIT 1;

-- -- How much does it cost to hire all models that are represented by Pau-- fact_revenue: revenue, model_id, agent_id, date_id, category_id
-- -- fact_models : rating, price, trait, model_id, agent_id, brand_id, area_id, category_idl & Rose?

-- SELECT SUM(price) FROM dim_models JOIN dim_agents ON dim_models.agent_id = dim_agents.agent_id WHERE dim_agents.agent_id = "Paul" OR dim_agents.agent_id = "Rose";

-- -- How many brands are represented by models from London?

-- SELECT COUNT(DISTINCT(brand_id)) FROM fact_models WHERE area_id IN (SELECT area_id FROM dim_area WHERE area = "London");

