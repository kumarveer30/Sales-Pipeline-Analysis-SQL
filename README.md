# Sales-Pipeline-Analysis-SQL

### Project Overview

This repository contains a comprehensive SQL project analyzing a company's sales pipeline, agent performance, and customer accounts. The project involved creating a relational database from raw CSV data, performing extensive data cleaning and structuring, and executing a series of complex analytical queries to derive key business insights.

---

### Business Need & Project Objectives

The project was initiated to address the challenge of analyzing disconnected sales data from four separate CSV files (`accounts`, `products`, `sales_teams`, `sales_pipeline`). The raw data contained significant inconsistencies, formatting issues, and lacked the relational integrity required for meaningful analysis.

The primary objective was to build a robust, relational SQL database to serve as a single source of truth. Key goals included:
1.  Designing and implementing a normalized database schema.
2.  Developing an ETL (Extract, Transform, Load) process within SQL to import, clean, and structure the data.
3.  Establishing full relational integrity using primary and foreign keys.
4.  Executing a multi-faceted analysis to answer critical business questions regarding pipeline metrics, sales performance, and customer account trends.

### Technical Approach & Implementation

The project followed a systematic data engineering and analysis workflow:

1.  **Database & Schema Design:**
    *   A normalized schema with four tables was designed based on the provided data dictionary to ensure data was organized logically and without redundancy.
    *   `CREATE TABLE` scripts were written and executed, defining optimal data types (`VARCHAR`, `INT`, `DATE`, `DOUBLE`) and `PRIMARY KEY` constraints for each table.

2.  **Data Ingestion & Cleaning:**
    *   Overcame initial data import failures in MySQL Workbench by troubleshooting `local_infile` security restrictions and developing a robust, multi-step import strategy for files with complex data types.
    *   Problematic columns (e.g., dates with blank values) were initially imported as `TEXT` to bypass GUI limitations, then programmatically converted to the correct `DATE` and `INT` formats using `UPDATE` and `ALTER TABLE` commands.
    *   The `NULLIF()` function was used to systematically convert all blank strings from the source files into proper `NULL` values, ensuring data integrity for calculations and joins.

3.  **Establishing Relational Integrity:**
    *   Systematically debugged and resolved `Error 1452 (foreign key constraint fails)` by writing diagnostic queries to identify and correct mismatched data between tables (e.g., "GTXPro" vs "GTX Pro").
    *   Executed targeted `UPDATE` statements to clean inconsistent data before successfully creating all foreign key relationships, linking the central `sales_pipeline` table to `accounts`, `products`, and `sales_teams`.

4.  **Analytical Querying:**
    *   Authored over a dozen complex analytical queries to address four key business objectives.
    *   Leveraged a wide range of SQL techniques, including `JOINs`, `SELF-JOINs`, `GROUP BY`, `ORDER BY`, `LIMIT`, aggregate functions (`SUM`, `COUNT`, `AVG`), date functions (`DATEDIFF`, `DATE_FORMAT`), and conditional aggregation (`SUM(CASE WHEN ... THEN ... END)`).

### Key Findings & Business Impact

The analysis produced several actionable insights, transforming raw data into strategic business intelligence:

*   **Pipeline Optimization:** Identified November as the peak month for new sales opportunities, allowing for better resource planning. The analysis also revealed that over 20% of deals are in the 'Engaging' stage, highlighting a key area for sales teams to focus on to improve conversion rates.

*   **Performance Metrics:** Determined the top-performing products and sales agents by both win rate and total revenue. For example, while "GTX Plus Pro" was a top revenue driver, "MG Special" had a higher win rate, suggesting it is an easier product to sell. This data allows for targeted sales training and marketing efforts.

*   **Data Anomaly Detection:** Uncovered a significant data integrity issue where the "GTK 500" product was sold for over 50 times its suggested retail price, flagging a critical data quality or pricing strategy problem for immediate review.

*   **Strategic Management Insights:** Ranked sales managers and regional offices by performance, providing clear, data-driven evidence for strategic decision-making, incentive programs, and targeted coaching.

---

### Technologies Used

*   **Database:** MySQL
*   **Tool:** MySQL Workbench
*   **Language:** SQL
