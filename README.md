# SQL Project: Data Cleaning and Exploratory Data Analysis (EDA)

## Overview
This project focuses on cleaning and analyzing layoff data using SQL. The dataset contains records of layoffs across various industries, companies, and countries. The goal is to ensure data accuracy, standardization, and conduct exploratory data analysis (EDA) to derive insights into layoff trends.

## Dataset
- **Source**: [Kaggle - Layoffs 2022](https://www.kaggle.com/datasets/swaptr/layoffs-2022)
- **Attributes**: Company, Location, Industry, Total Laid Off, Percentage Laid Off, Date, Stage, Country, Funds Raised (in millions)

## Project Steps
### 1. Data Cleaning
- Created a **staging table** to avoid modifying raw data.
- Identified and **removed duplicate** records.
- **Standardized industry and country names** to maintain consistency.
- Converted `date` column to the proper **date format**.
- Handled **NULL values** in key columns.

### 2. Exploratory Data Analysis (EDA)
- Identified **top companies with the most layoffs**.
- Analyzed **country-wise layoffs**.
- Examined **industry-wide layoffs**.
- Explored **yearly layoff trends**.

## How to Use the SQL Scripts
1. Download or clone this repository.
2. Load the dataset into your **SQL database**.
3. Run the **data cleaning SQL script** to preprocess the dataset.
4. Execute the **EDA SQL queries** to generate insights.

## Technologies Used
- **SQL (MySQL/PostgreSQL)** for data cleaning and analysis.
- **Kaggle Dataset** for real-world data.

## Insights & Findings
- Some industries, such as **Tech and Crypto**, faced the highest layoffs.
- Layoffs peaked in **specific years/months**.
- Companies with the most layoffs include **major tech giants**.

## Contributing
Feel free to contribute by improving queries, adding visualizations, or extending the analysis!

## Author
Thanuja AV

