CREATE OR ALTER PROCEDURE sp_create_cleaned_dim_customer
AS
BEGIN
    SET NOCOUNT ON;

    -- Create table only if it does not exist
    IF NOT EXISTS (
        SELECT 1
        FROM [cleaned_brightlearn_sales].sys.tables
        WHERE name = 'cleaned_dim_customer'
          AND schema_id = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [cleaned_brightlearn_sales].[dbo].[cleaned_dim_customer](
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


    -- Insert only new cleaned customers
    INSERT INTO [cleaned_brightlearn_sales].[dbo].[cleaned_dim_customer]
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
        LOWER(LTRIM(RTRIM(s.[customer_first_name]))),
        LOWER(LTRIM(RTRIM(s.[customer_last_name]))),
        LOWER(LTRIM(RTRIM(s.[customer_email]))),
        LTRIM(RTRIM(s.[customer_phone])),
        LOWER(LTRIM(RTRIM(s.[customer_city]))),
        LOWER(LTRIM(RTRIM(s.[customer_province]))),
        LOWER(LTRIM(RTRIM(s.[customer_loyalty_tier]))),

        TRY_CONVERT(DATETIME2(7), s.[customer_since])

    FROM [stg_brightlearn_sales].[dbo].[stg_dim_customer] s

    WHERE s.[customer_first_name] IS NOT NULL
      AND LTRIM(RTRIM(s.[customer_first_name])) <> ''

      AND s.[customer_last_name] IS NOT NULL
      AND LTRIM(RTRIM(s.[customer_last_name])) <> ''

      AND s.[customer_email] IS NOT NULL
      AND LTRIM(RTRIM(s.[customer_email])) <> ''

      AND s.[customer_phone] IS NOT NULL
      AND LTRIM(RTRIM(s.[customer_phone])) <> ''

      AND s.[customer_city] IS NOT NULL
      AND LTRIM(RTRIM(s.[customer_city])) <> ''

      AND s.[customer_province] IS NOT NULL
      AND LTRIM(RTRIM(s.[customer_province])) <> ''

      AND s.[customer_loyalty_tier] IS NOT NULL
      AND LTRIM(RTRIM(s.[customer_loyalty_tier])) <> ''

      AND TRY_CONVERT(DATETIME2(7), s.[customer_since]) IS NOT NULL

      -- Prevent duplicate customers
      AND NOT EXISTS
      (
          SELECT 1
          FROM [cleaned_brightlearn_sales].[dbo].[cleaned_dim_customer] c
          WHERE LOWER(LTRIM(RTRIM(c.[customer_email])))
              = LOWER(LTRIM(RTRIM(s.[customer_email])))
      );

END;
GO


EXEC [dbo].[sp_create_cleaned_dim_customer];


SELECT *
FROM [cleaned_brightlearn_sales].[dbo].[cleaned_dim_customer];