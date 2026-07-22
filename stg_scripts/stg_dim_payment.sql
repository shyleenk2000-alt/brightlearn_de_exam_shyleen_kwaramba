CREATE OR ALTER PROCEDURE dbo.sp_load_stg_dim_payment
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('dbo.stg_dim_payment', 'U') IS NULL
    BEGIN
        CREATE TABLE dbo.stg_dim_payment(
            [PaymentID] INT IDENTITY (1,1) PRIMARY KEY,
            [payment_method] VARCHAR(50) NULL,
            [load_date] DATETIME DEFAULT GETDATE()
        );
    END;


    INSERT INTO dbo.stg_dim_payment
    (
        [payment_method]
    )

    SELECT DISTINCT
        r.[payment_method]

    FROM dbo.brightlearn_sales_raw_data r

    WHERE r.[payment_method] IS NOT NULL
      AND LTRIM(RTRIM(r.[payment_method])) <> ''

      AND NOT EXISTS
    (
        SELECT 1
        FROM dbo.stg_dim_payment p
        WHERE p.[payment_method] = r.[payment_method]
    );

END;
GO


EXEC dbo.sp_load_stg_dim_payment;


SELECT *
FROM dbo.stg_dim_payment;