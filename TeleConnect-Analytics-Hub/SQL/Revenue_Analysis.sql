/*
===============================================================================
                         TeleConnect Analytics Hub
===============================================================================

File Name : Revenue_Analysis.sql
Author    : Vishwajit Waghdhare
Database  : TelecomAnalysis

-------------------------------------------------------------------------------
DESCRIPTION
-------------------------------------------------------------------------------

This SQL script contains the queries used to analyze revenue
performance across subscription plans and customer segments.

The analysis focuses on:

• Total Revenue
• Revenue Lost
• Revenue Loss Rate
• Average Revenue Per User (ARPU)
• Revenue by Plan
• Revenue Lost by Plan
• Revenue by Customer Type

===============================================================================
*/

USE TelecomAnalysis;


-- KPI 1 : Total Revenue

SELECT
    SUM(MonthlyBill) AS Total_Revenue
FROM customer_cleaned;


-- KPI 2 : Revenue Lost


SELECT
    SUM(RevenueLost) AS Revenue_Lost
FROM customer_cleaned;


-- KPI 3 : Revenue Loss Rate


SELECT
    ROUND(
        SUM(RevenueLost) * 100.0 /
        SUM(MonthlyBill),
        2
    ) AS Revenue_Loss_Rate
FROM customer_cleaned;


-- KPI 4 : Average Revenue Per User (ARPU)


SELECT
    ROUND(
        AVG(MonthlyBill),
        2
    ) AS ARPU
FROM customer_cleaned;


-- Revenue by Subscription Plan


SELECT
    PlanName,
    AVG(MonthlyBill) AS Average_Bill,
    SUM(MonthlyBill) AS Total_Revenue
FROM customer_cleaned
GROUP BY PlanName
ORDER BY Total_Revenue DESC;


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


-- Monthly Revenue Trend

SELECT
    MONTHNAME(JoinDate) AS Month,
    SUM(MonthlyBill) AS Revenue
FROM customer_cleaned
GROUP BY
    MONTH(JoinDate),
    MONTHNAME(JoinDate)
ORDER BY
    MONTH(JoinDate);
