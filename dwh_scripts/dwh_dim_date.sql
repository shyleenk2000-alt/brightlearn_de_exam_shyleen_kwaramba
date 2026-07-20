CREATE OR ALTER PROCEDURE sp_create_dwh_dim_date
AS
BEGIN
    SET NOCOUNT ON;

    -- Create table only if it does not exist
    IF NOT EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE name = 'dwh_dim_date'
          AND schema_id = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [dwh_brightlearn_sales].[dbo].[dwh_dim_date](
    [DateID] INT IDENTITY (1,1) PRIMARY KEY,
	[transaction_date] DATE  NOT NULL,
	[load_date] DATETIME DEFAULT GETDATE()
) 

    END;

    ---Inserting values into table
    INSERT INTO [dwh_brightlearn_sales].[dbo].[dwh_dim_date]
        ([transaction_date])

        SELECT
        [transaction_date]

        FROM[cleaned_brightlearn_sales].[dbo].[cleaned_dim_date]
        END;

        EXEC[dbo].[sp_create_dwh_dim_date]

        SELECT * FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_date]