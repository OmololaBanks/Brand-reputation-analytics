CREATE TABLE AFRITECH (
	CUSTOMERID INT,
	CUSTOMERNAME TEXT,
	REGION TEXT,
	AGE INT,
	INCOME NUMERIC(10, 2),
	CUSTOMERTYPE TEXT,
	TRANSACTIONYEAR INT,
	TRANSACTIONDATE DATE,
	PRODUCTPURCHASED TEXT,
	PURCHASEAMOUNT NUMERIC(10, 2),
	PRODUCTRECALLED BOOLEAN,
	COMPETITOR_X TEXT,
	INTERACTIONDATE DATE,
	PLATFORM TEXT,
	POSTTYPE TEXT,
	ENGAGEMENTLIKES INT,
	ENGAGEMENTSHARES INT,
	ENGAGEMENTCOMMENTS INT,
	USERFOLLOWERS INT,
	INFLUENCERSCORE NUMERIC(10, 2),
	BRANDMENTION BOOLEAN,
	COMPETITORMENTION BOOLEAN,
	SENTIMENT TEXT,
	CRISISEVENTTIME DATE,
	FIRSTRESPONSETIME DATE,
	RESOLUTIONSTATUS BOOLEAN,
	NPSRESPONSE INT
);

CREATE TABLE CUSTOMERDATA (
	CUSTOMERID INT PRIMARY KEY,
	CUSTOMERNAME VARCHAR(200),
	REGION VARCHAR(50),
	AGE INT,
	INCOME NUMERIC(10, 2),
	CUSTOMERTYPE VARCHAR(50)
);

CREATE TABLE TRANSACTIONDATA (
	TRANSACTIONID SERIAL PRIMARY KEY,
	CUSTOMERID INT,
	TRANSACTIONYEAR VARCHAR(4),
	TRANSACTIONDATE DATE,
	PRODUCTPURCHASED VARCHAR(255),
	PURCHASEAMOUNT NUMERIC(10, 2),
	PRODUCTRECALLED BOOLEAN,
	FOREIGN KEY (CUSTOMERID) 
	REFERENCES CUSTOMERDATA (CUSTOMERID)
);

CREATE TABLE SOCIALMEDIA (
	POSTID SERIAL PRIMARY KEY,
	CUSTOMERID INT,
	COMPETITOR_X VARCHAR(50),
	INTERACTIONDATE DATE,
	PLATFORM VARCHAR(50),
	POSTTYPE VARCHAR(50),
	ENGAGEMENTLIKES INT,
	ENGAGEMENTSHARES INT,
	ENGAGEMENTCOMMENTS INT,
	USERFOLLOWERS INT,
	INFLUENCERSCORE NUMERIC(10, 2),
	BRANDMENTION BOOLEAN,
	COMPETITORMENTION BOOLEAN,
	SENTIMENT VARCHAR(50),
	CRISISEVENTTIME DATE,
	FIRSTRESPONSETIME DATE,
	RESOLUTIONSTATUS BOOLEAN,
	NPSRESPONSE INT,
	FOREIGN KEY (CUSTOMERID) 
	REFERENCES CUSTOMERDATA (CUSTOMERID)
);


SELECT * FROM Afritech

SELECT * FROM CustomerData

SELECT * FROM TransactionData

SELECT * FROM SocialMedia

DROP TABLE TransactionData

INSERT INTO
	CUSTOMERDATA (CUSTOMERID, CUSTOMERNAME, REGION, AGE, INCOME, CUSTOMERTYPE)
SELECT DISTINCT	CUSTOMERID,	CUSTOMERNAME, REGION, AGE, INCOME, CUSTOMERTYPE
FROM AFRITECH;

INSERT INTO
	TRANSACTIONDATA (CUSTOMERID,TRANSACTIONYEAR,TRANSACTIONDATE,PRODUCTPURCHASED,PURCHASEAMOUNT,PRODUCTRECALLED)
SELECT DISTINCT	CUSTOMERID,TRANSACTIONYEAR,TRANSACTIONDATE,PRODUCTPURCHASED,PURCHASEAMOUNT,PRODUCTRECALLED
FROM AFRITECH
WHERE TRANSACTIONDATE IS NOT NULL;

