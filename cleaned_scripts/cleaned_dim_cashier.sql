CREATE OR ALTER PROCEDURE sp_create_cleaned_dim_cashier
AS
BEGIN
    SET NOCOUNT ON;

    -- Create table only if it does not exist
    IF NOT EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE name = 'cleaned_dim_cashier'
          AND schema_id = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [cleaned_brightlearn_sales].[dbo].[cleaned_dim_cashier](
    [CashierID] INT IDENTITY (1,1) PRIMARY KEY,
	[cashier_name] [varchar](50)  NOT NULL,
	[load_date] DATETIME DEFAULT GETDATE()
) 

    END;

    ---Inserting values into table
    INSERT INTO [cleaned_brightlearn_sales].[dbo].[cleaned_dim_cashier]
        ([cashier_name])

    SELECT DISTINCT
    LOWER(LTRIM(RTRIM(cashier_name))) AS cashier_name

    FROM  [stg_brightlearn_sales].[dbo].[stg_dim_cashier]

 
 WHERE 
  cashier_name IS NOT NULL
  AND
  LTRIM(RTRIM(cashier_name)) <> ''
  END;

  EXEC [dbo].[sp_create_cleaned_dim_cashier]

  SELECT *FROM [dbo].[cleaned_dim_cashier]