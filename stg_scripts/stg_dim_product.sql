---Creating a table with id
DROP TABLE [stg_brightlearn_sales].[dbo].[stg_dim_product]
CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_product](
    [ProductID] INT IDENTITY (1,1) PRIMARY KEY,
	[product_name] [varchar](50)  NOT NULL,
	[category] [varchar](50) NOT NULL,
	[sub_category] [varchar](50)  NOT NULL,
	[sku] [varchar](50)  NOT NULL,
	[load_date] DATETIME DEFAULT GETDATE()
) 

---Inserting values into table
INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_product]
      ([product_name] ,
	   [category] ,
	   [sub_category] ,
	   [sku] )

SELECT DISTINCT
    [product_name],
	[category] ,
	[sub_category] ,
	[sku] 
FROM[stg_brightlearn_sales].[dbo].[brightlearn_sales_raw_data]

SELECT *FROM [stg_brightlearn_sales].[dbo].[stg_dim_product]