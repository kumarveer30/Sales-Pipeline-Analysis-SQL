
use Sales_Pipeline_Analysis;

-- Objective 2
-- Sales agent performance
-- Your second objective is to assess the performance of sales agents, their managers, and regional offices


-- Question 1:- Calculate the win rate for each sales agent and find the top performer

SELECT
    sales_agent,
    SUM(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) AS won_deals, -- The "Part": Count only the 'Won' deals for each agent
    
    COUNT(opportunity_id) AS total_closed_deals, -- The "Whole": Count all closed deals for each agent

    (SUM(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) / COUNT(opportunity_id)) * 100 AS win_rate_percentage  -- The Calculation: (Part / Whole) * 100
FROM
    sales_pipeline
WHERE
    deal_stage IN ('Won', 'Lost') -- Only consider deals that have a final outcome
GROUP BY
    sales_agent
ORDER BY
    win_rate_percentage DESC;




-- Question 2:- Calculate the total revenue by agent and see who generated the most

SELECT
    sales_agent,
    SUM(close_value) AS total_revenue
FROM
    sales_pipeline
WHERE
    deal_stage = 'Won' -- Only sum the value of deals that were actually won
GROUP BY
    sales_agent
ORDER BY
    total_revenue DESC;




-- Question 3:- Calculate win rates by manager to determine which manager’s team performed best

SELECT
    st.manager,
    SUM(CASE WHEN sp.deal_stage = 'Won' THEN 1 ELSE 0 END) AS won_deals, -- The "Part": Count only the 'Won' deals for each manager's team

    COUNT(sp.opportunity_id) AS total_closed_deals, -- The "Whole": Count all closed deals for each manager's team

    (SUM(CASE WHEN sp.deal_stage = 'Won' THEN 1 ELSE 0 END) / COUNT(sp.opportunity_id)) * 100 AS win_rate_percentage -- The Calculation: (Part / Whole) * 100
FROM
    sales_pipeline AS sp -- Using an alias 'sp' for sales_pipeline makes the query shorter
JOIN
    sales_teams AS st ON sp.sales_agent = st.sales_agent -- Using an alias 'st' for sales_teams
WHERE
    sp.deal_stage IN ('Won', 'Lost') -- Filter for closed deals
GROUP BY
    st.manager
ORDER BY
    win_rate_percentage DESC;




-- Question 4:- For the product GTX Plus Pro, find which regional office sold the most units

SELECT
    st.regional_office,
    COUNT(sp.opportunity_id) AS units_sold
FROM
    sales_pipeline AS sp
JOIN
    sales_teams AS st ON sp.sales_agent = st.sales_agent
WHERE
    sp.product = 'GTX Plus Pro' AND sp.deal_stage = 'Won'
GROUP BY
    st.regional_office
ORDER BY
    units_sold DESC;
















































