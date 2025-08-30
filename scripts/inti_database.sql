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


--impoerted datasets from various places 

--Stored Procedures

--Execute bronze.load_bronze; 🗝 for shortcut procedure 

--
Execute bronze.load_bronze;
--

Create OR Alter Procedure bronze.load_bronze AS 

BEGIN
	DECLARE @start_time DATETIME ,@end_time DATETIME,@Batch_starttime DATETIME, @Batch_endtime DATETIME;
	BEGIN TRY
		SET @Batch_starttime = GETDATE();
		print'======================================================';
		Print 'Loading Bronze Layer ';
		print'======================================================';


		print'^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^';
		Print 'Loading CRM Tables ';
		print'^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^';

		set @start_time = GETDATE();
		Print '>> Truncating Table : bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		Print '>> inserting Table Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		From 'D:\Data warehouse project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		With (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
		set @end_time = GETDATE();
		print '>> Load Duration' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		PRINT '----------------------------------'
		
		set @start_time = GETDATE();
		Print '>> Truncating Table : bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		Print '>> Inserting Table Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		From 'D:\Data warehouse project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		With (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
		set @end_time = GETDATE();
		print '>> Load Duration' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		PRINT '----------------------------------'
	
		set @start_time = GETDATE();
		Print '>> Truncating Table : bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		Print '>> Inserting Table Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		From 'D:\Data warehouse project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		With (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
		set @end_time = GETDATE();
		print '>> Load Duration' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		PRINT '----------------------------------'


		print'^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^';
		Print 'Loading ERP Tables ';
		print'^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^';

		set @start_time = GETDATE();

		Print '>> Truncating Table : bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101

		Print '>> inserting Table Into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		From 'D:\Data warehouse project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		With (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
		set @end_time = GETDATE();
		print '>> Load Duration' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		PRINT '----------------------------------'	

		set @start_time = GETDATE();

		Print '>> Truncating Table : bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		Print '>> Inserting Table Into : bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		From 'D:\Data warehouse project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		With (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
		set @end_time = GETDATE();
		print '>> Load Duration' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		PRINT '----------------------------------'

		set @start_time = GETDATE();

		Print '>> Truncating Table : bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		Print '>> Inserting Table Into : bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		From 'D:\Data warehouse project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		With (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
		set @end_time = GETDATE();
			print '>> Load Duration' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
			PRINT '----------------------------------'
			
		print'======================================================';
		SET @Batch_endtime = GETDATE();
		print'======================================================';
		print '>> Total Load Duration' + CAST (DATEDIFF(second, @Batch_starttime, @Batch_endtime) AS NVARCHAR) + 'Seconds';
			PRINT '----------------------------------'


		END TRY
		BEGIN CATCH
			print'======================================================';
			print'ERROR OCCURED DURING LOADING BRONZE LAYER ';
			print'ERROR MESSAGE' + ERROR_MESSAGE();
			print'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
			print'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
			print'======================================================';

	END CATCH
END



