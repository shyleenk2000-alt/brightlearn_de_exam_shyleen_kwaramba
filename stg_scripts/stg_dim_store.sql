---Creating a table with id
DROP TABLE [stg_brightlearn_sales].[dbo].[stg_dim_store]
CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_store](
    [StoreID] INT IDENTITY (1,1) PRIMARY KEY,
	[store_name] [varchar](50) NOT NULL,
	[store_city] [varchar](50) NOT NULL,
	[store_province] [varchar](50) NOT NULL,
	[store_region] [varchar](50) NOT NULL,
	[store_manager] [varchar](50) NOT NULL,
	[load_date] DATETIME DEFAULT GETDATE()
) 

---Inserting values into table
INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_store]
      ([store_name] ,
	[store_city] ,
	[store_province] ,
	[store_region] ,
	[store_manager] )

SELECT DISTINCT
    [store_name] ,
	[store_city] ,
	[store_province],
	[store_region] ,
	[store_manager] 
FROM[stg_brightlearn_sales].[dbo].[brightlearn_sales_raw_data]

SELECT *FROM [stg_brightlearn_sales].[dbo].[stg_dim_store]