#### Adventure Works - ELT with DBT Integration and Dashboard with Power BI

### Project Objective
This project aims to use Modern Data Stack to create a dynamic dashboard in Power BI using the Adventure Works dataset.
Includes a challenge for analysis engineer certification. The dashboard provides valuable insights, including sales performance, customer, products, payment and others sales analysis. The solution integrates the Data Warehouse Snowflake for data storage, DBT for data transform, and Power BI for visualization.

### Project Structure
# 1. Data Source.
Transactional database (PostgreSQL) that stores data from its different areas.
This step has already been provided.
# 2. Ingestion layer.
This layer is known by the terms extrac-load within Modern Data Stack.
This step has already been provided.
# 3. Transformation layer.
Responsible for processing and storing data extracted from original data sources into its final format for consumption by data products.
Used the Snowflake data warehouse with DBT integration for data transformation.
# 4. Products layer.
Layer that exposes data products to consumers external to the data platform such as data analyst.
Connect Power BI to the Snowflake database.
Build an interactive dashboard featuring:
Key sales metrics.
Product performance.
Date performance.
Customer and City ranking.

### Key Features
Modern Data Stack: Cloud architecture more flexible and capable of dealing with the large amount of data that companies currently receive.
Data Warehouse: A large, centralized repository that stores structured and semi-structured data. It provides a single source for analysts and data scientists.
Bussiness Inteligence: Business intelligence (BI) and analytics tools are used to visualize and analyze data.

## Technologies Used
Snowflake: Database Storage.
DBT: Data transform.
Power BI: Data visualization and dashboard creation.