INSERT INTO
	SOCIALMEDIA (
		CUSTOMERID,
		COMPETITOR_X,
		INTERACTIONDATE,
		PLATFORM,
		POSTTYPE,
		ENGAGEMENTLIKES,
		ENGAGEMENTSHARES,
		ENGAGEMENTCOMMENTS,
		USERFOLLOWERS,
		INFLUENCERSCORE,
		BRANDMENTION,
		COMPETITORMENTION,
		SENTIMENT,
		CRISISEVENTTIME,
		FIRSTRESPONSETIME,
		RESOLUTIONSTATUS,
		NPSRESPONSE
	)
SELECT DISTINCT
	CUSTOMERID,
	COMPETITOR_X,
	INTERACTIONDATE,
	PLATFORM,
	POSTTYPE,
	ENGAGEMENTLIKES,
	ENGAGEMENTSHARES,
	ENGAGEMENTCOMMENTS,
	USERFOLLOWERS,
	INFLUENCERSCORE,
	BRANDMENTION,
	COMPETITORMENTION,
	SENTIMENT,
	CRISISEVENTTIME,
	FIRSTRESPONSETIME,
	RESOLUTIONSTATUS,
	NPSRESPONSE
FROM
	AFRITECH
WHERE INTERACTIONDATE IS NOT NULL;

--- Data Validation (Columns) 
SELECT * FROM CustomerData LIMIT 5; 

SELECT * FROM TransactionData LIMIT 5; 

SELECT * FROM SocialMedia LIMIT 5; 

-- Data Cleaning (Missing Values) 
SELECT COUNT(*) 
FROM Customerdata 
WHERE CustomerID IS NULL; 

SELECT COUNT(*) 
FROM TransactionData 
WHERE TransactionID IS NULL; 

SELECT COUNT(*) 
FROM SocialMedia 
WHERE PostID IS NULL; 

--Further Data Cleaning
SELECT
  COUNT(*) FILTER (WHERE customerid IS NULL) AS customerid_nulls,
  COUNT(*) FILTER (WHERE customername IS NULL) AS customername_nulls,
  COUNT(*) FILTER (WHERE region IS NULL) AS region_nulls,
  COUNT(*) FILTER (WHERE age IS NULL) AS age_nulls,
  COUNT(*) FILTER (WHERE income IS NULL) AS income_nulls,
  COUNT(*) FILTER (WHERE customertype IS NULL) AS customertype_nulls
FROM Customerdata;

SELECT
  COUNT(*) FILTER (WHERE transactionyear IS NULL) AS transactionid_nulls,
  COUNT(*) FILTER (WHERE transactiondate IS NULL) AS transactiondate_nulls,
  COUNT(*) FILTER (WHERE productpurchased IS NULL) AS productpurchased_nulls,
  COUNT(*) FILTER (WHERE purchaseamount IS NULL) AS purchaseamount_nulls,
  COUNT(*) FILTER (WHERE productrecalled IS NULL) AS productrecalled_nulls
  FROM Transactiondata;

SELECT
  COUNT(*) FILTER (WHERE competitor_x IS NULL) AS competitor_x,
  COUNT(*) FILTER (WHERE interactiondate IS NULL) AS interactiondate,
  COUNT(*) FILTER (WHERE platform IS NULL) AS platform,
  COUNT(*) FILTER (WHERE posttype IS NULL) AS posttype,
  COUNT(*) FILTER (WHERE engagementlikes IS NULL) AS engagementlikes,
  COUNT(*) FILTER (WHERE engagementshares IS NULL) AS engagementshares,
  COUNT(*) FILTER (WHERE engagementcomments IS NULL) AS engagementcomments,
  COUNT(*) FILTER (WHERE userfollowers IS NULL) AS userfollowers,
  COUNT(*) FILTER (WHERE influencerscore IS NULL) AS influencerscore,
  COUNT(*) FILTER (WHERE brandmention IS NULL) AS brandmention,
  COUNT(*) FILTER (WHERE competitormention IS NULL) AS competitormention,
  COUNT(*) FILTER (WHERE sentiment IS NULL) AS sentiment,
  COUNT(*) FILTER (WHERE crisiseventtime IS NULL) AS crisiseventtime,
  COUNT(*) FILTER (WHERE firstresponsetime IS NULL) AS firstresponsetime,
  COUNT(*) FILTER (WHERE resolutionstatus IS NULL) AS resolutionstatus,
  COUNT(*) FILTER (WHERE npsresponse IS NULL) AS npsresponse
