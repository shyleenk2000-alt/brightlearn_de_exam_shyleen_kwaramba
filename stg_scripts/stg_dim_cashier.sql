CREATE OR ALTER PROCEDURE sp_load_stg_dim_cashier
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('stg_brightlearn_sales.dbo.stg_dim_cashier', 'U') IS NULL
    BEGIN
        CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_cashier](
            [CashierID] INT IDENTITY (1,1) PRIMARY KEY,
            [cashier_name] VARCHAR(50) NOT NULL,
            [load_date] DATETIME DEFAULT GETDATE()
        );
    END;


    INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_cashier]
    (
        [cashier_name]
    )

    SELECT DISTINCT
        r.[cashier_name]

    FROM [stg_brightlearn_sales].[dbo].[brightlearn_sales_raw_data] r

    WHERE r.[cashier_name] IS NOT NULL
      AND LTRIM(RTRIM(r.[cashier_name])) <> ''

      AND NOT EXISTS
      (
          SELECT 1
          FROM [stg_brightlearn_sales].[dbo].[stg_dim_cashier] c
          WHERE c.[cashier_name] = r.[cashier_name]
      );

END;
GO


EXEC dbo.sp_load_stg_dim_cashier;


SELECT *
FROM [stg_brightlearn_sales].[dbo].[stg_dim_cashier];


