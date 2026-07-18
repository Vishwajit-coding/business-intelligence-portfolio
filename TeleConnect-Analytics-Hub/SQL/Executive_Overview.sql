/*
===============================================================================
                           TeleConnect Analytics Hub
===============================================================================

File Name : Executive_Overview.sql

Description:
This SQL script contains the queries used to generate the KPIs
and metrics displayed in the Executive Overview dashboard.

Dashboard KPIs
--------------
• Total Customers
• Total Revenue
• Churn Rate
• Revenue Loss %
• Average Satisfaction

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
                WHEN ChurnStatus = 'Yes' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate
FROM customer_cleaned;


-- KPI 4 : Revenue Loss Percentage


SELECT
    ROUND(
        SUM(RevenueLost) * 100.0 /
        SUM(MonthlyBill),
        2
    ) AS Revenue_Loss_Percentage
FROM customer_cleaned;


-- KPI 5 : Average Satisfaction Score

SELECT
    ROUND(
        AVG(SatisfactionScore),
        2
    ) AS Average_Satisfaction
FROM customer_cleaned;

-- Additional Executive Metrics

-- Customer Retention Rate

SELECT
    ROUND(
        SUM(CASE
                WHEN ChurnStatus = 'No' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*),
        2
    ) AS Retention_Rate
FROM customer_cleaned;


-- Churn Distribution

SELECT
    ChurnStatus,
    COUNT(*) AS Customers
FROM customer_cleaned
GROUP BY ChurnStatus;


-- Average Monthly Bill

SELECT
    ROUND(
        AVG(MonthlyBill),
        2
    ) AS Average_Monthly_Bill
FROM customer_cleaned;
