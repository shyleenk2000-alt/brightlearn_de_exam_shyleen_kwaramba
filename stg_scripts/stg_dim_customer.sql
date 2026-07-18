---Creating a table with id
DROP TABLE [stg_brightlearn_sales].[dbo].[stg_dim_customer]
CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_customer](
    [CustomerID] INT IDENTITY (1,1) PRIMARY KEY,
	[customer_first_name][nvarchar](50) NOT NULL
      ,[customer_last_name][nvarchar](50) NOT NULL
      ,[customer_email][nvarchar](50) NOT NULL
      ,[customer_phone][nvarchar](50) NOT NULL
      ,[customer_city][nvarchar](50) NOT NULL
      ,[customer_province][nvarchar](50) NOT NULL
      ,[customer_loyalty_tier][nvarchar](50) NOT NULL
      ,[customer_since][datetime2](7) NOT NULL,
	[load_date] DATETIME DEFAULT GETDATE()
) 

---Inserting values into table
INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_customer]
      ( [customer_first_name]
      ,[customer_last_name]
      ,[customer_email]
      ,[customer_phone]
      ,[customer_city]
      ,[customer_province]
      ,[customer_loyalty_tier]
      ,[customer_since])
SELECT DISTINCT[customer_first_name]
      ,[customer_last_name]
      ,[customer_email]
      ,[customer_phone]
      ,[customer_city]
      ,[customer_province]
      ,[customer_loyalty_tier]
      ,[customer_since]
FROM[stg_brightlearn_sales].[dbo].[brightlearn_sales_raw_data]

SELECT *FROM [stg_brightlearn_sales].[dbo].[stg_dim_customer]