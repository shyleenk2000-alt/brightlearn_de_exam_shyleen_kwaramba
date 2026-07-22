CREATE OR ALTER PROCEDURE sp_create_cleaned_dim_payment
AS
BEGIN
    SET NOCOUNT ON;

    -- Create table only if it does not exist
    IF NOT EXISTS (
        SELECT 1
        FROM [cleaned_brightlearn_sales].sys.tables
        WHERE name = 'cleaned_dim_payment'
          AND schema_id = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [cleaned_brightlearn_sales].[dbo].[cleaned_dim_payment](
            [PaymentID] INT IDENTITY (1,1) PRIMARY KEY,
            [payment_method] VARCHAR(50) NOT NULL,
            [load_date] DATETIME DEFAULT GETDATE()
        );
    END;


    -- Insert only new cleaned payment methods
    INSERT INTO [cleaned_brightlearn_sales].[dbo].[cleaned_dim_payment]
    (
        [payment_method]
    )

    SELECT DISTINCT
        LOWER(LTRIM(RTRIM(s.[payment_method]))) AS payment_method

    FROM [stg_brightlearn_sales].[dbo].[stg_dim_payment] s

    WHERE s.[payment_method] IS NOT NULL
      AND LTRIM(RTRIM(s.[payment_method])) <> ''

      -- Prevent duplicate payment methods
      AND NOT EXISTS
      (
          SELECT 1
          FROM [cleaned_brightlearn_sales].[dbo].[cleaned_dim_payment] p
          WHERE p.[payment_method] = LOWER(LTRIM(RTRIM(s.[payment_method])))
      );

END;
GO


EXEC [dbo].[sp_create_cleaned_dim_payment];


SELECT *
FROM [cleaned_brightlearn_sales].[dbo].[cleaned_dim_payment];