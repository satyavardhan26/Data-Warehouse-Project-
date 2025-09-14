# 📑 Data Dictionary – Data Warehouse Project

This document details the **schema, data types, and transformations** applied across the **Bronze, Silver, and Gold layers** of the Data Warehouse.

---

## 🔹 Bronze Layer (Raw Data)
Raw ingestion from CRM and ERP sources (CSV files). Minimal or no transformation.

### CRM Tables

**`bronze.crm_cust_info`**
| Column            | Data Type     | Description |
|--------------------|--------------|-------------|
| cst_id             | INT          | Customer ID |
| cst_key            | NVARCHAR(50) | Customer Key/Code |
| cst_firstname      | NVARCHAR(50) | Customer First Name |
| cst_lastname       | NVARCHAR(50) | Customer Last Name |
| cst_marital_status | NVARCHAR(50) | Marital Status (raw) |
| cst_gndr           | NVARCHAR(50) | Gender (raw) |
| cst_create_date    | DATE         | Creation Date |

**`bronze.crm_prd_info`**
| Column     | Data Type     | Description |
|------------|--------------|-------------|
| prd_id     | INT          | Product ID |
| prd_key    | NVARCHAR(50) | Product Key |
| prd_nm     | NVARCHAR(50) | Product Name |
| prd_cost   | INT          | Product Cost |
| prd_line   | NVARCHAR(50) | Product Line (M/R/T…) |
| prd_start_dt | DATETIME   | Start Date |
| prd_end_dt   | DATETIME   | End Date |

**`bronze.crm_sales_details`**
| Column       | Data Type     | Description |
|--------------|--------------|-------------|
| sls_ord_num  | NVARCHAR(50) | Order Number |
| sls_prd_key  | NVARCHAR(50) | Product Key (FK) |
| sls_cust_id  | INT          | Customer ID (FK) |
| sls_order_dt | INT          | Order Date (raw int) |
| sls_ship_dt  | INT          | Ship Date (raw int) |
| sls_due_dt   | INT          | Due Date (raw int) |
| sls_sales    | INT          | Sales Amount |
| sls_quantity | INT          | Quantity |
| sls_price    | INT          | Unit Price |

### ERP Tables
(Similar tables for `bronze.erp_loc_a101`, `bronze.erp_cust_az12`, `bronze.erp_px_cat_g1v2`)

---

## 🔹 Silver Layer (Cleansed & Standardized)
Data transformations applied: cleaning, normalization, derived values.

**`silver.crm_cust_info`**
| Column            | Data Type     | Transformation |
|--------------------|--------------|----------------|
| cst_id             | INT          | Latest record kept |
| cst_firstname      | NVARCHAR(50) | TRIM applied |
| cst_lastname       | NVARCHAR(50) | TRIM applied |
| cst_marital_status | NVARCHAR(50) | Normalized (M→Married, S→Single) |
| cst_gndr           | NVARCHAR(50) | Normalized (M/F→Male/Female) |
| dwh_create_date    | DATETIME2    | Default load timestamp |

**`silver.crm_prd_info`**
| Column     | Data Type     | Transformation |
|------------|--------------|----------------|
| cat_id     | NVARCHAR(50) | Extracted from product key |
| prd_key    | NVARCHAR(50) | Cleaned key substring |
| prd_line   | NVARCHAR(50) | Mapped (M=Mountain, R=Road, etc.) |
| prd_end_dt | DATE         | Derived (LEAD function) |

**`silver.crm_sales_details`**
| Column       | Data Type     | Transformation |
|--------------|--------------|----------------|
| sls_order_dt | DATE         | Converted from int |
| sls_sales    | INT          | Recalculated if invalid |
| sls_price    | INT          | Derived if missing |

**ERP Silver Tables**
- `silver.erp_loc_a101` → Hyphen removed from `cid`, country codes normalized  
- `silver.erp_cust_az12` → Birthdate validated, gender normalized  
- `silver.erp_px_cat_g1v2` → As-is copy  

---

## 🔹 Gold Layer (Business-Ready Views)
Business-ready **star schema** (fact & dimension tables).

**`gold.dim_customers`**
| Column         | Data Type     | Description |
|-----------------|--------------|-------------|
| customer_key    | INT          | Surrogate key (ROW_NUMBER) |
| customer_id     | INT          | From CRM |
| country         | NVARCHAR(50) | From ERP |
| marital_status  | NVARCHAR(50) | Normalized |
| gender          | NVARCHAR(50) | CRM preferred, ERP fallback |

**`gold.dim_products`**
| Column       | Data Type     | Description |
|--------------|--------------|-------------|
| product_key  | INT          | Surrogate key |
| category_id  | NVARCHAR(50) | From CRM (derived) |
| category     | NVARCHAR(50) | From ERP |
| subcategory  | NVARCHAR(50) | From ERP |
| product_line | NVARCHAR(50) | Cleaned descriptive |

**`gold.fact_sales`**
| Column        | Data Type     | Description |
|---------------|--------------|-------------|
| order_number  | NVARCHAR(50) | Sales Order Number |
| product_key   | INT          | FK to dim_products |
| customer_key  | INT          | FK to dim_customers |
| sales_amount  | INT          | Sales Amount |
| quantity      | INT          | Units Sold |
| price         | INT          | Unit Price |

---
