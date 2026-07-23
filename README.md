##BrightLearn_Sales_Data_Project

##Overview

This project demonstrates the design and implementation of a Sales Data Warehouse for BrightLearn using SQL Server. The objective was to transform raw sales data into clean, structured, and reliable data that supports business reporting and decision making.

The project follows a complete ETL process consisting of a staging layer, a cleaning layer, and a data warehouse layer. Raw sales data was imported from a CSV file into the staging database, cleaned and standardised using stored procedures, and then loaded into a star schema data warehouse. The final warehouse was used to answer business questions related to sales performance, customer behaviour, inventory management, and store performance.

##Project Objectives

The main objectives of this project were to:

-Build a complete ETL pipeline using SQL Server.
-Design a star schema data warehouse.
-Clean and standardise raw sales data.
-Automate the ETL process using stored procedures.
-Prevent duplicate records during data loading.
-Improve data quality before loading the data warehouse.
-Generate business insights using SQL queries.

##Technologies Used
-SQL Server
-SQL Server Management Studio (SSMS)
-T-SQL
-Git
-GitHub
-Draw.io

##ETL Architecture

The project follows a three-layer ETL architecture.

##Staging Layer

The staging database stores the raw CSV file exactly as received. No transformations are performed in this layer. It serves as the landing area for incoming data.

##Cleaning Layer

The cleaning layer improves the quality of the data before it is loaded into the data warehouse.

##The cleaning process includes:

-Removing duplicate records using SELECT DISTINCT.
-Preventing duplicate inserts using WHERE NOT EXISTS.
-Removing leading and trailing spaces using LTRIM() and RTRIM().
-Converting text values to lowercase using LOWER().
-Filtering out blank values using <> ''.
-Filtering out NULL values using IS NOT NULL.
-Converting inconsistent date formats into the SQL DATE data type using TRY_CONVERT() together with COALESCE().
-Standardising customer, product, supplier, cashier, payment method and store information.
-Loading cleaned data using stored procedures.

##Data Warehouse Layer

The cleaned data is loaded into a star schema consisting of dimension tables and a fact table.

##The dimension tables are:

-DimCustomer
-DimProduct
-DimStore
-DimDate
-DimPaymentMethod
-DimCashier
-DimSupplier

##The fact table is:

-FactSales

The FactSales table stores the measurable business data while the dimension tables provide descriptive business information used for reporting and analysis.

##Database Design

The data warehouse was designed using a star schema.

The fact table stores transactional measures including:

-Transaction Discount
-Line Amount
-Unit Price
-Cost Price
-Quantity
-Stock on Hand
-Reorder Threshold

The dimension tables store descriptive information about customers, products, stores, suppliers, cashiers, payment methods and dates.

This design improves query performance, simplifies reporting, and supports analytical queries.

##Data Cleaning Process

Data quality was improved before loading the warehouse by applying several cleaning techniques.

-Removed duplicate records using SELECT DISTINCT.
-Prevented duplicate inserts using WHERE NOT EXISTS.
-Removed unnecessary spaces using LTRIM() and RTRIM().
-Converted text values to lowercase using LOWER().
-Removed blank values using <> ''.
-Removed records containing NULL values using IS NOT NULL.
-Converted multiple date formats into a single SQL DATE format using TRY_CONVERT() and COALESCE().
-Standardised customer, product, supplier, store, cashier and payment method information.
-Automated the cleaning process using stored procedures.

##Challenges Encountered

During the development of this project several challenges were encountered while building the ETL pipeline.

##Inconsistent Date Formats

The raw dataset contained multiple date formats including:

-yyyy-mm-dd
-yyyy/mm/dd
-dd-mm-yyyy
-dd/mm/yyyy
-dd Mon yyyy

These inconsistent formats caused errors when converting dates into the SQL DATE data type.

##Solution

I used TRY_CONVERT() together with COALESCE() to test multiple date formats until a valid date was found. This ensured that all dates were standardised before being loaded into the cleaning layer.

##Duplicate Records

Running stored procedures multiple times initially resulted in duplicate records being inserted into the cleaning layer and dimension tables.

##Solution

I used SELECT DISTINCT to remove duplicate source records and WHERE NOT EXISTS to ensure only new records were inserted each time a stored procedure was executed.

##Blank Values

Some records contained empty values even though they were not NULL.

##Solution

I filtered these records using:

<> ''

This prevented blank customer names, emails, SKUs and other important business fields from being loaded into the cleaning layer.

##NULL Values

Several important business fields contained NULL values.

##Solution

I excluded invalid records using:

IS NOT NULL

This ensured that only complete and meaningful records were loaded into the warehouse.

##Inconsistent Text Formatting

The raw dataset contained inconsistent capitalisation together with unnecessary leading and trailing spaces.

##Solution

I standardised all text by removing spaces with LTRIM() and RTRIM() and converting text values to lowercase using LOWER().

##Building the Fact Table

Initially, it was unclear how the FactSales table should be populated because no fact table existed in the cleaning layer.

##Solution

I created a cleaned_sales table that stores cleaned transactional data. The FactSales table was then populated by joining the cleaned sales data with the dimension tables to retrieve surrogate keys before loading the warehouse.

##Business Questions Answered

The data warehouse answers the following business questions:

-What are the top five best-selling products by revenue?
-How much revenue does each store generate every month?
-What is the month-over-month revenue growth?
-Who are the top ten customers based on total spending?
-Which loyalty customers have not made a purchase since 28 April 2024?
-What is the average transaction value for each loyalty tier?
-How many products were sold by category in each store?
-Which products have stock levels below their reorder threshold?

##Key Findings

The analysis produced several valuable business insights.

-A small number of products generated a significant share of total revenue, making them the company's strongest performing products.
-Gold loyalty customers recorded the highest average transaction value, showing the importance of maintaining and expanding the loyalty programme.
-Sales performance varied across stores, allowing management to identify high-performing branches and stores that may require additional support.
-Monthly revenue fluctuated during the reporting period, providing valuable insights into sales trends and seasonal demand.
Customer purchasing behaviour highlighted opportunities to re-engage inactive loyalty customers through targeted marketing campaigns.
-Inventory analysis showed that stock levels were generally well maintained, with no products falling below their reorder thresholds during the reporting period.

##Skills Demonstrated

This project demonstrates practical experience in:

-ETL pipeline development
-Data cleaning and validation
-SQL Server database development
-T-SQL programming
-Stored procedure development
-Star schema design
-Fact and dimension modelling
-Data warehouse implementation
-Duplicate prevention techniques
-Date standardisation
-SQL joins
-Aggregate functions
-Window functions
-Business intelligence reporting
-Analytical SQL queries

##Future Improvements

Future enhancements for this project include:

-Building the ETL pipeline using SSIS.
-Creating interactive Power BI dashboards connected to the data warehouse.
-Scheduling automatic ETL jobs using SQL Server Agent.
-Implementing Slowly Changing Dimensions (SCD) to preserve historical data.
-Expanding the warehouse with additional dimensions and business metrics.

##Conclusion

This project demonstrates the complete process of transforming raw transactional data into a structured data warehouse that supports business reporting and analysis.

By implementing a staging layer, a cleaning layer, and a star schema data warehouse, the project improved data quality, automated the ETL process using stored procedures, and produced reliable data for reporting.

The project strengthened my practical understanding of data engineering concepts including ETL development, SQL Server, data cleaning, stored procedures, star schema design, and analytical SQL. It also demonstrated how well-designed data warehouses can help organisations make informed, data-driven business decisions
