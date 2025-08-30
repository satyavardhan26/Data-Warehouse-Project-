/*
====================================================================================================
--Create Database Warehouse 
====================================================================================================
Script Purpose:
  This Script creates a new databse named "DataWarehouse" after checking if it is already exists.
  If the database exists, it is dropped and recreated. Additionally, the script sets up three schems within 
  the database 
  ^   Bronze Layer 🥉 
  ^^  Silver Layer 🥈
  ^^^ Gold Layer   🥇 
====================================================================================================

*/

USE MASTER;
GO

--Drop and recreate the "Databasewarehouse" database 

IF EXISTS( SELECT 1 FROM sys.databases WHERE name= "DataWarehouse")
  BEGIN 
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
  END;

--Create the Database Named as "DataWarehouse"
CREATE DATABASE DataWarehouse;
GO
  
USE DataWarehouse;
GO
--Creating 3 Schemas 🥉  🥈  🥇
CREATE SCHEMA Bronze;
GO
  
CREATE SCHEMA Silver;
GO
  
CREATE SCHEMA Gold;
GO




--Creating Tables 

--if we want to use this script in server it should not contain same name of the tables that's why we use drop function
IF OBJECT_ID('bronze.crm_cust_info','U') is not null
	Drop  table bronze.crm_cust_info;

-- Creating bronze.crm_cust_info
Create Table bronze.crm_cust_info
(
	cust_id					INT,
	cst_key					NVARCHAR(50),
	cst_firstname			NVARCHAR(50),
	cst_lastname			NVARCHAR(50),
	cst_material_status		NVARCHAR(50),
	cst_gndr				NVARCHAR(50),
	cst_create_date			DATE
);

IF OBJECT_ID('bronze.crm_prd_info','U') is not null
	Drop  table bronze.crm_prd_info;


-- Creating bronze.crm_prd_info
Create Table bronze.crm_prd_info
(
	prd_id			INT,
	prd_key			NVARCHAR(50),
	prd_nm			NVARCHAR(50),
	prd_cost		INT,
	prd_line		NVARCHAR(50),
	prd_start_dt	DATETIME,
	prd_end_dt		DATETIME
);

IF OBJECT_ID('bronze.crm_sales_details','U') is not null
	Drop  table bronze.crm_sales_details;

--Creating bronze.crm_sales_details
Create Table bronze.crm_sales_details
(
	sls_ord_num		NVARCHAR(50),
	sls_ord_key		NVARCHAR(50),
	sls_cust_id		INT,
	sls_order_id	INT,
	sls_ship_id		INT,
	sls_due_id		INT,
	sls_sales		INT,
	sls_quantity	INT,
	sls_price		INT
);

IF OBJECT_ID('bronze.erp_loc_a101','U') is not null
	Drop  table bronze.erp_loc_a101;
--Creating bronze.erp_loc_a101
Create Table bronze.erp_loc_a101
(
	cid		NVARCHAR(50),
	cntry	NVARCHAR(50)
)

IF OBJECT_ID('bronze.erp_cust_az12','U') is not null
	Drop  table bronze.erp_cust_az12;

--Creating bronze.erp_cust_az12
Create Table bronze.erp_cust_az12
(
	cid		NVARCHAR(50),
	bdate	DATE,
	gen		NVARCHAR(50)
)


IF OBJECT_ID('bronze.erp_px_cat_g1v2','U') is not null
	Drop  table bronze.erp_px_cat_g1v2;

--Creating bronze.erp_px_cat_g1v2
Create Table bronze.erp_px_cat_g1v2
(
	id				NVARCHAR(50),
	cat				NVARCHAR(50),
	subcat			NVARCHAR(50),
	maintenance		NVARCHAR(50),

);
