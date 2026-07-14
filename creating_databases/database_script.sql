IF DB_ID('stg_brightlearn_sales') IS NULL
BEGIN
    CREATE DATABASE stg_brightlearn_sales;
END;

IF DB_ID('dwh_brightlearn_sales') IS NULL
BEGIN
    CREATE DATABASE dwh_brightlearn_sales;
END;