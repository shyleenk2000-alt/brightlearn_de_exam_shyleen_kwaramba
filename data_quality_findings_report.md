Introduction

The purpose of this project was to design and implement a Sales Data Warehouse for BrightLearn using SQL Server. The project involved building a complete ETL (Extract, Transform and Load) pipeline that transformed raw sales data into clean, structured, and meaningful information for business reporting and analysis.

The project followed a layered architecture consisting of a staging database, a cleaning database, and a data warehouse. Raw data was first imported from a CSV file into the staging layer, cleaned and standardised using stored procedures in the cleaning layer, and finally loaded into a star schema in the data warehouse.

The completed data warehouse was then used to answer important business questions related to customer behaviour, product performance, store performance, sales trends, and inventory management.

Project Objectives

The objectives of this project were to:

Build a complete ETL pipeline using SQL Server.
Design and implement a star schema.
Clean and standardise raw sales data.
Automate data loading using stored procedures.
Improve data quality before loading the warehouse.
Prevent duplicate records during ETL execution.
Generate business insights using SQL queries.
ETL Process

The ETL pipeline was divided into three stages.

1. Staging Layer

The raw BrightLearn CSV dataset was imported directly into the staging database without making any changes.

This layer acted as the landing area for all incoming data and preserved the original dataset for future reference.

2. Cleaning Layer

The cleaning layer was responsible for improving data quality before loading the warehouse.

The following cleaning techniques were applied:

Removed duplicate records using SELECT DISTINCT.
Prevented duplicate inserts using WHERE NOT EXISTS.
Removed unnecessary spaces using LTRIM() and RTRIM().
Standardised text using LOWER().
Removed blank values using <> ''.
Removed incomplete records using IS NOT NULL.
Converted multiple date formats into SQL DATE format using TRY_CONVERT() together with COALESCE().
Standardised customer, product, supplier, cashier, payment method and store information.
Automated all cleaning processes using stored procedures.
3. Data Warehouse Layer

The cleaned data was loaded into a star schema.

The warehouse consists of:

Dimension Tables
DimCustomer
DimProduct
DimStore
DimDate
DimPaymentMethod
DimCashier
DimSupplier
Fact Table
FactSales

The fact table stores business measures while the dimension tables provide descriptive information for reporting and analysis.

Challenges Encountered

Building the ETL pipeline presented several challenges that required investigation and problem solving.

1. Multiple Date Formats

The raw dataset contained dates in different formats such as:

yyyy-mm-dd
yyyy/mm/dd
dd-mm-yyyy
dd/mm/yyyy
dd Mon yyyy

This caused conversion errors when importing data into SQL Server.

Solution

The dates were converted using TRY_CONVERT() with multiple conversion styles. COALESCE() was then used to return the first successful conversion, ensuring that all dates were stored consistently as the SQL DATE data type.

2. Duplicate Records

Running stored procedures multiple times initially created duplicate records in the cleaning layer and dimension tables.

Solution

Duplicate source records were removed using SELECT DISTINCT.

To prevent duplicate inserts after rerunning stored procedures, WHERE NOT EXISTS was implemented so that only new records were inserted.

3. Blank Values

Some records contained blank values rather than NULL values.

For example:

customer_email = ''

Although the value was not NULL, it still represented missing data.

Solution

Blank values were removed using:

<> ''

This ensured that important business fields contained meaningful information before loading the warehouse.

4. NULL Values

Some business fields contained NULL values which could affect relationships between fact and dimension tables.

Solution

The cleaning process filtered these records using:

IS NOT NULL

This improved data quality and maintained referential integrity.

5. Inconsistent Text Formatting

Names, cities, suppliers, products and stores contained inconsistent spacing and letter casing.

Examples included:

Samsung

 samsung

SAMSUNG
Solution

Text was cleaned using:

LTRIM()
RTRIM()
LOWER()

This standardised all text values throughout the warehouse.

6. Fact Table Design

Initially it was unclear how the FactSales table should be populated because the cleaning layer did not contain a transactional table.

