CREATE OR ALTER PROCEDURE sp_load_stg_dim_date
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('stg_brightlearn_sales.dbo.stg_dim_date', 'U') IS NULL
    BEGIN
        CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_date](
            [DateID] INT IDENTITY (1,1) PRIMARY KEY,
            [transaction_date] DATETIME2(7) NOT NULL,
            [load_date] DATETIME DEFAULT GETDATE()
        );
    END;


    INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_date]
    (
        [transaction_date]
    )

    SELECT DISTINCT
        TRY_CONVERT(DATETIME2(7), r.[transaction_date])

    FROM [stg_brightlearn_sales].[dbo].[brightlearn_sales_raw_data] r

    WHERE TRY_CONVERT(DATETIME2(7), r.[transaction_date]) IS NOT NULL

    AND NOT EXISTS
    (
        SELECT 1
        FROM [stg_brightlearn_sales].[dbo].[stg_dim_date] d
        WHERE d.[transaction_date] = TRY_CONVERT(DATETIME2(7), r.[transaction_date])
    );

END;
GO


EXEC dbo.sp_load_stg_dim_date;


SELECT *
FROM [stg_brightlearn_sales].[dbo].[stg_dim_date];