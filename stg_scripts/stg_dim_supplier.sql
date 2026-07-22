CREATE OR ALTER PROCEDURE dbo.sp_load_stg_dim_supplier
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('dbo.stg_dim_supplier', 'U') IS NULL
    BEGIN
        CREATE TABLE dbo.stg_dim_supplier(
            [SupplierID] INT IDENTITY (1,1) PRIMARY KEY,
            [supplier] VARCHAR(50) NOT NULL,
            [load_date] DATETIME DEFAULT GETDATE()
        );
    END;


    INSERT INTO dbo.stg_dim_supplier
    (
        [supplier]
    )

    SELECT DISTINCT
        r.[supplier]

    FROM dbo.brightlearn_sales_raw_data r

    WHERE r.[supplier] IS NOT NULL
      AND LTRIM(RTRIM(r.[supplier])) <> ''

      AND NOT EXISTS
    (
        SELECT 1
        FROM dbo.stg_dim_supplier s
        WHERE s.[supplier] = r.[supplier]
    );

END;
GO


EXEC dbo.sp_load_stg_dim_supplier;


SELECT *
FROM dbo.stg_dim_supplier;