CREATE OR ALTER PROCEDURE sp_create_dwh_dim_store
AS
BEGIN
    SET NOCOUNT ON;

    -- Create table only if it does not exist
    IF NOT EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE name = 'dwh_dim_store'
          AND schema_id = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [dwh_brightlearn_sales].[dbo].[dwh_dim_store](
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
    INSERT INTO [dwh_brightlearn_sales].[dbo].[dwh_dim_store]
       ([store_name] ,
	[store_city] ,
	[store_province] ,
	[store_region] ,
	[store_manager] )

    SELECT
    [store_name] ,
	[store_city] ,
	[store_province] ,
	[store_region] ,
	[store_manager] 

    FROM [cleaned_brightlearn_sales].[dbo].[cleaned_dim_store]
    END;

    EXEC [dbo].[sp_create_dwh_dim_store]

    SELECT * FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_store]
