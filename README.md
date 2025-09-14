# Data-Warehouse-Project-
# Data Warehouse Project

## 📊 Project Overview
This project demonstrates the design and implementation of a **Data Warehouse architecture** with a multi-layered approach (Bronze, Silver, Gold). The system integrates data from **CRM and ERP sources**, applies transformations, and produces **business-ready datasets** for reporting, analytics, and machine learning.

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
  <img src="docs/Relationship betweenTables.png" alt="Architecture" width="700"/>
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

## 🚀 Future Enhancements
- Real-time/streaming ingestion  
- Advanced machine learning integration  
- Automated orchestration with Airflow/Azure Data Factory  
