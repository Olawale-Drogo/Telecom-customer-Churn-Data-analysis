Our Project 1 is now defined
Project name

Telecom Customer Churn Analysis

Data source

UCI Machine Learning Repository

Dataset

Iranian Churn

DOI

10.24432/C5JW3Z

License

Creative Commons Attribution 4.0 (CC BY 4.0).

Dataset size

3,150 customer records.

Technical stack
Plain Text
GitHub
│
├── PostgreSQL
│ ↑
│ DBeaver
│
├── SQL
│
├── Python
│ └── Pandas / Jupyter
│
└── Power BI
What we're going to analyse

Based specifically on the fields UCI documents, we can investigate questions such as:

Customer churn
Plain Text
What percentage of customers churn?
Complaints
Plain Text
How does churn differ between customers
with and without complaints?
Subscription length
Plain Text
How does customer tenure relate to churn?
Usage
Plain Text
How does churn vary with:
- Seconds of use
- Frequency of use
- SMS frequency
- Distinct called numbers?
Customer value
Plain Text
How does customer value differ between
churned and retained customers?
Tariff plan
Plain Text
How does churn vary across tariff plans?
Customer status
Plain Text
What relationship exists between customer
status and eventual churn?

These are all supportable from fields UCI documents for the dataset.

Repository data documentation

Now our GitHub README should explicitly acknowledge the source.

I'd eventually add:

Markdown
## Dataset
 
This project uses the Iranian Churn dataset from the
UCI Machine Learning Repository.
 
The dataset contains customer-level information collected
from an Iranian telecommunications company.
 
Source:
UCI Machine Learning Repository
 
Dataset:
Iranian Churn
 
DOI:
10.24432/C5JW3Z
 
License:
Creative Commons Attribution 4.0 (CC BY 4.0)

That immediately improves the professionalism of the repository.

Our project sequence now

We've completed the selection step:

Plain Text
PROJECT 01 — TELECOM CUSTOMER CHURN
 
01 GitHub structure ✓
02 Dataset selection ✓
03 Download raw dataset ← NEXT
04 Understand columns
05 Create data dictionary
06 Create PostgreSQL database
07 Connect DBeaver
08 Build raw table
09 Import CSV
10 Run data-quality assessment
11 Clean/transform data
12 SQL exploratory analysis
13 Advanced churn SQL analysis
14 Python EDA
15 Power BI model
16 Dashboard
17 Business findings
18 GitHub documentation
19 Portfolio website page
20 Interview walkthrough

And I want to resist the temptation to jump straight into Power BI.

Next we download the original UCI CSV, place it correctly in the GitHub project, inspect its columns and create our data dictionary. Only after that will we design the PostgreSQL table, because the source data should determine the schema, not the other way around.

Provide your feedback on BizChat
Sources
AllPeoplePeopleFilesFilesMeetingsMeetingsEmailsEmailsChatsChatsChannelsChannelsSitesSitesPower BIPower BIOtherOther+2


===============================================
--
This is actually a useful interview example

You can eventually explain:

"During ingestion I identified an inconsistent source-column header containing whitespace. Rather than altering the raw source layer, I preserved the imported dataset and standardized the field naming in a separate analytics schema."

That shows the interviewer you're not just writing SELECT statements. You understand raw data → transformation → analysis-ready data.

UCI CSV
   ↓
raw.customer_churn
   │
   │ Preserve source
   ↓
Transformation
   ↓
analytics.customer_churn
   │
   ├── clean column names
   ├── validation
   └── analysis-ready structure
   ↓
SQL analysis

=========================================================================================
segment additional findings

"Overall Interpretation
Three broad patterns emerge from the segmentation analysis:

1. Complaints provide substantial churn separation
Customers with complaint history recorded substantially higher churn across both tariff plans and both customer-status groups.

2. Customer inactivity remains important even without complaints
Non-active customers without complaints recorded a churn rate of 36.70%, which was 20.98 percentage points above the overall baseline.

This suggests that the absence of a complaint does not necessarily indicate a low-risk customer when activity has already declined.

3. Customer value and churn move in opposite directions
Observed churn declined consistently as customer value increased. However, customer value should be combined with churn risk and customer volume when prioritizing retention activity.

Recommended Next Analytical Steps
The Python exploratory analysis should now test and visualize:

the distribution of customer value within churn groups;
the distribution of usage measures rather than averages alone;
correlations between customer value and usage variables;
potential outliers in customer value and usage;
the relationship between complaints, activity status, and engagement;
churn patterns within the 0-12 and 25-36 month tenure segments;
whether low customer value is largely explained by low usage;
and whether the status field presents a target-leakage risk.
These results provide a strong foundation for the Power BI dashboard, but the dashboard should focus on the most decision-relevant findings rather than displaying every query."