FROM Socialmedia;

-- EXPLORATORY DATA ANALYSIS - CUSTOMERDATA
--How many regions exist?
SELECT COUNT(DISTINCT Region) AS UniqueRegion
FROM CustomerData;

-- How many customers in each region 
SELECT Region, Count(*) AS count 
FROM CustomerData 
GROUP BY Region 
ORDER BY COUNT(*) DESC; 

--What is the average age of customers in regions
SELECT
  Region,
  ROUND(AVG(age)::numeric, 2) AS avg_age,
  COUNT(*) AS customer_count
FROM Customerdata
GROUP BY region
ORDER BY avg_age DESC;

--What is the age distribution per region in age band
SELECT
  Region,
  COUNT(*) FILTER (WHERE age BETWEEN 18 AND 34) AS young_adult,
  COUNT(*) FILTER (WHERE age BETWEEN 35 AND 54) AS adult,
  COUNT(*) FILTER (WHERE age BETWEEN 55 AND 69) AS older_adult
FROM Customerdata
WHERE age BETWEEN 18 AND 69
GROUP BY region
ORDER BY region;

--What is the average, maximum and minimum income per region
SELECT
  Region,
  ROUND(MIN(income)::numeric, 2) AS min_income,
  ROUND(MAX(income)::numeric, 2) AS max_income,
  ROUND(AVG(income)::numeric, 2) AS avg_income,
  ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY income)::numeric, 2) AS median_income,
  COUNT(*) AS customer_count
FROM Customerdata
GROUP BY region
ORDER BY avg_income DESC;

-- How many unique customers do we have? 
SELECT COUNT(DISTINCT CustomerID) AS UniqueCustomers 
FROM CustomerData; 

-- What is the highest, lowest and average age of the customers? 
SELECT MAX(Age) AS highest_age,
MIN(Age) AS lowest_age, 
ROUND(AVG(Age), 0) AS Average_age 
FROM CustomerData; 

-- What is the customer type distribution 
SELECT customertype, COUNT(*) AS count 
FROM CustomerData 
GROUP BY customertype 
ORDER BY customertype DESC;

--What is the age distribution of Customer Type
SELECT
  customertype,
  COUNT(*) FILTER (WHERE age BETWEEN 18 AND 34) AS young_adult,
  COUNT(*) FILTER (WHERE age BETWEEN 35 AND 54) AS adult,
  COUNT(*) FILTER (WHERE age BETWEEN 55 AND 69) AS older_adult,
  COUNT(*) AS customers
FROM public.customerdata
WHERE age BETWEEN 18 AND 69
GROUP BY customertype
ORDER BY customertype;

--What is the highest, lowest and average income per customer
SELECT ROUND(MAX(Income), 2) AS highest_Income, 
ROUND(MIN(Income), 2) AS lowest_Income, 
ROUND(AVG(Income), 2) AS Average_Income 
FROM CustomerData; 

--Creating Income band for high, mid and low earners
SELECT
  customerid,
  customername,
  region,
  age,
  income,
  customertype,
  CASE
    WHEN income BETWEEN 16000 AND 49999 THEN 'Low earner'
    WHEN income BETWEEN 50000 AND 79999 THEN 'Mid earner'
    WHEN income >= 80000 THEN 'High earner'
  END AS Income_segment
FROM Customerdata
WHERE income IS NOT NULL;

--Total customers in created income band
SELECT
  CASE
    WHEN income BETWEEN 16000 AND 49999 THEN 'Low earner'
    WHEN income BETWEEN 50000 AND 79999 THEN 'Mid earner'
    WHEN income >= 80000 THEN 'High earner'
  END AS income_segment,
  COUNT(*) AS customers
FROM public.customerdata
WHERE income IS NOT NULL
GROUP BY income_segment
ORDER BY customers DESC;

