# BrightLearn Sales Data Warehouse

## **Overview**

This project demonstrates the design and implementation of a Sales Data Warehouse for BrightLearn using SQL Server. The objective was to transform raw sales data into clean, structured, and reliable data that supports business reporting and decision making.

The project follows a complete ETL process consisting of a staging layer, a cleaning layer, and a data warehouse layer. Raw sales data was imported from a CSV file into the staging database, cleaned and standardised using stored procedures, and then loaded into a star schema data warehouse.

The completed warehouse was used to answer business questions related to sales performance, customer behaviour, inventory management, and store performance.

---

## **Project Objectives**

The objectives of this project were to:

- Build a complete ETL pipeline using SQL Server.
- Design and implement a star schema.
- Clean and standardise raw sales data.
- Automate data loading using stored procedures.
- Prevent duplicate records during data loading.
- Improve data quality before loading the warehouse.
- Generate business insights using SQL queries.

---

## **Technologies Used**

- SQL Server
- SQL Server Management Studio (SSMS)
- T-SQL
- Git
- GitHub
- Draw.io

---

## **ETL Architecture**

The project follows a three-layer ETL architecture.

### **Staging Layer**

- Loaded the raw CSV file into the staging database.
- No transformations were performed.
- Preserved the original source data.

### **Cleaning Layer**

The cleaning layer improved the quality of the data before loading it into the warehouse.

Cleaning techniques included:

- Removing duplicate records using `SELECT DISTINCT`.
- Preventing duplicate inserts using `WHERE NOT EXISTS`.
- Removing leading and trailing spaces using `LTRIM()` and `RTRIM()`.
- Standardising text using `LOWER()`.
- Removing blank values using `<> ''`.
- Removing `NULL` values using `IS NOT NULL`.
- Converting inconsistent date formats using `TRY_CONVERT()` together with `COALESCE()`.
- Standardising customer, supplier, product, store, cashier and payment method information.
- Loading cleaned data using stored procedures.

### **Data Warehouse Layer**

The cleaned data was loaded into a star schema consisting of:

**Dimension Tables**

- DimCustomer
- DimProduct
- DimStore
- DimDate
- DimPaymentMethod
- DimCashier
- DimSupplier

**Fact Table**

- FactSales

The FactSales table stores business measures while the dimension tables provide descriptive information used for reporting and analysis.

---

## **Database Design**

The data warehouse was designed using a star schema.

The FactSales table stores measures including:

- Transaction Discount
- Line Amount
- Unit Price
- Cost Price
- Quantity (Qty)
- Stock on Hand
- Reorder Threshold

The dimension tables store descriptive information about:

- Customers
- Products
- Stores
- Dates
- Suppliers
- Cashiers
- Payment Methods

This design improves reporting performance and simplifies analytical queries.

---

## **Data Cleaning Process**

Several data quality checks and cleaning techniques were applied before loading the warehouse.

- Removed duplicate records using `SELECT DISTINCT`.
- Prevented duplicate inserts using `WHERE NOT EXISTS`.
- Removed unnecessary spaces using `LTRIM()` and `RTRIM()`.
- Converted text values to lowercase using `LOWER()`.
- Removed blank values using `<> ''`.
- Removed records containing `NULL` values using `IS NOT NULL`.
- Converted multiple date formats into a single SQL `DATE` format using `TRY_CONVERT()` and `COALESCE()`.
- Standardised customer, supplier, store, product, cashier and payment information.
- Automated the ETL process using stored procedures.

---

## **Challenges Encountered**

During the development of this project, several challenges were encountered.

### **Inconsistent Date Formats**

The raw dataset contained multiple date formats, which caused conversion errors.

**Solution**

- Used `TRY_CONVERT()` with different date styles.
- Used `COALESCE()` to return the first successful conversion.
- Standardised all dates to the SQL `DATE` data type.

### **Duplicate Records**

Running stored procedures multiple times initially inserted duplicate records.

**Solution**

- Used `SELECT DISTINCT` to remove duplicate source records.
- Used `WHERE NOT EXISTS` to prevent duplicate inserts.

### **Blank Values**

Some fields contained blank values instead of `NULL`.

**Solution**

- Filtered blank values using `<> ''`.

### **NULL Values**

Some important business fields contained `NULL` values.

**Solution**

- Removed incomplete records using `IS NOT NULL`.

### **Inconsistent Text Formatting**

Names, cities, suppliers and products contained inconsistent spacing and letter casing.

**Solution**

- Removed extra spaces using `LTRIM()` and `RTRIM()`.
- Standardised text using `LOWER()`.

### **Fact Table Design**

Initially there was no transactional table in the cleaning layer to use when loading the fact table.

**Solution**

- Created a `cleaned_sales` table.
- Loaded the FactSales table by joining `cleaned_sales` with all dimension tables to retrieve surrogate keys.

---

## **Business Questions Answered**

The project answers the following business questions:

1. What are the top five best-selling products by revenue?
2. How much revenue does each store generate every month?
3. What is the month-over-month revenue growth?
4. Who are the top ten customers based on total spending?
5. Which loyalty customers have not made a purchase since 28 April 2024?
6. What is the average transaction value for each loyalty tier?
7. How many products were sold by category in each store?
8. Which products have stock levels below their reorder threshold?

---

## **Key Findings**

The analysis produced several valuable business insights.

- A small number of products generated most of the company's revenue.
- Gold loyalty customers had the highest average transaction value.
- Sales performance varied across stores.
- Monthly revenue fluctuated throughout the reporting period.
- Several inactive loyalty customers were identified for potential retention campaigns.
- Inventory levels were generally well maintained, with no products falling below their reorder threshold.

---

## **Skills Demonstrated**

This project demonstrates practical experience in:

- ETL pipeline development
- SQL Server database development
- Data warehouse design
- Star schema modelling
- Data cleaning and validation
- Stored procedure development
- SQL joins
- Aggregate functions
- Window functions
- Date standardisation
- Duplicate prevention
- Business intelligence reporting
- Analytical SQL queries
- Git and GitHub version control

---

## **Future Improvements**

Future enhancements for this project include:

- Building the ETL pipeline using SSIS.
- Creating interactive Power BI dashboards.
- Scheduling automated ETL jobs using SQL Server Agent.
- Implementing Slowly Changing Dimensions (SCD).
- Expanding the warehouse with additional dimensions and business metrics.

---

## **Conclusion**

This project demonstrates the complete process of transforming raw transactional data into a structured data warehouse.

By implementing staging, cleaning and data warehouse layers, data quality was improved before analysis. Stored procedures automated the ETL process, while the star schema enabled efficient reporting and business analysis.

The project strengthened my practical understanding of SQL Server, ETL development, data cleaning, stored procedures, dimensional modelling and business analytics. It also demonstrates how data engineering can transform raw business data into meaningful insights that support informed decision making.
