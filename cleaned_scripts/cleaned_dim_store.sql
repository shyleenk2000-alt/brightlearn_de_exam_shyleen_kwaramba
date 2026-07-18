CREATE OR ALTER PROCEDURE sp_create_cleaned_dim_store
AS
BEGIN
    SET NOCOUNT ON;

    -- Create table only if it does not exist
    IF NOT EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE name = 'cleaned_dim_store'
          AND schema_id = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [cleaned_brightlearn_sales].[dbo].[cleaned_dim_store](
    [StoreID] INT IDENTITY (1,1) PRIMARY KEY,
	[store_name] [varchar](50) NOT NULL,
	[store_city] [varchar](50) NOT NULL,
	[store_province] [varchar](50) NOT NULL,
	[store_region] [varchar](50) NOT NULL,
	[store_manager] [varchar](50) NOT NULL,
	[load_date] DATETIME DEFAULT GETDATE()
) 
    END;

    ---Inserting values into table
    INSERT INTO [cleaned_brightlearn_sales].[dbo].[cleaned_dim_store]
       ([store_name] ,
	[store_city] ,
	[store_province] ,
	[store_region] ,
	[store_manager] )

     SELECT DISTINCT
        LOWER(LTRIM(RTRIM(store_name))) AS store_name,
        LOWER(LTRIM(RTRIM(store_city))) AS store_city,
        LOWER(LTRIM(RTRIM(store_province))) AS store_province,
        LOWER(LTRIM(RTRIM(store_region))) AS store_region,
        LOWER(LTRIM(RTRIM(store_manager))) AS store_manager

    FROM[stg_brightlearn_sales].[dbo].[stg_dim_store]


    WHERE
        store_name IS NOT NULL
        AND LTRIM(RTRIM(store_name)) <> ''

        AND store_city IS NOT NULL
        AND LTRIM(RTRIM(store_city)) <> ''

        AND store_province IS NOT NULL
        AND LTRIM(RTRIM(store_province)) <> ''

        AND store_region IS NOT NULL
        AND LTRIM(RTRIM(store_region)) <> ''

        AND store_manager IS NOT NULL
        AND LTRIM(RTRIM(store_manager)) <> ''

       END;

    EXEC[dbo].[sp_create_cleaned_dim_store]
    SELECT * FROM [cleaned_brightlearn_sales].[dbo].[cleaned_dim_store]