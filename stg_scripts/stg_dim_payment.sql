---Creating a table with id
DROP TABLE [stg_brightlearn_sales].[dbo].[stg_dim_payment]
CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_payment](
    [PaymentID] INT IDENTITY (1,1) PRIMARY KEY,
	[payment_method] [varchar](50) NULL,
	[load_date] DATETIME DEFAULT GETDATE()
) 

---Inserting values into table
INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_payment]
      ([payment_method] )

SELECT DISTINCT
    [payment_method] 
FROM[stg_brightlearn_sales].[dbo].[brightlearn_sales_raw_data]

SELECT *FROM [stg_brightlearn_sales].[dbo].[stg_dim_payment]