CREATE OR ALTER PROCEDURE sp_create_fact_brightlearn_sales
AS
BEGIN
    SET NOCOUNT ON;


    -- Create table if it does not exist
    IF NOT EXISTS (
        SELECT 1
        FROM [dwh_brightlearn_sales].sys.tables
        WHERE name = 'fact_brightlearn_sales'
          AND schema_id = SCHEMA_ID('dbo')
    )
    BEGIN

        CREATE TABLE [dwh_brightlearn_sales].[dbo].[fact_brightlearn_sales](
            [SalesID] INT IDENTITY (1,1) PRIMARY KEY,
            [CashierID] INT NOT NULL,
            [CustomerID] INT NOT NULL,
            [DateID] INT NOT NULL,
            [StoreID] INT NOT NULL,
            [SupplierID] INT NOT NULL,
            [PaymentID] INT NOT NULL,
            [ProductID] INT NOT NULL,
            [Transaction_Amount] DECIMAL(10,2) NOT NULL,
            [Transaction_Discount] DECIMAL(10,2) NOT NULL,
            [line_Amount] DECIMAL(10,2) NOT NULL,
            [Unit_Price] DECIMAL(10,2) NOT NULL,
            [Cost_Price] DECIMAL(10,2) NOT NULL,
            [Qty] INT NOT NULL,
            [Stock_on_hand] INT NOT NULL,
            [Reorder_threshold] INT NOT NULL,
            [load_date] DATETIME DEFAULT GETDATE()
        );

    END;


    INSERT INTO [dwh_brightlearn_sales].[dbo].[fact_brightlearn_sales]
    (
        CashierID,
        CustomerID,
        DateID,
        StoreID,
        SupplierID,
        PaymentID,
        ProductID,
        Transaction_Amount,
        Transaction_Discount,
        line_Amount,
        Unit_Price,
        Cost_Price,
        Qty,
        Stock_on_hand,
        Reorder_threshold
    )


    SELECT DISTINCT

        ca.CashierID,
        cu.CustomerID,
        da.DateID,
        st.StoreID,
        su.SupplierID,
        pm.PaymentID,
        pr.ProductID,

        r.Transaction_Amount,
        r.Transaction_Discount,
        r.line_Amount,
        r.Unit_Price,
        r.Cost_Price,
        r.Qty,
        r.Stock_on_hand,
        r.Reorder_threshold


    FROM [stg_brightlearn_sales].[dbo].[brightlearn_sales_raw_data] r


    INNER JOIN [dwh_brightlearn_sales].[dbo].[dwh_dim_cashier] ca
        ON LOWER(LTRIM(RTRIM(r.cashier_name))) =
           LOWER(LTRIM(RTRIM(ca.cashier_name)))


    INNER JOIN [dwh_brightlearn_sales].[dbo].[dwh_dim_customer] cu
        ON LOWER(LTRIM(RTRIM(r.customer_email))) =
           LOWER(LTRIM(RTRIM(cu.customer_email)))


    INNER JOIN [dwh_brightlearn_sales].[dbo].[dwh_dim_date] da
        ON TRY_CONVERT(DATE,r.transaction_date,23)
           = da.transaction_date


    INNER JOIN [dwh_brightlearn_sales].[dbo].[dwh_dim_store] st
        ON LOWER(LTRIM(RTRIM(r.store_name))) = st.store_name
        AND LOWER(LTRIM(RTRIM(r.store_city))) = st.store_city
        AND LOWER(LTRIM(RTRIM(r.store_province))) = st.store_province


    INNER JOIN [dwh_brightlearn_sales].[dbo].[dwh_dim_supplier] su
        ON LOWER(LTRIM(RTRIM(r.supplier))) = su.supplier


    INNER JOIN [dwh_brightlearn_sales].[dbo].[dwh_dim_payment] pm
        ON LOWER(LTRIM(RTRIM(r.payment_method))) = pm.payment_method


    INNER JOIN [dwh_brightlearn_sales].[dbo].[dwh_dim_product] pr
        ON LOWER(LTRIM(RTRIM(r.sku))) = pr.sku


    -- Prevent duplicate sales transactions
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM [dwh_brightlearn_sales].[dbo].[fact_brightlearn_sales] f

        WHERE f.CustomerID = cu.CustomerID
          AND f.ProductID = pr.ProductID
          AND f.DateID = da.DateID
          AND f.StoreID = st.StoreID
          AND f.CashierID = ca.CashierID
          AND f.Transaction_Amount = r.Transaction_Amount
          AND f.Qty = r.Qty
    );

END;
GO


EXEC dbo.sp_create_fact_brightlearn_sales;


SELECT COUNT(*) AS fact_rows
FROM [dwh_brightlearn_sales].[dbo].[fact_brightlearn_sales];
   --  EXEC[dbo].[sp_create_fact_brightlearn_sales]
       --view results
      SELECT * FROM [dwh_brightlearn_sales].[dbo].[fact_brightlearn_sales]

     
   