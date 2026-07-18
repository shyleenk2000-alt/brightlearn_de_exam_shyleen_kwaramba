CREATE OR ALTER PROCEDURE sp_create_cleaned_dim_customer
AS
BEGIN
    SET NOCOUNT ON;

    -- Create table only if it does not exist
    IF NOT EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE name = 'cleaned_dim_customer'
          AND schema_id = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [cleaned_brightlearn_sales].[dbo].[cleaned_dim_customer](
    [CustomerID] INT IDENTITY (1,1) PRIMARY KEY,
	[customer_first_name][nvarchar](50) NOT NULL
      ,[customer_last_name][nvarchar](50) NOT NULL
      ,[customer_email][nvarchar](50) NOT NULL
      ,[customer_phone][nvarchar](50) NOT NULL
      ,[customer_city][nvarchar](50) NOT NULL
      ,[customer_province][nvarchar](50) NOT NULL
      ,[customer_loyalty_tier][nvarchar](50) NOT NULL
      ,[customer_since][datetime2](7) NOT NULL,
	[load_date] DATETIME DEFAULT GETDATE()
) 
    END;

---Inserting values into table
INSERT INTO [cleaned_brightlearn_sales].[dbo].[cleaned_dim_customer]
      ( [customer_first_name]
      ,[customer_last_name]
      ,[customer_email]
      ,[customer_phone]
      ,[customer_city]
      ,[customer_province]
      ,[customer_loyalty_tier]
      ,[customer_since])

SELECT DISTINCT
    LOWER(LTRIM(RTRIM(customer_first_name))) AS customer_first_name,
    LOWER(LTRIM(RTRIM(customer_last_name))) AS customer_last_name,
    LOWER(LTRIM(RTRIM(customer_email))) AS customer_email,
    LTRIM(RTRIM(customer_phone)) AS customer_phone,
    LOWER(LTRIM(RTRIM(customer_city))) AS customer_city,
    LOWER(LTRIM(RTRIM(customer_province))) AS customer_province,
    LOWER(LTRIM(RTRIM(customer_loyalty_tier))) AS customer_loyalty_tier,

    CASE
        WHEN TRY_CONVERT(DATE, customer_since, 23) IS NOT NULL THEN TRY_CONVERT(DATE, customer_since, 23)
        WHEN TRY_CONVERT(DATE, customer_since, 111) IS NOT NULL THEN TRY_CONVERT(DATE, customer_since, 111)
        WHEN TRY_CONVERT(DATE, customer_since, 105) IS NOT NULL THEN TRY_CONVERT(DATE, customer_since, 105)
        WHEN TRY_CONVERT(DATE, customer_since, 106) IS NOT NULL THEN TRY_CONVERT(DATE, customer_since, 106)
        WHEN TRY_CONVERT(DATE, customer_since, 103) IS NOT NULL THEN TRY_CONVERT(DATE, customer_since, 103)
    END AS customer_since

FROM  [stg_brightlearn_sales].[dbo].[stg_dim_customer]s

WHERE
    customer_first_name IS NOT NULL
    AND LTRIM(RTRIM(customer_first_name)) <> ''

    AND customer_last_name IS NOT NULL
    AND LTRIM(RTRIM(customer_last_name)) <> ''

    AND customer_email IS NOT NULL
    AND LTRIM(RTRIM(customer_email)) <> ''

    AND customer_phone IS NOT NULL
    AND LTRIM(RTRIM(customer_phone)) <> ''

    AND customer_city IS NOT NULL
    AND LTRIM(RTRIM(customer_city)) <> ''

    AND customer_province IS NOT NULL
    AND LTRIM(RTRIM(customer_province)) <> ''

    AND customer_loyalty_tier IS NOT NULL
    AND LTRIM(RTRIM(customer_loyalty_tier)) <> ''

    AND customer_since IS NOT NULL
    AND (
        TRY_CONVERT(DATE, customer_since, 23) IS NOT NULL
        OR TRY_CONVERT(DATE, customer_since, 111) IS NOT NULL
        OR TRY_CONVERT(DATE, customer_since, 105) IS NOT NULL
        OR TRY_CONVERT(DATE, customer_since, 106) IS NOT NULL
        OR TRY_CONVERT(DATE, customer_since, 103) IS NOT NULL
    )

    AND NOT EXISTS
    (
        SELECT 1
        FROM cleaned_brightlearn_sales.dbo.cleaned_dim_customer c
        WHERE LOWER(LTRIM(RTRIM(c.customer_email)))
              = LOWER(LTRIM(RTRIM(s.customer_email)))
    )

    END;

   EXEC [dbo].[sp_create_cleaned_dim_customer]
    
    SELECT * FROM [cleaned_brightlearn_sales].[dbo].[cleaned_dim_customer]