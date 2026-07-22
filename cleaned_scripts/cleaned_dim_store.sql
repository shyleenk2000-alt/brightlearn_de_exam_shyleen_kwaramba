CREATE OR ALTER PROCEDURE sp_create_cleaned_dim_store
AS
BEGIN
    SET NOCOUNT ON;

    -- Create table only if it does not exist
    IF NOT EXISTS (
        SELECT 1
        FROM [cleaned_brightlearn_sales].sys.tables
        WHERE name = 'cleaned_dim_store'
          AND schema_id = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [cleaned_brightlearn_sales].[dbo].[cleaned_dim_store](
            [StoreID] INT IDENTITY (1,1) PRIMARY KEY,
            [store_name] VARCHAR(50) NOT NULL,
            [store_city] VARCHAR(50) NOT NULL,
            [store_province] VARCHAR(50) NOT NULL,
            [store_region] VARCHAR(50) NOT NULL,
            [store_manager] VARCHAR(50) NOT NULL,
            [load_date] DATETIME DEFAULT GETDATE()
        );
    END;


    -- Insert only new cleaned stores
    INSERT INTO [cleaned_brightlearn_sales].[dbo].[cleaned_dim_store]
    (
        [store_name],
        [store_city],
        [store_province],
        [store_region],
        [store_manager]
    )

    SELECT DISTINCT
        LOWER(LTRIM(RTRIM(s.[store_name]))) AS store_name,
        LOWER(LTRIM(RTRIM(s.[store_city]))) AS store_city,
        LOWER(LTRIM(RTRIM(s.[store_province]))) AS store_province,
        LOWER(LTRIM(RTRIM(s.[store_region]))) AS store_region,
        LOWER(LTRIM(RTRIM(s.[store_manager]))) AS store_manager

    FROM [stg_brightlearn_sales].[dbo].[stg_dim_store] s

    WHERE s.[store_name] IS NOT NULL
      AND LTRIM(RTRIM(s.[store_name])) <> ''

      AND s.[store_city] IS NOT NULL
      AND LTRIM(RTRIM(s.[store_city])) <> ''

      AND s.[store_province] IS NOT NULL
      AND LTRIM(RTRIM(s.[store_province])) <> ''

      AND s.[store_region] IS NOT NULL
      AND LTRIM(RTRIM(s.[store_region])) <> ''

      AND s.[store_manager] IS NOT NULL
      AND LTRIM(RTRIM(s.[store_manager])) <> ''

      -- Prevent duplicate stores
      AND NOT EXISTS
      (
          SELECT 1
          FROM [cleaned_brightlearn_sales].[dbo].[cleaned_dim_store] c
          WHERE c.[store_name] = LOWER(LTRIM(RTRIM(s.[store_name])))
            AND c.[store_city] = LOWER(LTRIM(RTRIM(s.[store_city])))
            AND c.[store_province] = LOWER(LTRIM(RTRIM(s.[store_province])))
      );

END;
GO


EXEC [dbo].[sp_create_cleaned_dim_store];


SELECT *
FROM [cleaned_brightlearn_sales].[dbo].[cleaned_dim_store];