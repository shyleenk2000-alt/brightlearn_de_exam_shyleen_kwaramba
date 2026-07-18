---Creating a table with id
DROP TABLE [stg_brightlearn_sales].[dbo].[stg_dim_supplier]
CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_supplier](
    [SupplierID] INT IDENTITY (1,1) PRIMARY KEY,
	[supplier] [varchar](50) NOT NULL,
	[load_date] DATETIME DEFAULT GETDATE()
) 

---Inserting values into table
INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_supplier]
      ([supplier])

SELECT DISTINCT
    [supplier]  
FROM[stg_brightlearn_sales].[dbo].[brightlearn_sales_raw_data]

SELECT *FROM [stg_brightlearn_sales].[dbo].[stg_dim_supplier]