--What is income distribution by customer type using the income band
SELECT
  customertype,
  COUNT(*) FILTER (WHERE income >= 80000) AS high_earner,
  COUNT(*) FILTER (WHERE income BETWEEN 50000 AND 79999) AS mid_earner,
  COUNT(*) FILTER (WHERE income BETWEEN 16000 AND 49999) AS low_earner,
  COUNT(*) AS customers
FROM public.customerdata
WHERE income IS NOT NULL
GROUP BY customertype
ORDER BY customertype;

SELECT * FROM Customerdata

SELECT COUNT(*) FROM public.transactiondata;

-- EXPLORATORY DATA ANALYSIS - TRANSACTIONDATA
-- What is the highest, lowest and average price of product in Afritech? 
SELECT ROUND(MAX(PurchaseAmount), 2) AS highest_price, 
ROUND(MIN(PurchaseAmount), 2) AS lowest_price, 
ROUND(SUM(PurchaseAmount) /COUNT (TransactionID), 2) AS Average_price FROM TransactionData; 

-- What are the product recall distribution? 
SELECT ProductRecalled, COUNT(*) AS RecallCount, SUM(PurchaseAmount) AS TotalSales 
FROM TransactionData 
Group BY ProductRecalled 
ORDER BY SUM(PurchaseAmount) DESC; 

--How many customers recalled products per year
SELECT
  Transactionyear,
  COUNT(DISTINCT customerid) AS customers_with_recalls
FROM Transactiondata
WHERE productrecalled = TRUE
GROUP BY transactionyear
ORDER BY transactionyear;

--What is the total sale
SELECT
  ROUND(SUM(purchaseamount), 2) AS total_sales
FROM Transactiondata;

--What is the total quantity of sold product
SELECT
  COUNT(*) AS total_quantity_sold
FROM Transactiondata;

--What is the total quantity and sales per year?
SELECT
  Transactionyear,
  COUNT(*) AS total_quantity_sold,
  ROUND(SUM(purchaseamount), 2) AS total_salesperyear
FROM Transactiondata
GROUP BY transactionyear
ORDER BY transactionyear;

--Distribution of product sold per year
SELECT
  Transactionyear,
  Productpurchased,
  COUNT(*) AS total_quantity_sold
FROM Transactiondata
GROUP BY Transactionyear, Productpurchased
ORDER BY Transactionyear, total_quantity_sold DESC;

--Which product generated the highest revenue
SELECT
  Productpurchased,
  COUNT(*) AS Sales_volume,
  ROUND(SUM(Purchaseamount), 2) AS Total_revenue
FROM Transactiondata
GROUP BY Productpurchased
ORDER BY Total_revenue DESC;

--How many product recalls occur per year and by product type?
SELECT
  transactionyear,
  productpurchased,
  COUNT(*) AS recall_count
FROM public.transactiondata
WHERE productrecalled = TRUE
GROUP BY transactionyear, productpurchased
ORDER BY transactionyear, recall_count DESC;

SELECT * FROM TRANSACTIONDATA

-- EXPLORATORY DATA ANALYSIS - SocialMedia
-- what are the likes behavior per platform? 
SELECT platform, SUM(EngagementLikes) AS Total_Likes, AVG(EngagementLiKes) AS Average_Likes 
FROM SocialMedia 
GROUP BY platform 
ORDER BY SUM(EngagementLikes) DESC;

-- what are the Shares behavior per platform? 
SELECT platform, SUM(EngagementShares) AS Total_Shares, AVG(EngagementShares) AS Average_Shares 
FROM SocialMedia 
GROUP BY platform 
ORDER BY SUM(EngagementShares) DESC; 

-- what are the Comments behavior per platform? 
SELECT platform, SUM(EngagementComments) AS Total_Comments, AVG(EngagementComments) AS Average_Comments 
FROM SocialMedia 
GROUP BY platform 
ORDER BY SUM(EngagementComments) DESC; 

--What is sentiment distribution?
SELECT Sentiment, COUNT(*) AS count 
FROM SocialMedia 
GROUP BY Sentiment 
ORDER BY COUNT (*) DESC;

-- what is the total mention for brand?
SELECT COUNT(*) AS NumberofMentions 
FROM SocialMedia 
WHERE BrandMention = 'True'; 

