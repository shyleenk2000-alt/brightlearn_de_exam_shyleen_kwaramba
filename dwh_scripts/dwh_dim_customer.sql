CREATE OR ALTER PROCEDURE sp_create_dwh_dim_customer
AS
BEGIN
    SET NOCOUNT ON;

    -- Create table only if it does not exist
    IF NOT EXISTS (
        SELECT 1
        FROM [dwh_brightlearn_sales].sys.tables
        WHERE name = 'dwh_dim_customer'
          AND schema_id = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [dwh_brightlearn_sales].[dbo].[dwh_dim_customer](
            [CustomerID] INT IDENTITY (1,1) PRIMARY KEY,
            [customer_first_name] NVARCHAR(50) NOT NULL,
            [customer_last_name] NVARCHAR(50) NOT NULL,
            [customer_email] NVARCHAR(50) NOT NULL,
            [customer_phone] NVARCHAR(50) NOT NULL,
            [customer_city] NVARCHAR(50) NOT NULL,
            [customer_province] NVARCHAR(50) NOT NULL,
            [customer_loyalty_tier] NVARCHAR(50) NOT NULL,
            [customer_since] DATETIME2(7) NOT NULL,
            [load_date] DATETIME DEFAULT GETDATE()
        );
    END;


    -- Insert only new customers into DWH
    INSERT INTO [dwh_brightlearn_sales].[dbo].[dwh_dim_customer]
    (
        [customer_first_name],
        [customer_last_name],
        [customer_email],
        [customer_phone],
        [customer_city],
        [customer_province],
        [customer_loyalty_tier],
        [customer_since]
    )

    SELECT 
        c.[customer_first_name],
        c.[customer_last_name],
        c.[customer_email],
        c.[customer_phone],
        c.[customer_city],
        c.[customer_province],
        c.[customer_loyalty_tier],
        c.[customer_since]

    FROM [cleaned_brightlearn_sales].[dbo].[cleaned_dim_customer] c

    WHERE NOT EXISTS
    (
        SELECT 1
        FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_customer] d
        WHERE d.[customer_email] = c.[customer_email]
    );

END;
GO


EXEC [dbo].[sp_create_dwh_dim_customer];


SELECT *
FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_customer];

