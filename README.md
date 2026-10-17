# Telecom Customer Churn Analysis

A data analysis project focused on understanding why telecom customers leave and which factors are most strongly associated with churn.

## Overview

This project analyzes customer behavior, service usage, billing patterns, and contract characteristics to uncover churn drivers and support retention strategies. The workflow combines SQL-based exploration with Python-based data cleaning and analysis.

## Business Problem

Customer churn directly affects recurring revenue, customer lifetime value, and operational efficiency in telecom businesses. The goal of this analysis is to identify the customer, service, and commercial factors associated with attrition and highlight areas where retention efforts are most likely to have an impact.

## Key Questions

1. What is the overall churn rate?
2. Which customer segments have the highest churn risk?
3. How does tenure influence churn behavior?
4. Which services or product bundles are associated with higher churn?
5. How do contract terms and payment methods vary by churn status?
6. What is the revenue exposure associated with churned customers?
7. Which customer groups should be prioritized for retention analysis?

## Tools and Technologies

- PostgreSQL
- SQL
- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Jupyter Notebook
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