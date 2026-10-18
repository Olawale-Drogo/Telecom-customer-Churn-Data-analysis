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