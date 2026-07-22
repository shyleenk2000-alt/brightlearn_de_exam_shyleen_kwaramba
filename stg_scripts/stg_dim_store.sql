CREATE OR ALTER PROCEDURE dbo.sp_load_stg_dim_store
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('dbo.stg_dim_store', 'U') IS NULL
    BEGIN
        CREATE TABLE dbo.stg_dim_store(
            [StoreID] INT IDENTITY (1,1) PRIMARY KEY,
            [store_name] VARCHAR(50) NOT NULL,
            [store_city] VARCHAR(50) NOT NULL,
            [store_province] VARCHAR(50) NOT NULL,
            [store_region] VARCHAR(50) NOT NULL,
            [store_manager] VARCHAR(50) NOT NULL,
            [load_date] DATETIME DEFAULT GETDATE()
        );
    END;


    INSERT INTO dbo.stg_dim_store
    (
        [store_name],
        [store_city],
        [store_province],
        [store_region],
        [store_manager]
    )

    SELECT DISTINCT
        r.[store_name],
        r.[store_city],
        r.[store_province],
        r.[store_region],
        r.[store_manager]

    FROM dbo.brightlearn_sales_raw_data r

    WHERE r.[store_name] IS NOT NULL
      AND LTRIM(RTRIM(r.[store_name])) <> ''

      AND NOT EXISTS
    (
        SELECT 1
        FROM dbo.stg_dim_store s
        WHERE s.[store_name] = r.[store_name]
          AND s.[store_city] = r.[store_city]
          AND s.[store_province] = r.[store_province]
    );

END;
GO


EXEC dbo.sp_load_stg_dim_store;


SELECT *
FROM dbo.stg_dim_store;