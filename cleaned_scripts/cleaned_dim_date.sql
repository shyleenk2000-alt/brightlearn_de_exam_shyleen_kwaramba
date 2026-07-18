CREATE OR ALTER PROCEDURE sp_create_cleaned_dim_date
AS
BEGIN
    SET NOCOUNT ON;

    -- Create table only if it does not exist
    IF NOT EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE name = 'cleaned_dim_date'
          AND schema_id = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [cleaned_brightlearn_sales].[dbo].[cleaned_dim_date](
    [DateID] INT IDENTITY (1,1) PRIMARY KEY,
	[transaction_date] DATE  NOT NULL,
	[load_date] DATETIME DEFAULT GETDATE()
) 

    END;

    ---Inserting values into table
    INSERT INTO [cleaned_brightlearn_sales].[dbo].[cleaned_dim_date]
        ([transaction_date])

    SELECT DISTINCT
    TRY_CONVERT(DATE, transaction_date, 23)

FROM stg_brightlearn_sales.dbo.brightlearn_sales_raw_data s


WHERE TRY_CONVERT(DATE, transaction_date, 23) IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM [cleaned_brightlearn_sales].[dbo].[cleaned_dim_date]c
    WHERE c.transaction_date = TRY_CONVERT(DATE, s.transaction_date, 23)
)
END;


exec [dbo].[sp_create_cleaned_dim_date]

select * from [cleaned_brightlearn_sales].[dbo].[cleaned_dim_date]

