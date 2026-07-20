CREATE OR ALTER PROCEDURE sp_create_dwh_dim_cashier
AS
BEGIN
    SET NOCOUNT ON;

    -- Create table only if it does not exist
    IF NOT EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE name = 'dwh_dim_cashier'
          AND schema_id = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [dwh_brightlearn_sales].[dbo].[dwh_dim_cashier](
    [CashierID] INT IDENTITY (1,1) PRIMARY KEY,
	[cashier_name] [varchar](50)  NOT NULL,
	[load_date] DATETIME DEFAULT GETDATE()
) 

    END;

    ---Inserting values into table
    INSERT INTO [dwh_brightlearn_sales].[dbo].[dwh_dim_cashier]
        ([cashier_name])

        SELECT
        [cashier_name]

        FROM [cleaned_brightlearn_sales].[dbo].[cleaned_dim_cashier]
        END;

        EXEC [dbo].[sp_create_dwh_dim_cashier]

        SELECT * FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_cashier]
