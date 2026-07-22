CREATE OR ALTER PROCEDURE dbo.sp_load_stg_dim_product
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('dbo.stg_dim_product', 'U') IS NULL
    BEGIN
        CREATE TABLE dbo.stg_dim_product(
            [ProductID] INT IDENTITY (1,1) PRIMARY KEY,
            [product_name] VARCHAR(50) NOT NULL,
            [category] VARCHAR(50) NOT NULL,
            [sub_category] VARCHAR(50) NOT NULL,
            [sku] VARCHAR(50) NOT NULL,
            [load_date] DATETIME DEFAULT GETDATE()
        );
    END;


    INSERT INTO dbo.stg_dim_product
    (
        [product_name],
        [category],
        [sub_category],
        [sku]
    )

    SELECT DISTINCT
        r.[product_name],
        r.[category],
        r.[sub_category],
        r.[sku]

    FROM dbo.brightlearn_sales_raw_data r

    WHERE r.[sku] IS NOT NULL
      AND LTRIM(RTRIM(r.[sku])) <> ''

      AND NOT EXISTS
    (
        SELECT 1
        FROM dbo.stg_dim_product p
        WHERE p.[sku] = r.[sku]
    );

END;
GO


EXEC dbo.sp_load_stg_dim_product;


SELECT *
FROM dbo.stg_dim_product;