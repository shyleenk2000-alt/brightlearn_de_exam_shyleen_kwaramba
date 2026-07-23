# BrightLearn Sales 

# Data Quality Findings Report

**Author:** Shyleen Kwaramba

---

# Table of Contents

- Introduction
- Project Objectives
- ETL Process
- Data Warehouse Design
- Challenges Encountered and Solutions
- Business Questions
- Key Findings
- Skills Demonstrated
- Lessons Learned
- Conclusion

---

# Introduction

This project involved designing and implementing a Sales Data Warehouse for BrightLearn using SQL Server. The objective was to transform raw sales data into clean, structured and reliable data that supports reporting and business decision making.

The project followed a complete ETL (Extract, Transform and Load) process consisting of three database layers:

- Staging Database
- Cleaning Database
- Data Warehouse

The raw CSV file was first loaded into the staging database. The data was then cleaned and standardised in the cleaning layer before being loaded into a star schema in the data warehouse. The completed warehouse was used to answer important business questions related to sales performance, customer behaviour, inventory management and store performance.

---

# Project Objectives

The objectives of this project were to:

- Build a complete ETL pipeline using SQL Server.
- Design and implement a star schema.
- Improve data quality through data cleaning.
- Automate the ETL process using stored procedures.
- Prevent duplicate records during data loading.
- Build a reliable data warehouse for reporting.
- Answer business questions using SQL.

---

# ETL Process

## Staging Layer

The staging database served as the landing area for the raw BrightLearn CSV dataset.

Activities completed:

- Imported the raw CSV file.
- Preserved the original data without modifications.
- Used the staging tables as the source for the cleaning process.

---

## Cleaning Layer

The cleaning layer improved the quality of the data before it was loaded into the warehouse.

### Cleaning techniques applied

- Removed duplicate records using `SELECT DISTINCT`.
- Prevented duplicate inserts using `WHERE NOT EXISTS`.
- Removed leading and trailing spaces using `LTRIM()` and `RTRIM()`.
- Standardised text values using `LOWER()`.
- Filtered blank values using `<> ''`.
- Removed records containing `NULL` values using `IS NOT NULL`.
- Converted inconsistent date formats using `TRY_CONVERT()` together with `COALESCE()`.
- Standardised customer, supplier, cashier, payment method, product and store information.
- Automated the cleaning process using stored procedures.

---

## Data Warehouse Layer

The cleaned data was loaded into a star schema.

### Dimension Tables

- DimCustomer
- DimProduct
- DimStore
- DimDate
- DimPaymentMethod
- DimCashier
- DimSupplier

### Fact Table

- FactSales

The fact table stores measurable business information while the dimension tables store descriptive information used for reporting and analysis.

---

# Data Warehouse Design

The warehouse was designed using a star schema because it improves query performance and simplifies reporting.

### Fact Table Measures

- Transaction Date
- Transaction Discount
- Line Amount
- Unit Price
- Cost Price
- Quantity
- Stock on Hand
- Reorder Threshold

### Dimension Tables

The FactSales table references:

- Customer
- Product
- Store
- Date
- Payment Method
- Cashier
- Supplier

This structure allows sales to be analysed from multiple business perspectives while reducing data redundancy.

---

# Challenges Encountered and Solutions

## 1. Inconsistent Date Formats

### Challenge

The raw dataset contained several date formats, including:

- yyyy-mm-dd
- yyyy/mm/dd
- dd-mm-yyyy
- dd/mm/yyyy
- dd Mon yyyy

These formats caused conversion errors when loading the data into SQL Server.

### Solution

I used `TRY_CONVERT()` together with `COALESCE()` to test multiple date formats and return the first successful conversion. This ensured that every valid date was stored using the SQL `DATE` data type.

---

## 2. Duplicate Records

### Challenge

Running stored procedures multiple times initially created duplicate records in the cleaning layer and dimension tables.

### Solution

I used:

- `SELECT DISTINCT` to remove duplicate records from the source data.
- `WHERE NOT EXISTS` to prevent duplicate inserts whenever the stored procedures were executed again.

This made the ETL process safe to rerun.

---

## 3. Blank Values

### Challenge

Some records contained blank values instead of `NULL`.

### Solution

I filtered blank values using:

```sql
<> ''
```

This prevented incomplete records from being loaded into the cleaning layer.

---

## 4. NULL Values

### Challenge

Some important fields contained `NULL` values.

### Solution