-- Total mention of brand by Platform
SELECT platform, COUNT(*) AS NumberofMentions 
FROM SocialMedia 
WHERE BrandMention = 'True' 
GROUP BY platform 
ORDER BY COUNT (*) DESC; 

-- what does engagement rate per platform look like? 
SELECT
  platform,
  COUNT(*) AS total_posts,
  ROUND(
    AVG(
      (engagementlikes + engagementshares + engagementcomments)
      / NULLIF(userfollowers, 0)
    ),
    4
  ) AS avg_engagement_rate
FROM public.socialmedia
GROUP BY platform
ORDER BY avg_engagement_rate DESC;

-- Brand Mentions vs Competitor mentions 
SELECT SUM(CASE 
WHEN BrandMention = 'True' THEN 1 
ELSE 0 
END) AS BrandMentionCount, 
SUM(CASE 
WHEN CompetitorMention = 'True' THEN 1 
ELSE 0 
END) AS CompetitorMentionCount
FROM SocialMedia;

--Brand Mentions vs Competitor mentions by Platform
SELECT
  platform,
  SUM(CASE
        WHEN brandmention = TRUE THEN 1
        ELSE 0
      END) AS brandmentioncount,
  SUM(CASE
        WHEN competitormention = TRUE THEN 1
        ELSE 0
      END) AS competitormentioncount
FROM Socialmedia
GROUP BY platform
ORDER BY platform;

--What is the Response Time for the brand to respond to crisis(in days)
SELECT
  ROUND(
    AVG(
      DATE_PART(
        'epoch',
        firstresponsetime::timestamp - crisiseventtime::timestamp
      ) / 86400
    )::numeric,
    2
  ) AS average_response_time_days
FROM Socialmedia
WHERE crisiseventtime IS NOT NULL
  AND firstresponsetime IS NOT NULL;

--What is the Response Time for the brand to respond to crisis per platform(in days)
SELECT
  Platform,
  ROUND(
    AVG(
      DATE_PART(
        'epoch',
        firstresponsetime::timestamp - crisiseventtime::timestamp
      ) / 86400
    )::numeric,
    2
  ) AS Avg_response_days
FROM Socialmedia
WHERE Crisiseventtime IS NOT NULL
  AND Firstresponsetime IS NOT NULL
GROUP BY platform
ORDER BY avg_response_days DESC;

-- Top Influencers 
SELECT
  CustomerID,
  ROUND(AVG(InfluencerScore)::numeric, 2) AS Influencescore
FROM public.socialmedia
GROUP BY CustomerID
ORDER BY Influencescore DESC
LIMIT 10;

-- Total Revenue by platform 
SELECT s.platform, sum(t.purchaseamount) AS Total_Revenue FROM SocialMedia s 
LEFT JOIN Transactiondata t 
ON s.customerid = t.customerid 
WHERE t.purchaseamount IS NOT NULL 
GROUP BY s.platform 
ORDER BY SUM(t.purchaseamount) 
LIMIT 5; 

--Total user follower by platform
SELECT
  platform,
  SUM(userfollowers) AS total_userfollowers
FROM Socialmedia
WHERE userfollowers IS NOT NULL
GROUP BY platform
ORDER BY total_userfollowers DESC;

--What is the resolution status distribution
SELECT
  resolutionstatus,
  COUNT(*) AS posts
FROM public.socialmedia
GROUP BY resolutionstatus
ORDER BY posts DESC;

--What is the resolution status by platform
SELECT
  resolutionstatus,
  COUNT(*) FILTER (WHERE platform = 'Facebook')  AS facebook,
  COUNT(*) FILTER (WHERE platform = 'Twitter')   AS twitter,
  COUNT(*) FILTER (WHERE platform = 'Instagram') AS instagram,
  COUNT(*) FILTER (WHERE platform = 'LinkedIn')  AS linkedin
FROM public.socialmedia
GROUP BY resolutionstatus
ORDER BY resolutionstatus;

--Create a view for average purchase amount by product 
CREATE VIEW avg_purchase_per_product AS 
SELECT productpurchased, AVG(purchaseamount) AS avg_purchase_amount FROM transactiondata 
GROUP BY productpurchased; 

SELECT * FROM avg_purchase_per_product; 

SELECT * FROM SocialMedia



