---Creating a table with id
DROP TABLE [stg_brightlearn_sales].[dbo].[stg_dim_date]
CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_date](
    [DateID] INT IDENTITY (1,1) PRIMARY KEY,
    [transaction_date] DATETIME2 (7) NOT NULL ,
    [load_date] DATETIME DEFAULT GETDATE()
) 

---Inserting values into table
INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_date]
      ([transaction_date] )

SELECT DISTINCT
    [transaction_date]
FROM[stg_brightlearn_sales].[dbo].[brightlearn_sales_raw_data]

SELECT *FROM [stg_brightlearn_sales].[dbo].[stg_dim_date]