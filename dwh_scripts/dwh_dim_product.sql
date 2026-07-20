CREATE OR ALTER PROCEDURE sp_create_dwh_dim_product
AS
BEGIN
    SET NOCOUNT ON;

    -- Create table only if it does not exist
    IF NOT EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE name = 'dwh_dim_product'
          AND schema_id = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [dwh_brightlearn_sales].[dbo].[dwh_dim_product](
    [ProductID] INT IDENTITY (1,1) PRIMARY KEY,
	[product_name] [varchar](50)  NOT NULL,
	[category] [varchar](50) NOT NULL,
	[sub_category] [varchar](50)  NOT NULL,
	[sku] [varchar](50)  NOT NULL,
	[load_date] DATETIME DEFAULT GETDATE()
) 

    END;

    ---Inserting values into table
    INSERT INTO [dwh_brightlearn_sales].[dbo].[dwh_dim_product]
        ([product_name] ,
	   [category] ,
	   [sub_category] ,
	   [sku] )

       SELECT
       [product_name] ,
	   [category] ,
	   [sub_category] ,
	   [sku] 


FROM [cleaned_brightlearn_sales].[dbo].[cleaned_dim_product]
END;

EXEC [dbo].[sp_create_dwh_dim_product]

SELECT * FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_product]