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
