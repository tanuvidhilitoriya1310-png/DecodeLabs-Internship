
-- ------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------
-- PROJECT-3: SQL ANALYSIS
-- ------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------

/*
 ------------------------------------------------------------------------------------------------------------
 SQL CONCEPTS USED:
 ------------------------------------------------------------------------------------------------------------
 SELECT, WHERE, ORDER BY, GROUP BY, HAVING, AGGREGATIONS, SUBQUERIES
 */

-- Creating the database orders
CREATE DATABASE orders;

-- Using the orders schema
USE orders;

-- Changing the Date from text to datetime
SELECT `Date`,str_to_date(`Date`,'%Y/%m/%d')
FROM cleaned_ecommerce_transactions;

UPDATE cleaned_ecommerce_transactions
SET `Date` = 
CASE 
    WHEN `Date` LIKE '%/%' THEN STR_TO_DATE(`Date`, '%m/%d/%y')
    ELSE `Date`
END;

ALTER  TABLE cleaned_ecommerce_transactions
MODIFY COLUMN `Date` DATE;

-- ------------------------------------------------------------------------------------------------------------
-- BASIC QUERIES
-- ------------------------------------------------------------------------------------------------------------

-- 1. Show the starting 10 transactions from the data.
SELECT 
    *
FROM
    cleaned_ecommerce_transactions
LIMIT 10;

Describe cleaned_ecommerce_transactions;
/*
Insight:
The dataset contains transaction-level information including product, customer, pricing, and payment details.
*/

-- 2.Write the basic SELECT query
SELECT 
    product, TotalPrice
FROM
    cleaned_ecommerce_transactions;
/*
Insight:
Selects specific columns.
*/

-- 3. Show High-value transactions
SELECT 
    *
FROM
    cleaned_ecommerce_transactions
    WHERE TotalPrice >1000
ORDER BY Totalprice DESC;
/*
Insight:
These transactions represent high-value purchases contributing significantly to revenue.
*/

-- 4.Filter the data by a specific Payment Method.
SELECT 
    *
FROM
    cleaned_ecommerce_transactions
WHERE
    PaymentMethod = 'Online';
/*
Insight:
Shows transactions using a specific payment method.
*/

-- ------------------------------------------------------------------------------------------------------------
-- INTERMEDIATE QUERIES
-- ------------------------------------------------------------------------------------------------------------

-- 5.Find Total Transactions
SELECT 
    COUNT(*) AS total_transactions
FROM
    cleaned_ecommerce_transactions;
/*
Insight:
Total transaction is 1200.
*/

-- 6.What is the Total Revenue?
SELECT 
    ROUND(SUM(TotalPrice),2) AS Revenue_Generated
FROM
    cleaned_ecommerce_transactions;
/*
Insight:
Total Revenue generated is 1264761.96
*/

-- 7.What is average order value?
SELECT 
    ROUND(AVG(TotalPrice), 2) as average
FROM
    cleaned_ecommerce_transactions;
/*
Insight:
The average is 1053.97
*/

-- 8.Show the Sales by Product
SELECT Product,Round(SUM(TotalPrice),2) AS sales
FROM cleaned_ecommerce_transactions
GROUP BY Product
ORDER BY sales DESC;
/*
Insight:
A few products generate most of the revenue.
*/

-- 9.Describe the Customer Spending
SELECT 
    CustomerID, ROUND(SUM(TotalPrice), 2) AS Total_spending
FROM
    cleaned_ecommerce_transactions
GROUP BY CustomerID
ORDER BY Total_spending DESC;
/*
Insight:
Identifies high-value customers.
*/

-- 10.Which payment method is most used?
SELECT 
    PaymentMethod, COUNT(*) AS usage_count
FROM
    cleaned_ecommerce_transactions
GROUP BY PaymentMethod
ORDER BY usage_count DESC;
/*
Insight:
Shows most preferred payment method.
*/

-- 11.Who are top 5 customers?
SELECT 
    CustomerID, ROUND(SUM(TotalPrice), 2) AS Total_spending
FROM
    cleaned_ecommerce_transactions
GROUP BY CustomerID
ORDER BY Total_spending DESC
LIMIT 5;
/*
Insight:
These are the top 5 performing Customers.
*/

-- 12.Date Analysis
SELECT 
    Date, ROUND(SUM(TotalPrice), 2) AS daily_sales
FROM
    cleaned_ecommerce_transactions
GROUP BY Date
ORDER BY Date;
/*
Insight:
Sales fluctuate across different dates indicating varying demand.
*/

-- ------------------------------------------------------------------------------------------------------------
-- ADVANCE QUERIES
-- ------------------------------------------------------------------------------------------------------------

-- 13.Which product has total sales greaten than 5000?
SELECT 
    Product, ROUND(SUM(TotalPrice), 2) AS Total_sales
FROM
    cleaned_ecommerce_transactions
GROUP BY Product
HAVING Total_sales > 5000
ORDER BY Total_sales DESC;
/*
Insight:
Filters only high-performing products.
*/

-- 14.What is the Percentage Contribution of Products?
SELECT 
    Product,
    CONCAT(ROUND((SUM(TotalPrice) * 100) / (SELECT 
                            SUM(TotalPrice)
                        FROM
                            cleaned_ecommerce_transactions),
                    2),
            '%') AS Percentage_contribution
FROM
    cleaned_ecommerce_transactions
GROUP BY Product
ORDER BY Percentage_contribution DESC;
/*
Insight:
Shows contribution of each product to total revenue.
*/

-- 15.Which product generates highest sales?
SELECT 
    Product,ROUND(SUM(TotalPrice),2) AS Total_sales
FROM
    cleaned_ecommerce_transactions
GROUP BY Product
ORDER BY Total_sales DESC
LIMIT 1;
/*
Insight:
The highest selling product is Tablet with total_sales of 195620.11
*/

/*
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
FINAL INSIGHTS:
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

1. Revenue is concentrated among a few top-performing products.
2. A small group of customers contributes significantly to total revenue.
3. The dataset shows presence of high-value transactions impacting revenue.
4. Payment method usage indicates clear customer preference trends.
5. Sales vary across dates, indicating fluctuating demand patterns.
6. Average order value suggests typical customer spending behavior.
7. High-performing products generate a large share of total sales.
*/