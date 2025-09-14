# Data Warehouse Project-

## 📊 Project Overview

The project successfully delivered a unified Data Warehouse that integrated CRM and ERP data into a single source of truth. By applying structured transformations in the Silver layer and modeling business-ready fact and dimension tables in the Gold layer, I enabled consistent, high-quality datasets for analytics and reporting. This allowed sales performance to be analyzed across customers, products, and regions with ease, while also creating machine learning–ready datasets for predictive insights. The star schema design improved query performance and made it straightforward to connect BI tools like Power BI and Tableau, ensuring the solution was both scalable and business-friendly.

## 🏗️ Architecture
- **Sources**: CRM & ERP systems (CSV files)  
- **Bronze Layer**: Raw data ingestion (batch/full load, truncate & insert)  
- **Silver Layer**: Cleaned & standardized data (data cleaning, normalization, enrichment)  
- **Gold Layer**: Business-ready views (aggregations, star schema, business logic)  
- **Consumption**: BI dashboards, SQL analytics, and ML models  

<p align="center">
  <img src="docs/Data Arch.png" alt="Architecture" width="700"/>
</p>


## 🔄 Data Flow
The pipeline moves data from **CRM/ERP → Bronze → Silver → Gold**, ensuring structured transformations and dimensional modeling.

<p align="center">
  <img src="docs/Data Flow Diagram.png" alt="Architecture" width="700"/>
</p>


## 🔗 Data Model & Relationships
Tables are structured into fact and dimension models with clear relationships between CRM and ERP systems.

<p align="center">
  <img src="docs/Relationship between Tables.png" alt="Architecture" width="700"/>
</p>
## ⚙️ Tools & Technologies
- **Database/Warehousing**: SQL-based Data Warehouse  
- **ETL**: Batch ingestion, data transformations  
- **Visualization & Consumption**: Power BI, Tableau, SQL  
- **Advanced Use Cases**: Machine Learning-ready datasets  

## ✅ Outcomes
- Unified data warehouse combining multiple data sources  
- Standardized and enriched datasets for analytics  
- Star schema and aggregated tables for BI & ML  
- Scalable architecture with reusable ETL processes  