Solution

A cleaned_sales table was created to hold cleaned transaction data.

The FactSales table was then populated by joining the cleaned sales table with every dimension table to retrieve surrogate keys.

7. Preventing Duplicate Dates

Duplicate dates appeared in the cleaned DimDate table after running the stored procedure.

Solution

The stored procedure was updated to use SELECT DISTINCT together with WHERE NOT EXISTS so that each transaction date appeared only once.

Business Questions

The completed warehouse was used to answer the following business questions.

What are the top five best-selling products by revenue?
How much revenue does each store generate every month?
What is the month-over-month revenue growth?
Who are the top ten customers based on total spending?
Which loyalty customers have not made a purchase since 28 April 2024?
What is the average transaction value for each loyalty tier?
How many products were sold by category in each store?
Which products have stock levels below their reorder threshold?
Project Findings
Product Performance

The analysis showed that a small number of products generated a significant percentage of the company's total revenue. Products such as the Samsung Galaxy A14 64GB, JBL Clip 4 Bluetooth Speaker and Padded Winter Jacket consistently ranked among the best-selling products.

Finding

These products should be prioritised for stock replenishment, promotions and marketing campaigns because they contribute significantly to overall revenue.

Store Performance

Revenue varied across stores throughout the reporting period. Some branches consistently outperformed others while a few generated lower monthly sales.

Finding

Management can use these results to identify successful sales strategies in high-performing stores and apply similar approaches to improve lower-performing branches.

Sales Trends

Monthly revenue changed throughout the reporting period, with some months showing strong growth while others experienced declines.

Finding

Understanding monthly sales patterns allows the business to prepare for seasonal demand by improving stock planning, staffing levels and promotional activities.

Customer Behaviour

Gold loyalty customers recorded the highest average transaction values compared to Silver and Bronze customers.

Finding

The loyalty programme appears to encourage higher customer spending. Strengthening customer rewards and retention strategies could further increase revenue.

Customer Retention

Several loyalty customers had not made purchases since 28 April 2024.

Finding

These inactive customers represent an opportunity for targeted marketing campaigns, personalised promotions and loyalty incentives to encourage repeat purchases.

Product Categories

Different product categories performed differently across stores.

Finding

Each store should manage inventory according to local customer demand instead of using identical stock levels across all branches.

Inventory Management

Inventory levels were compared against reorder thresholds.

Finding

No products were found to be below their reorder thresholds during the reporting period, indicating that inventory levels were generally well maintained.

Skills Demonstrated

This project demonstrates practical knowledge and experience in:

SQL Server database development
ETL pipeline development
Data warehouse design
Star schema modelling
Data cleaning and validation
Stored procedure development
SQL joins
Aggregate functions
Window functions
Data quality management
Duplicate prevention
Date standardisation
Business intelligence reporting
Analytical SQL queries
Git and GitHub version control
Lessons Learned

Completing this project strengthened my understanding of how raw business data can be transformed into reliable information through a structured ETL process.

I gained practical experience in designing a star schema, writing stored procedures, cleaning inconsistent data, preventing duplicate records, handling different date formats, filtering blank and NULL values, and building analytical SQL queries that answer real business questions.

The project also improved my problem-solving skills, as I encountered several technical challenges that required testing, debugging and refining my SQL code until the ETL pipeline worked correctly.

Conclusion

The BrightLearn Sales Data Warehouse project successfully transformed raw transactional data into a structured and reliable reporting solution.

By implementing separate staging, cleaning and data warehouse layers, the project ensured that data quality was improved before analysis. The use of stored procedures automated the ETL process, while the star schema enabled efficient querying and reporting.

The business analysis provided valuable insights into product performance, customer spending, store performance, sales trends and inventory management. These findings can support better business decisions and demonstrate how data engineering can turn raw operational data into meaningful business intelligence.

Overall, this project strengthened my practical skills in SQL Server, ETL development, data cleaning, dimensional modelling and business analytics, while providing a complete end-to-end data engineering solution suitable for a professional portfolio.



