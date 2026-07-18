/*
===============================================================================
                         TeleConnect Analytics Hub
===============================================================================

File Name : Customer_Retention_Analysis.sql
Author    : Vishwajit Waghdhare
Database  : TelecomAnalysis

-------------------------------------------------------------------------------
DESCRIPTION
-------------------------------------------------------------------------------

This SQL script contains the queries used to analyze customer
retention, churn, revenue retention, and customer satisfaction.

The analysis focuses on:

• Total Customers
• Total Revenue
• Churn Rate
• Retention Rate
• Average Revenue Per User (ARPU)
• Average Satisfaction
• Revenue Trend
• Customer Type Distribution
• Churn Status Distribution
• Revenue Lost by Subscription Plan
• Revenue by Customer Type

===============================================================================
*/

USE TelecomAnalysis;


-- KPI 1 : Total Customers

SELECT
    COUNT(*) AS Total_Customers
FROM customer_cleaned;


-- KPI 2 : Total Revenue

SELECT
    SUM(MonthlyBill) AS Total_Revenue
FROM customer_cleaned;


-- KPI 3 : Churn Rate

SELECT
    ROUND(
        SUM(CASE
                WHEN ChurnStatus='Yes' THEN 1
                ELSE 0
            END) * 100.0 /
        COUNT(*),
        2
    ) AS Churn_Rate
FROM customer_cleaned;


-- KPI 4 : Retention Rate

SELECT
    ROUND(
        SUM(CASE
                WHEN ChurnStatus='No' THEN 1
                ELSE 0
            END) * 100.0 /
        COUNT(*),
        2
    ) AS Retention_Rate
FROM customer_cleaned;


-- KPI 5 : Average Revenue Per User (ARPU)

SELECT
    ROUND(
        AVG(MonthlyBill),
        2
    ) AS ARPU
FROM customer_cleaned;


-- KPI 6 : Average Satisfaction

SELECT
    ROUND(
        AVG(SatisfactionScore),
        2
    ) AS Average_Satisfaction
FROM customer_cleaned;


-- Revenue Trend

SELECT
    MONTHNAME(JoinDate) AS Month,
    SUM(MonthlyBill) AS Total_Revenue
FROM customer_cleaned
GROUP BY
    MONTH(JoinDate),
    MONTHNAME(JoinDate)
ORDER BY
    MONTH(JoinDate);


-- Customer Type Distribution

SELECT
    CustomerType,
    COUNT(*) AS Total_Customers
FROM customer_cleaned
GROUP BY CustomerType
ORDER BY Total_Customers DESC;


-- Churn Status Distribution

SELECT
    ChurnStatus,
    COUNT(*) AS Customers
FROM customer_cleaned
GROUP BY ChurnStatus
ORDER BY Customers DESC;


-- Revenue Lost by Subscription Plan

SELECT
    PlanName,
    SUM(RevenueLost) AS Revenue_Lost
FROM customer_cleaned
GROUP BY PlanName
ORDER BY Revenue_Lost DESC;

-- Revenue by Customer Type

SELECT
    CustomerType,
    SUM(MonthlyBill) AS Total_Revenue
FROM customer_cleaned
GROUP BY CustomerType
ORDER BY Total_Revenue DESC;
