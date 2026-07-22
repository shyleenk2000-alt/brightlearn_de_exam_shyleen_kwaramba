CREATE OR ALTER PROCEDURE sp_load_stg_dim_customer
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('stg_brightlearn_sales.dbo.stg_dim_customer', 'U') IS NULL
    BEGIN
        CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_customer](
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


    INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_customer]
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

    SELECT DISTINCT
        r.[customer_first_name],
        r.[customer_last_name],
        r.[customer_email],
        r.[customer_phone],
        r.[customer_city],
        r.[customer_province],
        r.[customer_loyalty_tier],
        r.[customer_since]

    FROM [stg_brightlearn_sales].[dbo].[brightlearn_sales_raw_data] r

    WHERE r.[customer_email] IS NOT NULL
      AND LTRIM(RTRIM(r.[customer_email])) <> ''

      AND NOT EXISTS
    (
        SELECT 1
        FROM [stg_brightlearn_sales].[dbo].[stg_dim_customer] c
        WHERE c.[customer_email] = r.[customer_email]
    );

END;
GO


EXEC dbo.sp_load_stg_dim_customer;


SELECT *
FROM [stg_brightlearn_sales].[dbo].[stg_dim_customer];