

-- dim_models(model_id, model_name, trait, area, price, category, rating, agent)
-- dim_agent(agent)
-- dim_dates(date_id, day_of_month, month, year, weekday, quarter)
-- dim_brands(brand)

-- fact_event: revenue, model_id, agent, brand, date_id

Which agent has the lowest rated models?

SELECT agent FROM fact_event JOIN dim_models ON fact_event.model_id = dim_models.model_id GROUP BY AGENT ORDER BY AVG(rating) ASC LIMIT 1;

Which model has worked the most events?

SELECT model_name FROM dim_models JOIN
(SELECT model_id FROM fact_event GROUP BY model_id ORDER BY COUNT(date_id) DESC LIMIT 1) AS most_popular_model
ON dim_models.model_id = most_popular_model.model_id; 