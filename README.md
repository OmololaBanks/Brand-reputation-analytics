# Brand-reputation-analytics
Brand sentiment and reputation analysis using PostgreSQL and Power BI to detect negative trends, monitor public perception, and flag potential reputational risks.

# Brand Reputation Analytics – Sentiment, Reputation & Business Monitoring
## Project Overview
This project delivers an interactive Power BI analytics solution designed to assess customer demographics, sales performance, product recalls, and social media brand reputation for an Indigenous Electronics organization in the United State. The dashboard integrates structured customer analysis, transactional data with social media engagement to provide a holistic view of how operational issues such as product recalls and crisis response impact customer trust, public perception, and business performance.
I used SQL-based data preparation, Power BI modelling, DAX-driven KPI automation, and interactive dashboard design, aligned with real-world business intelligence and reputation management challenges.

## Project Objectives
- Protect Market Position by monitoring brand visibility and competitor activity across social media platforms.
- Improve Customer Retention through analysis of product recalls, crisis resolution outcomes, and response efficiency.
- Enable Crisis Mitigation by identifying patterns in negative sentiment and recall-related reputational risk.
- Support Data-Driven Decision-Making through the development of actionable KPIs and interactive dashboards.
- Enhance Marketing Effectiveness by analysing platform-level engagement, sentiment trends, and influencer impact.

## Data Sources
Customer Data
- Customer ID, name, region
- Age, income, income band, age band
- Customer type (new vs returning)
Transaction Data
-	Transaction ID, customer ID
-	Product purchased, purchase amount
- Transaction year
-	Product recall indicator
Social Media Data
-	Platform (LinkedIn, Twitter, Instagram, Facebook, TikTok)
-	Engagement metrics (likes, shares, comments, followers)
-	Sentiment (positive, neutral, negative)
-	Brand and competitor mentions
-	Crisis event time, first response time
-	Resolution status and influencer score

## Data Preparation
-	Cleaned and validated datasets in PostgreSQL
-	Handled missing values using context-aware assumptions (e.g. non-crisis posts retained with NULL crisis dates)
-	Created engineered features:
o	Age bands (Young Adult, Adult, Older Adult)
o	Income bands (Low, Mid, High earners)
o	Crisis flag (Is Crisis)
o	Engagement rate measures
-	Imported cleaned data into Power BI for modelling
-	Built relationships across customer, transaction, and social media tables

## Key KPIs
-	Total Customers
-	Total Regions
-	Average Customer Age
-	Average Income
-	Total Sales Revenue
-	Total Purchase Quantity
-	Total Recall Count
-	Crisis Resolution Rate (%)
-	Average Crisis Response Time (Days)
-	Brand Engagement Rate
-	Negative Sentiment Count

## Key Insights
-	Customer concentration is highest in a small number of regions, increasing reputational and revenue risk if crises or recalls occur in these markets.
-	The charts shows that client serves a broadly balanced age demographic, meaning reputational issues are likely to affect multiple customer segments simultaneously.
-	Higher average incomes across age groups indicate greater sensitivity to service failures and a higher risk of churn following unresolved crises.
-	A strong base of returning customers highlights brand loyalty, but also increases exposure to negative sentiment if trust is damaged.
-	The dominance of mid- and high-income customers amplifies reputational impact, as dissatisfaction among high-value segments can rapidly escalate online.
-	Clients’s customer base is high-value and geographically concentrated, making rapid crisis response and proactive reputation management critical to protecting market position.
-	Laptop and smartphone sales dominate revenue, making these products critical to protect from recall-related and reputational risks.
-	Adult and older adult customers account for most recalls, increasing churn risk among Client’s most economically active segments.
-	Smartphones show the highest recall frequency, indicating elevated reputational risk for a high-visibility product category.
-	Consistently high regional incomes suggest strong customer expectations and low tolerance for product or service failures.
-	Recall volumes decline over time, potentially reflecting improved quality control, though trends should be validated against sentiment data.
-	High engagement across platforms increases brand visibility but also amplifies the impact of negative incidents if not managed quickly.
-	Visual content (images and stories) drives stronger customer interaction, making it both a powerful marketing tool and a high-risk channel during crises.
-	Slower response times on key platforms increase the likelihood of sentiment escalation and customer dissatisfaction.
-	Brand and competitor visibility are closely matched, meaning reputational issues can quickly shift attention toward competitors.
-	A high number of unresolved issues indicates operational gaps that may prolong negative sentiment and weaken customer trust.
-	Persistent negative sentiment highlights ongoing reputational vulnerability that requires proactive monitoring and timely intervention.

## Dashboard Features
-	Multi-page dashboard structure:
o	Customer Analysis Dashboard
o	Transaction Analysis Dashboard
o	Social Media Analysis Dashboard
-	Interactive KPI cards for executive overview
-	Drill-down bar, line, donut, and combo charts
-	Cross-dashboard navigation using page navigation buttons
-	Platform, year, and sentiment slicers
-	Clear separation of crisis vs non-crisis analytics
-	Export-ready visuals suitable for reporting and presentations

## Tools
-	PostgreSQL (data cleaning, transformation, validation)
-	Power BI (data modelling, DAX measures, visual analytics)

## Live Dashboard
The interactive PowerBI dashboard is for easy viewing:
[Open Live PowerBI Dashboard](https://app.powerbi.com/groups/me/reports/abd87586-15d3-4fbd-85e3-2b51144146b8/ec04d7eaeb2987ee33b0?experience=power-bi)
