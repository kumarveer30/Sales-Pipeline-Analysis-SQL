
use Sales_Pipeline_Analysis;

-- Objective 3
-- Product analysis
-- Your third objective is to analyze the sales performance and quantity sold of the company's product portfolio


-- Question 1:- For March deals identify the top product by revenue and compare it to the top by units sold

-- Top Product by Revenue in March
SELECT
    product,
    SUM(close_value) AS total_revenue
FROM
    sales_pipeline
WHERE
    deal_stage = 'Won' AND MONTH(close_date) = 3
GROUP BY
    product
ORDER BY
    total_revenue DESC;

-- Top Product by Units Sold in March
SELECT
    product,
    COUNT(opportunity_id) AS units_sold
FROM
    sales_pipeline
WHERE
    deal_stage = 'Won' AND MONTH(close_date) = 3
GROUP BY
    product
ORDER BY
    units_sold DESC;





-- Question 2:- Calculate the average difference between "sales_price" and "close_value" for each product and note if the results suggest a data issue

SELECT
    sp.product,
    p.sales_price,
    AVG(sp.close_value) AS average_sale_price,
    AVG(p.sales_price - sp.close_value) AS average_discount
FROM
    sales_pipeline AS sp
JOIN
    products AS p ON sp.product = p.product
WHERE
    sp.deal_stage = 'Won' -- Only analyze deals that were actually sold
GROUP BY
    sp.product, p.sales_price -- Group by both to have access to sales_price
ORDER BY
    average_discount DESC; -- Order to see the largest discounts first





-- Question 3:- Calculate total revenue by product series and compare their performance

SELECT
    p.series,
    SUM(sp.close_value) AS total_revenue
FROM
    sales_pipeline AS sp
JOIN
    products AS p ON sp.product = p.product
WHERE
    sp.deal_stage = 'Won'
GROUP BY
    p.series
ORDER BY
    total_revenue DESC;













































