/*
===============================================================================
                         TeleConnect Analytics Hub
===============================================================================

File Name : Customer_Analysis.sql
Author    : Vishwajit Waghdhare
Database  : TelecomAnalysis

-------------------------------------------------------------------------------
DESCRIPTION
-------------------------------------------------------------------------------

This SQL script contains the queries used to analyze customer
demographics, segmentation, and churn behavior.

The analysis focuses on:

• Customer Type
• Gender
• Age Group
• State
• City

===============================================================================
*/

USE TelecomAnalysis;

-- KPI 1 : Total Customers

SELECT
    COUNT(*) AS Total_Customers
FROM customer_cleaned;

-- KPI 2 : Average Customer Age

SELECT
    ROUND(AVG(Age),0) AS Average_Age
FROM customer_cleaned;

-- KPI 3 : Churn Rate

SELECT
    ROUND(
        SUM(CASE WHEN ChurnStatus='Yes' THEN 1 ELSE 0 END)
        *100.0/
        COUNT(*),
        2
    ) AS Churn_Rate
FROM customer_cleaned;

-- KPI 4 : Churn Customers

SELECT
    COUNT(*) AS Churn_Customers
FROM customer_cleaned
WHERE ChurnStatus='Yes';

-- Customer Analysis by Customer Type

SELECT
    CustomerType,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN ChurnStatus = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN ChurnStatus = 'Yes' THEN 1 ELSE 0 END) * 100.0 /
        COUNT(*),
        2
    ) AS Churn_Rate
FROM customer_cleaned
GROUP BY CustomerType;


-- Customer Distribution by Gender

SELECT
    Gender,
    COUNT(*) AS Customers,
    SUM(CASE WHEN ChurnStatus = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers
FROM customer_cleaned
GROUP BY Gender;

-- Customer Analysis by Age Group

SELECT
    AgeGroup,
    COUNT(*) AS Customers,
    SUM(CASE WHEN ChurnStatus = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers
FROM customer_cleaned
GROUP BY AgeGroup
ORDER BY AgeGroup;

-- Customer Analysis by State

SELECT
    State,
    COUNT(*) AS Customers,
    SUM(CASE WHEN ChurnStatus = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers
FROM customer_cleaned
GROUP BY State
ORDER BY Churned_Customers DESC;

-- Top 10 Cities by Churn Customers

SELECT
    City,
    COUNT(*) AS Customers,
    SUM(CASE WHEN ChurnStatus = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers
FROM customer_cleaned
GROUP BY City
ORDER BY Churned_Customers DESC
LIMIT 10;
