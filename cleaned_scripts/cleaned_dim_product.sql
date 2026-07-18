CREATE OR ALTER PROCEDURE sp_create_cleaned_dim_product
AS
BEGIN
    SET NOCOUNT ON;

    -- Create table only if it does not exist
    IF NOT EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE name = 'cleaned_dim_product'
          AND schema_id = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [cleaned_brightlearn_sales].[dbo].[cleaned_dim_product](
    [ProductID] INT IDENTITY (1,1) PRIMARY KEY,
	[product_name] [varchar](50)  NOT NULL,
	[category] [varchar](50) NOT NULL,
	[sub_category] [varchar](50)  NOT NULL,
	[sku] [varchar](50)  NOT NULL,
	[load_date] DATETIME DEFAULT GETDATE()
) 

    END;

    ---Inserting values into table
    INSERT INTO [cleaned_brightlearn_sales].[dbo].[cleaned_dim_product]
        ([product_name] ,
	   [category] ,
	   [sub_category] ,
	   [sku] )
SELECT DISTINCT
        LOWER(LTRIM(RTRIM(product_name))) AS product_name,
        LOWER(LTRIM(RTRIM(category))) AS category,
        LOWER(LTRIM(RTRIM(sub_category))) AS sub_category,
        LOWER(LTRIM(RTRIM(sku))) AS sku

    FROM [stg_brightlearn_sales].[dbo].[stg_dim_product]


WHERE
        product_name IS NOT NULL
        AND LTRIM(RTRIM(product_name)) <> ''

        AND category IS NOT NULL
        AND LTRIM(RTRIM(category)) <> ''

        AND sub_category IS NOT NULL
        AND LTRIM(RTRIM(sub_category)) <> ''

        AND sku IS NOT NULL
        AND LTRIM(RTRIM(sku)) <> ''

        
END;

EXEC[dbo].[sp_create_cleaned_dim_product]

SELECT * FROM [cleaned_brightlearn_sales].[dbo].[cleaned_dim_product]