create database Sales_Pipeline_Analysis;
use Sales_Pipeline_Analysis;

CREATE TABLE accounts (
    account VARCHAR(255) NOT NULL,
    sector VARCHAR(255),
    year_established INT,
    revenue DOUBLE,
    employees INT,
    office_location VARCHAR(255),
    subsidiary_of VARCHAR(255),
    PRIMARY KEY (account)
);


CREATE TABLE products (
    product VARCHAR(255) NOT NULL,
    series VARCHAR(255),
    sales_price DOUBLE,
    PRIMARY KEY (product)
);


CREATE TABLE sales_teams (
    sales_agent VARCHAR(255) NOT NULL,
    manager VARCHAR(255),
    regional_office VARCHAR(255),
    PRIMARY KEY (sales_agent)
);


CREATE TABLE sales_pipeline (
    opportunity_id VARCHAR(255) NOT NULL,
    sales_agent VARCHAR(255),
    product VARCHAR(255),
    account VARCHAR(255),
    deal_stage VARCHAR(50),
    engage_date VARCHAR(50),  -- Import as text
    close_date VARCHAR(50),   -- Import as text
    close_value VARCHAR(50),  -- Import as text
    PRIMARY KEY (opportunity_id)
);

-- Step 1: Temporarily disable safe update mode
SET SQL_SAFE_UPDATES = 0;

-- Step 2: Convert all blank values in the date/value columns to proper NULLs
UPDATE sales_pipeline SET
    engage_date = NULLIF(engage_date, ''),
    close_date = NULLIF(close_date, ''),
    close_value = NULLIF(close_value, '');

-- Step 3: Change the column data types to the correct format
ALTER TABLE sales_pipeline
    MODIFY COLUMN engage_date DATE,
    MODIFY COLUMN close_date DATE,
    MODIFY COLUMN close_value INT;

-- Step 4: Re-enable safe update mode for future safety
SET SQL_SAFE_UPDATES = 1;



SELECT * FROM accounts;
Describe accounts;
SELECT * FROM products;
SELECT * FROM sales_teams;
SELECT * FROM sales_pipeline;
DESCRIBE sales_pipeline;



-- Add a foreign key to link sales_pipeline to accounts
-- Step 1: Find the rows in sales_pipeline that have no matching account
SELECT opportunity_id, account
FROM sales_pipeline
WHERE account NOT IN (SELECT account FROM accounts);

-- Step 2: Convert the empty account names to NULL
UPDATE sales_pipeline
SET account = NULL
WHERE account = '';

ALTER TABLE sales_pipeline
ADD CONSTRAINT fk_pipeline_account
FOREIGN KEY (account) REFERENCES accounts(account);



-- Add a foreign key to link sales_pipeline to products
-- Step 1: Find the rows in sales_pipeline that have no matching product
SELECT DISTINCT product
FROM sales_pipeline
WHERE product NOT IN (SELECT product FROM products);

SELECT * FROM products WHERE product LIKE 'GTX%';

-- Step 2: Convert the empty product names to NULL
UPDATE sales_pipeline
SET product = 'GTX Pro'
WHERE product = 'GTXPro';

ALTER TABLE sales_pipeline
ADD CONSTRAINT fk_pipeline_product
FOREIGN KEY (product) REFERENCES products(product);




-- Add a foreign key to link sales_pipeline to sales_teams
ALTER TABLE sales_pipeline
ADD CONSTRAINT fk_pipeline_sales_agent
FOREIGN KEY (sales_agent) REFERENCES sales_teams(sales_agent);




