CREATE OR ALTER PROCEDURE sp_create_cleaned_dim_cashier
AS
BEGIN
    SET NOCOUNT ON;

    -- Create table only if it does not exist
    IF NOT EXISTS (
        SELECT 1
        FROM [cleaned_brightlearn_sales].sys.tables
        WHERE name = 'cleaned_dim_cashier'
          AND schema_id = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [cleaned_brightlearn_sales].[dbo].[cleaned_dim_cashier](
            [CashierID] INT IDENTITY (1,1) PRIMARY KEY,
            [cashier_name] VARCHAR(50) NOT NULL,
            [load_date] DATETIME DEFAULT GETDATE()
        );
    END;


    -- Insert only new cleaned cashier names
    INSERT INTO [cleaned_brightlearn_sales].[dbo].[cleaned_dim_cashier]
    (
        [cashier_name]
    )
    SELECT DISTINCT
        LOWER(LTRIM(RTRIM(s.[cashier_name]))) AS cashier_name
    FROM [stg_brightlearn_sales].[dbo].[stg_dim_cashier] s
    WHERE s.[cashier_name] IS NOT NULL
      AND LTRIM(RTRIM(s.[cashier_name])) <> ''
      AND NOT EXISTS
      (
          SELECT 1
          FROM [cleaned_brightlearn_sales].[dbo].[cleaned_dim_cashier] c
          WHERE c.[cashier_name] = LOWER(LTRIM(RTRIM(s.[cashier_name])))
      );

END;
GO


EXEC [dbo].[sp_create_cleaned_dim_cashier];
  SELECT *FROM[cleaned_brightlearn_sales].[dbo].[cleaned_dim_cashier]