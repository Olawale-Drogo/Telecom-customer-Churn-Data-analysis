# Telecom Customer Churn Analysis

A data analysis project focused on understanding why telecom customers leave and which factors are most strongly associated with churn, using the Iranian Churn dataset published by the UCI Machine Learning Repository.

## Overview

This project analyzes customer behavior, service usage, complaints, subscription length, and customer value to uncover churn patterns and support retention analysis. The workflow combines SQL-based exploration with Python-based data cleaning and analysis.

## Business Problem

Customer churn can affect recurring revenue, customer lifetime value, and operational efficiency in telecom businesses. The goal of this analysis is to identify the customer and service factors associated with attrition and highlight areas for further retention analysis.

## Dataset and Source

This project uses the **Iranian Churn** dataset from the [UCI Machine Learning Repository]
(https://archive.ics.uci.edu/dataset/563/iranian+churn+dataset).

- **Publisher:** UCI Machine Learning Repository
- **Dataset:** Iranian Churn
- **DOI:** [10.24432/C5JW3Z](https://doi.org/10.24432/C5JW3Z)
- **License:** [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/)
- **Size:** 3,150 customer records

The data was collected from an Iranian telecommunications company. The documented features represent the first nine months, while the churn status is recorded at the end of 12 months, providing a three-month interval between the feature period and the outcome.

The dataset documents fields such as call failures, complaints, subscription length, charges, usage, SMS frequency, distinct called numbers, tariff plan, customer status, age, customer value, and churn. Analyses and derived materials in this repository will retain attribution to the UCI Machine Learning Repository and the dataset's CC BY 4.0 license.

## Key Questions

1. What percentage of customers churned?
2. How does churn differ between customers with and without complaints?
3. How does subscription length relate to churn?
4. How does churn vary with usage, call failures, SMS frequency, and distinct called numbers?
5. How does customer value differ between churned and retained customers?
6. How does churn vary across tariff plans and customer status?
7. Which customer groups should be prioritized for further retention analysis?

## Tools and Technologies

- PostgreSQL
- DBeaver
- SQL
- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Jupyter Notebook
- Power BI
- Git and GitHub

## Repository Structure

- `raw/` - Raw datasets
- `processed/` - Cleaned and transformed data outputs
- `sql/` - SQL scripts for schema creation, quality checks, and analysis
- `notebooks/` - Jupyter notebooks for preprocessing and exploration
- `dashboard/` - Dashboard-related assets and documentation
- `images/` - Visual assets and screenshots
- `docs/` - Methodology, data dictionary, and findings

## Workflow

1. Load and inspect the telecom customer dataset.
2. Clean and validate the data for missing values, inconsistencies, and data types.
3. Build a structured SQL schema for analysis.
4. Explore churn patterns using SQL and Python.
5. Summarize key findings and identify retention opportunities.

## Setup

Install the required Python dependencies:

```bash
pip install -r requirements.txt
```

Then open the notebooks in Jupyter or VS Code to run the analysis workflow.

## Project Status

🚧 In Progress

## Notes

This repository is intended as a structured analytical project and can be extended with additional modeling, dashboarding, or reporting components as the analysis progresses.