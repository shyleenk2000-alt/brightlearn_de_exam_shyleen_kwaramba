CREATE OR ALTER PROCEDURE sp_create_dwh_dim_customer
AS
BEGIN
    SET NOCOUNT ON;

    -- Create table only if it does not exist
    IF NOT EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE name = 'dwh_dim_customer'
          AND schema_id = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [dwh_brightlearn_sales].[dbo].[dwh_dim_customer](
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
INSERT INTO [dwh_brightlearn_sales].[dbo].[dwh_dim_customer]
      ( [customer_first_name]
      ,[customer_last_name]
      ,[customer_email]
      ,[customer_phone]
      ,[customer_city]
      ,[customer_province]
      ,[customer_loyalty_tier]
      ,[customer_since])

      SELECT 
      [customer_first_name]
      ,[customer_last_name]
      ,[customer_email]
      ,[customer_phone]
      ,[customer_city]
      ,[customer_province]
      ,[customer_loyalty_tier]
      ,[customer_since]
      
      FROM[cleaned_brightlearn_sales].[dbo].[cleaned_dim_customer]
      END;

      EXEC[dbo].[sp_create_dwh_dim_customer]
      
      SELECT * FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_customer]