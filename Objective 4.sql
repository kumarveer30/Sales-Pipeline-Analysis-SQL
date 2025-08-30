
use Sales_Pipeline_Analysis;

-- Objective 4
-- Account analysis
-- Your final objective is to analyze the company's accounts to get a better understanding of the team's customers



-- Question 1:- Calculate revenue by office location, and identify the lowest performer

SELECT
    a.office_location,
    SUM(sp.close_value) AS total_revenue
FROM
    sales_pipeline AS sp
JOIN
    accounts AS a ON sp.account = a.account
WHERE
    sp.deal_stage = 'Won'
GROUP BY
    a.office_location
ORDER BY
    total_revenue ASC;
    
    
    
    
    
    
-- Question 2:- Find the gap in years between the oldest and newest customer, and name those companies

-- Find the Oldest Customer
SELECT
    account,
    year_established
FROM
    accounts
ORDER BY
    year_established ASC -- ASC for ascending, oldest first
LIMIT 1;


-- Find the Newest Customer
SELECT
    account,
    year_established
FROM
    accounts
ORDER BY
    year_established DESC;
    
    
    

    
-- Question 3:- Which accounts that were subsidiaries had the most lost sales opportunities?    

SELECT
    a.account,
    COUNT(sp.opportunity_id) AS lost_deals_count
FROM
    sales_pipeline AS sp
JOIN
    accounts AS a ON sp.account = a.account
WHERE
    a.subsidiary_of IS NOT NULL -- Condition 1: Must be a subsidiary
    AND sp.deal_stage = 'Lost'      -- Condition 2: Deal must be lost
GROUP BY
    a.account
ORDER BY
    lost_deals_count DESC;





-- Question 4:- Join the companies to their subsidiaries. Which one had the highest total revenue?

SELECT
    parent.account AS parent_company,
    (parent.revenue + SUM(subsidiary.revenue)) AS total_family_revenue -- We add the parent's own revenue to the sum of all its subsidiaries' revenue
FROM
    accounts AS parent -- The first instance of the table, representing the parent
JOIN
    accounts AS subsidiary ON parent.account = subsidiary.subsidiary_of -- The second instance, for subsidiaries
GROUP BY
    parent.account, parent.revenue -- Group by the parent company to sum up its subsidiaries
ORDER BY
    total_family_revenue DESC;
















