I excluded incomplete records using:

```sql
IS NOT NULL
```

This improved data quality and maintained relationships between the fact and dimension tables.

---

## 5. Inconsistent Text Formatting

### Challenge

The raw dataset contained inconsistent spacing and text formatting.

### Solution

I standardised the data by:

- Removing extra spaces using `LTRIM()` and `RTRIM()`.
- Converting text values to lowercase using `LOWER()`.

This ensured consistency throughout the warehouse.

---

## 6. Fact Table Design

### Challenge

Initially there was no cleaned transactional table available for loading the fact table.

### Solution

I created a `cleaned_sales` table in the cleaning layer. The FactSales table was then loaded by joining the cleaned sales table with all dimension tables to retrieve surrogate keys.

---

## 7. Duplicate Dates in DimDate

### Challenge

The DimDate table initially contained duplicate transaction dates.

### Solution

I modified the stored procedure to use:

- `SELECT DISTINCT`
- `WHERE NOT EXISTS`

This ensured each transaction date appeared only once.

---

# Business Questions

The completed data warehouse answered the following business questions:

1. What are the top five best-selling products by revenue?
2. How much revenue does each store generate every month?
3. What is the month-over-month revenue growth?
4. Who are the top ten customers based on total spending?
5. Which loyalty customers have not made a purchase since 28 April 2024?
6. What is the average transaction value for each loyalty tier?
7. How many products were sold by category in each store?
8. Which products have stock levels below their reorder threshold?

---

# Key Findings

## Product Performance

- A small number of products generated a significant share of total revenue.
- Products such as the Samsung Galaxy A14 64GB, JBL Clip 4 Bluetooth Speaker and Padded Winter Jacket consistently ranked among the top-performing products.

**Business Insight**

These products should be prioritised for stock replenishment and promotional campaigns because they contribute significantly to overall revenue.

---

## Store Performance

- Revenue varied across stores.
- Some stores consistently outperformed others.

**Business Insight**

Management can use high-performing stores as benchmarks and develop improvement strategies for lower-performing branches.

---

## Sales Trends

- Monthly revenue increased during some months and declined during others.

**Business Insight**

Understanding these trends helps improve inventory planning, staffing and promotional activities.

---

## Customer Behaviour

- Gold loyalty customers recorded the highest average transaction value.
- Loyal customers contributed significantly to overall revenue.

**Business Insight**

Expanding the loyalty programme could improve customer retention and increase sales.

---

## Customer Retention

- Several loyalty customers had not made purchases since 28 April 2024.

**Business Insight**

These customers can be targeted through personalised promotions and customer retention campaigns.

---

## Inventory Management

- Inventory levels remained above the reorder threshold during the reporting period.

**Business Insight**

Current inventory management practices appear effective, but stock levels should continue to be monitored regularly.

---

# Skills Demonstrated

This project demonstrates practical experience in:

- ETL pipeline development
- SQL Server development
- Data cleaning and validation
- Stored procedure development
- Star schema design
- Fact and dimension modelling
- SQL joins
- Aggregate functions
- Window functions
- Date standardisation
- Duplicate prevention
- Business intelligence reporting
- Analytical SQL queries
- Git and GitHub version control

---

# Lessons Learned

This project strengthened my understanding of the complete ETL process and the importance of maintaining high-quality data before analysis.

Through this project, I gained practical experience in:

- Designing a star schema.
- Building an ETL pipeline.
- Cleaning and validating raw data.
- Handling inconsistent date formats.
- Filtering blank values and `NULL` values.
- Preventing duplicate records.
- Writing reusable stored procedures.
- Building fact and dimension tables.
- Writing SQL queries to answer real business questions.

The project also improved my problem-solving skills by requiring me to investigate, test and resolve data quality issues throughout the ETL process.

---

# Conclusion

The BrightLearn Sales Data Warehouse project successfully transformed raw transactional data into a structured and reliable reporting solution.

By implementing staging, cleaning and data warehouse layers, the project improved data quality, automated the ETL process and produced reliable data for reporting and analysis.

The final solution provides meaningful insights into product performance, customer behaviour, store performance, sales trends and inventory management. These insights support informed business decisions and demonstrate how data engineering can transform raw operational data into valuable business intelligence.

Overall, this project strengthened my practical skills in SQL Server, ETL development, data cleaning, dimensional modelling, stored procedures and analytical SQL while delivering a complete end-to-end data engineering solution suitable for a professional portfolio.
