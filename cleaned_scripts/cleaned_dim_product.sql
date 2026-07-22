CREATE OR ALTER PROCEDURE sp_create_cleaned_dim_product
AS
BEGIN
    SET NOCOUNT ON;

    -- Create table only if it does not exist
    IF NOT EXISTS (
        SELECT 1
        FROM [cleaned_brightlearn_sales].sys.tables
        WHERE name = 'cleaned_dim_product'
          AND schema_id = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [cleaned_brightlearn_sales].[dbo].[cleaned_dim_product](
            [ProductID] INT IDENTITY (1,1) PRIMARY KEY,
            [product_name] VARCHAR(50) NOT NULL,
            [category] VARCHAR(50) NOT NULL,
            [sub_category] VARCHAR(50) NOT NULL,
            [sku] VARCHAR(50) NOT NULL,
            [load_date] DATETIME DEFAULT GETDATE()
        );
    END;


    -- Insert only new cleaned products
    INSERT INTO [cleaned_brightlearn_sales].[dbo].[cleaned_dim_product]
    (
        [product_name],
        [category],
        [sub_category],
        [sku]
    )

    SELECT DISTINCT
        LOWER(LTRIM(RTRIM(s.[product_name]))) AS product_name,
        LOWER(LTRIM(RTRIM(s.[category]))) AS category,
        LOWER(LTRIM(RTRIM(s.[sub_category]))) AS sub_category,
        LOWER(LTRIM(RTRIM(s.[sku]))) AS sku

    FROM [stg_brightlearn_sales].[dbo].[stg_dim_product] s

    WHERE s.[product_name] IS NOT NULL
      AND LTRIM(RTRIM(s.[product_name])) <> ''

      AND s.[category] IS NOT NULL
      AND LTRIM(RTRIM(s.[category])) <> ''

      AND s.[sub_category] IS NOT NULL
      AND LTRIM(RTRIM(s.[sub_category])) <> ''

      AND s.[sku] IS NOT NULL
      AND LTRIM(RTRIM(s.[sku])) <> ''

      -- Prevent duplicate products
      AND NOT EXISTS
      (
          SELECT 1
          FROM [cleaned_brightlearn_sales].[dbo].[cleaned_dim_product] p
          WHERE p.[sku] = LOWER(LTRIM(RTRIM(s.[sku])))
      );

END;
GO


EXEC [dbo].[sp_create_cleaned_dim_product];


SELECT *
FROM [cleaned_brightlearn_sales].[dbo].[cleaned_dim_product];