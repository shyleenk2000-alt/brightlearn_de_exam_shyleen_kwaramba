CREATE OR ALTER PROCEDURE sp_create_dwh_dim_payment
AS
BEGIN
    SET NOCOUNT ON;

    -- Create table only if it does not exist
    IF NOT EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE name = 'dwh_dim_payment'
          AND schema_id = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [dwh_brightlearn_sales].[dbo].[dwh_dim_payment](
    [PaymentID] INT IDENTITY (1,1) PRIMARY KEY,
	[payment_method] [varchar](50)  NOT NULL,
	[load_date] DATETIME DEFAULT GETDATE()
) 

    END;

    ---Inserting values into table
    INSERT INTO [dwh_brightlearn_sales].[dbo].[dwh_dim_payment]
        ([payment_method])

        SELECT 
        ([payment_method])

FROM [cleaned_brightlearn_sales].[dbo].[cleaned_dim_payment]
END;

EXEC [dbo].[sp_create_dwh_dim_payment]

SELECT * FROM  [dwh_brightlearn_sales].[dbo].[dwh_dim_payment]