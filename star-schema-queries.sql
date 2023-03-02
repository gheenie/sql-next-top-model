\c topmodelsql

SELECT agent, AVG(rating) OVER (PARTITION BY agent_id) AS agent_average_rating
FROM fact_models
JOIN dim_agents USING (agent_id)
ORDER BY agent_average_rating
LIMIT 1;

WITH events_per_model AS (
    SELECT model_name, COUNT(model_id) AS events_worked
    FROM fact_revenues
    JOIN dim_models USING (model_id)
    GROUP BY model_name, model_id
),
max_events_worked_per_model AS (
    SELECT MAX(events_worked) AS max_events_worked
    FROM events_per_model
)
SELECT model_name
FROM events_per_model
WHERE events_worked = (
    SELECT max_events_worked FROM max_events_worked_per_model
);

WITH events_per_quarter AS (
    SELECT quarter, COUNT(quarter) AS events_held
    FROM fact_revenues
    JOIN dim_dates USING (date_id)
    GROUP BY quarter
),
max_events_held_per_quarter AS (
    SELECT MAX(events_held) AS max_events_held
    FROM events_per_quarter
)
SELECT quarter
FROM events_per_quarter
WHERE events_held = (
    SELECT max_events_held FROM max_events_held_per_quarter
);

WITH events_per_quarter AS (
    SELECT quarter, COUNT(quarter) AS events_held, SUM(revenue) AS total_revenue
    FROM fact_revenues
    JOIN dim_dates USING (date_id)
    GROUP BY quarter
),
max_events_held_per_quarter AS (
    SELECT MAX(events_held) AS max_events_held
    FROM events_per_quarter
),
busiest_quarter AS (
    SELECT quarter
    FROM events_per_quarter
    WHERE events_held = (
        SELECT max_events_held FROM max_events_held_per_quarter
    )
)
SELECT total_revenue
FROM events_per_quarter
WHERE quarter = (
    SELECT quarter FROM busiest_quarter
);

WITH events_per_category AS (
    SELECT category_id, SUM(revenue) AS total_revenue
    FROM fact_revenues
    GROUP BY category_id
),
max_total_revenue_per_category AS (
    SELECT MAX(total_revenue) AS max_total_revenue
    FROM events_per_category
),
category_ids_with_max_total_revenue AS (
    SELECT category_id
    FROM events_per_category
    WHERE total_revenue = (
        SELECT max_total_revenue FROM max_total_revenue_per_category
    )
)
SELECT category
FROM dim_categories
WHERE category_id IN (
    SELECT category_id FROM category_ids_with_max_total_revenue
);

-- Less optimal solution for task 2.3.5

SELECT category, SUM(revenue) OVER (PARTITION BY category_id) AS total_revenue_per_category
FROM fact_revenues
JOIN dim_categories USING (category_id)
ORDER BY total_revenue_per_category DESC
LIMIT 1;

WITH london_area_id AS (
    SELECT area_id
    FROM dim_areas
    WHERE area = 'London'
),
london_model_ids AS (
    SELECT model_id
    FROM fact_models
    WHERE area_id = (
        SELECT area_id FROM london_area_id
    )
)
SELECT COUNT(DISTINCT brand)
FROM dim_brands
WHERE model_id IN (
    SELECT model_id FROM london_model_ids
);

WITH paul_rose_ids AS (
    SELECT agent_id
    FROM dim_agents
    WHERE agent = 'Paul'
    OR agent = 'Rose'
)
SELECT SUM(price_per_event)
FROM fact_models
WHERE agent_id IN (
    SELECT agent_id FROM paul_rose_ids
);

WITH brands_per_agent AS (
    SELECT agent_id, COUNT(DISTINCT brand) AS num_of_associated_brands
    FROM fact_revenues
    JOIN dim_brands USING (model_id)
    GROUP BY agent_id
),
max_num_of_associated_brands_per_agent AS (
    SELECT MAX(num_of_associated_brands) as max_num_of_associated_brands
    FROM brands_per_agent
),
agent_ids_with_max_num_of_associated_brands AS (
    SELECT agent_id
    FROM brands_per_agent
    WHERE num_of_associated_brands = (
        SELECT max_num_of_associated_brands FROM max_num_of_associated_brands_per_agent
    )
)
SELECT agent
FROM dim_agents
WHERE agent_id IN (
    SELECT agent_id FROM agent_ids_with_max_num_of_associated_brands
);
