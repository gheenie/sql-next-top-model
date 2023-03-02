-- Which agent has the lowest rated models?
--get average rating for each agent
--sort lowest to highest
--limit 1

--get agent ids
--match each agent id to their models ids, grouped by agent id
--get the average rating for those models ids, grouped by agent id
--sort lowest to highest
--limit 1

SELECT agent_name FROM fact_rating JOIN agents ON fact_rating.agent_id = agents.agent_id GROUP BY agents.agent_id ORDER BY AVG(fact_rating.rating) ASC LIMIT 1;

-- How much does it cost to hire all models that are represented by Pau-- fact_revenue: revenue, model_id, agent_id, date_id, category_id
-- fact_models : rating, price, trait, model_id, agent_id, brand_id, area_id, category_idl & Rose?

SELECT SUM(price) FROM dim_models JOIN dim_agents ON dim_models.agent_id = dim_agents.agent_id WHERE dim_agents.agent_id = "Paul" OR dim_agents.agent_id = "Rose";

-- How many brands are represented by models from London?

SELECT COUNT(DISTINCT(brand_id)) FROM fact_models WHERE area_id IN (SELECT area_id FROM dim_area WHERE area = "London");
