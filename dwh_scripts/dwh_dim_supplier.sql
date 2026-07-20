CREATE OR ALTER PROCEDURE sp_create_dwh_dim_supplier
AS
BEGIN
    SET NOCOUNT ON;

    -- Create table only if it does not exist
    IF NOT EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE name = 'dwh_dim_supplier'
          AND schema_id = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [dwh_brightlearn_sales].[dbo].[dwh_dim_supplier](
    [SupplierID] INT IDENTITY (1,1) PRIMARY KEY,
	[supplier] [varchar](50)  NOT NULL,
	[load_date] DATETIME DEFAULT GETDATE()
) 

    END;

    ---Inserting values into table
    INSERT INTO [dwh_brightlearn_sales].[dbo].[dwh_dim_supplier]
        ([supplier])

        SELECT 
        supplier

 FROM [cleaned_brightlearn_sales].[dbo].[cleaned_dim_supplier]
 END;

 EXEC [dbo].[sp_create_dwh_dim_supplier]

 SELECT * FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_supplier]