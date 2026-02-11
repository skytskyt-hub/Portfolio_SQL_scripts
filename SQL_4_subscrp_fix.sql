--investigate subscriptions table for messy data
SELECT *
FROM subscriptions
LIMIT 25;

--To fix: billing_period (normalize string case), churn_date (shows dates in the future)
UPDATE subscriptions
SET billing_period = LOWER(billing_period);

--Isolate bad churn_dates
SELECT churn_date  
FROM subscriptions
WHERE churn_date > NOW();

--Detected and corrected invalid future churn events caused by missing time constraints via AI data generation prompt
--Staging table created to add correct data
CREATE TABLE staging_subs(
	subscription_id integer PRIMARY KEY,
	churn_date timestamp, 
	last_payment timestamp);

--validate
SELECT *
FROM staging_subs
LIMIT 15;

ALTER TABLE subscriptions
ADD COLUMN last_payment timestamp;

SELECT s.subscription_id , s.churn_date AS current_churn, ss.churn_date AS fixed_churn, ss.last_payment
FROM subscriptions AS s 
JOIN staging_subs AS ss
ON s.subscription_id = ss.subscription_id 
ORDER BY current_churn ASC;

--update churn_date & last_payment in subscriptions table with correct values
UPDATE subscriptions 
SET churn_date = ss.churn_date, last_payment = ss.last_payment
FROM staging_subs AS ss 
WHERE subscriptions.subscription_id = ss.subscription_id;

SELECT churn_date
FROM subscriptions
WHERE churn_date > NOW(); --returned no records, which is good

ALTER TABLE subscriptions
ADD COLUMN next_payment timestamp;

DROP TABLE staging_subs;





