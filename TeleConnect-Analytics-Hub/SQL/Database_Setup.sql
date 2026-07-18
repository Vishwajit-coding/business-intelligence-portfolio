/*
===============================================================================
                         TeleConnect Analytics Hub
===============================================================================

Project Name : TeleConnect Analytics Hub
Industry     : Telecommunications
Database     : MySQL 9.7
Author       : Vishwajit Waghdhare


DESCRIPTION
-------------------------------------------------------------------------------

This SQL script is used to set up the database for the
TeleConnect Analytics Hub project.

The script performs the following tasks:

1. Creates the database
2. Selects the database
3. Creates the customer table
4. Imports the cleaned CSV dataset
5. Verifies that the data has been imported successfully

===============================================================================
*/

-- STEP 1 : Create Database

CREATE DATABASE TelecomAnalysis;

-- STEP 2 : Use Database

USE telecomanalysis;


-- STEP 3 : Create Customer Table

CREATE TABLE customer_cleaned (

    CustomerID VARCHAR(20),	

    Gender VARCHAR(10),

    Age INT,

    City VARCHAR(100),

    State VARCHAR(100),

    CustomerType VARCHAR(20),

    PlanName VARCHAR(100),

    MonthlyBill INT,

    TenureMonths INT,

    ComplaintCount INT,

    ComplaintCategory VARCHAR(50),

    DataUsageGB DECIMAL(10,2),

    CallMinutes INT,

    PaymentMethod VARCHAR(50),

    SatisfactionScore INT,

    ChurnStatus VARCHAR(5),

    JoinDate DATE,

    LastRechargeDate DATE,

    AgeGroup VARCHAR(20),

    TenureGroup VARCHAR(20),

    RevenueLost INT,
    
    ComplaintLevel VARCHAR(20)
);

-- STEP 4 : Import CSV Dataset

/*

IMPORTANT

Before executing the command below:

1. Copy the CSV file into

C:\ProgramData\MySQL\MySQL Server 9.7\Uploads\

2. Ensure the file name matches exactly.

*/

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 9.7/Uploads/Customer_Cleaned_csv.csv'

INTO TABLE customer_cleaned

FIELDS TERMINATED BY ','

ENCLOSED BY '"'

LINES TERMINATED BY '\n'

IGNORE 1 ROWS;


-- STEP 5 : Verify Imported Records

SELECT
COUNT(*) AS Total_Customers
FROM customer_cleaned;


-- STEP 6 : Preview Dataset

SELECT *
FROM customer_cleaned
LIMIT 10;


-- STEP 7 : Check Table Structure

DESCRIBE customer_cleaned;


-- STEP 8 : Database Setup Completed

/*

Database setup completed successfully.

Expected Output

Database Created       : TelecomAnalysis

Table Created          : Customer_Cleaned

Records Imported       : 30,000

*/