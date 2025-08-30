
use Sales_Pipeline_Analysis;

-- Objectives 1--
-- Pipeline metrics--
-- Your first objective is to assess the overall sales pipeline by looking at opportunities by month, time to close, win rate, and product data --

-- Question 1 :- Calculate the number of sales opportunities created each month using "engage_date", and identify the month with the most opportunities--
        
select 
	date_format(engage_date, '%Y-%m') AS engagement_month,
	count(opportunity_id) as number_of_opportunities    
from 
	sales_pipeline
where 
	engage_date is not null
group by
		engagement_month
order by
	number_of_opportunities desc;




-- Question 2:- Find the average time deals stayed open (from "engage_date" to "close_date"), and compare closed deals versus won deals --

select
    deal_stage,
    avg(DATEDIFF(close_date, engage_date)) as avg_days_to_close
from
    sales_pipeline
where
    deal_stage in ('Won', 'Lost')
    and engage_date is not null
    and close_date is not null
group by
    deal_stage;




-- Question 3:- Calculate the percentage of deals in each stage and determine what share were lost --

SELECT
    deal_stage,
    COUNT(opportunity_id) AS number_of_deals,
    (COUNT(opportunity_id) / (SELECT COUNT(opportunity_id) FROM sales_pipeline)) * 100 AS percentage_of_deals
FROM
    sales_pipeline
GROUP BY
    deal_stage
ORDER BY
    number_of_deals DESC;




-- Question 4:- Compute the win rate for each product, and identify which one had the highest win rate --

SELECT
    product,
    SUM(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) AS won_deals,   -- The "Part": Count only the 'Won' deals for each product--
    COUNT(opportunity_id) AS total_closed_deals, -- The "Whole": Count all closed deals for each product --
    (SUM(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) / COUNT(opportunity_id)) * 100 AS win_rate_percentage    -- The Calculation: (Part / Whole) * 100
FROM
    sales_pipeline
WHERE
    deal_stage IN ('Won', 'Lost') -- IMPORTANT: Only consider deals that have a final outcome
GROUP BY
    product
ORDER BY
    win_rate_percentage DESC;




















    
