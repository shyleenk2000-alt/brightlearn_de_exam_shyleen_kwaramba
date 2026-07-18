---Creating a table with id
DROP TABLE [stg_brightlearn_sales].[dbo].[stg_dim_cashier]
CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_cashier](
    [CashierID] INT IDENTITY (1,1) PRIMARY KEY,
	[cashier_name] [varchar](50) NOT NULL,
	[load_date] DATETIME DEFAULT GETDATE()
) 

---Inserting values into table
INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_cashier]
      ([cashier_name])

SELECT DISTINCT
    [cashier_name] 
FROM[stg_brightlearn_sales].[dbo].[brightlearn_sales_raw_data]

SELECT *FROM [stg_brightlearn_sales].[dbo].[stg_dim_cashier]