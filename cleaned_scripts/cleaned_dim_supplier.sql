CREATE OR ALTER PROCEDURE sp_create_cleaned_dim_supplier
AS
BEGIN
    SET NOCOUNT ON;

    -- Create table only if it does not exist
    IF NOT EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE name = 'cleaned_dim_supplier'
          AND schema_id = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [cleaned_brightlearn_sales].[dbo].[cleaned_dim_supplier](
    [SupplierID] INT IDENTITY (1,1) PRIMARY KEY,
	[supplier] [varchar](50)  NOT NULL,
	[load_date] DATETIME DEFAULT GETDATE()
) 

    END;

    ---Inserting values into table
    INSERT INTO [cleaned_brightlearn_sales].[dbo].[cleaned_dim_supplier]
        ([supplier])

    SELECT DISTINCT
     LOWER(LTRIM(RTRIM(supplier)))  AS supplier

    FROM  [stg_brightlearn_sales].[dbo].[stg_dim_supplier]

    WHERE
    supplier IS NOT NULL
    AND
    LTRIM(RTRIM(supplier)) <> ''
    END;

    EXEC[dbo].[sp_create_cleaned_dim_supplier]

    SELECT * FROM [cleaned_brightlearn_sales].[dbo].[cleaned_dim_supplier]