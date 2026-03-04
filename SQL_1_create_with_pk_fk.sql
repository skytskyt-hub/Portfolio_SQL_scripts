--Establishes primary key
CREATE TABLE users (
user_id integer PRIMARY KEY NOT NULL,
firstname TEXT, 
visits integer,
clicks integer, 
status TEXT,
created_date TIMESTAMP, 
country TEXT,
marketing_opt_in boolean
);

/* demonstrates how data is inserted via SQL. Actual method used: Imported from csv with 
  mapping due to using ai generated datasets in csv format */
INSERT INTO users (user_id, firstname, visits, clicks, status, created_date, country, marketing_opt_in)
VALUES 
  (924197,'taylor',14,38,'active',2024-02-10 22:44:38.421243,NULL,False),
  (562958,'Alex',15,37,'inactive',2024-09-21 22:44:38.421269,'US',False),
  (381632,'Avery',11,37,'INACTIVE',2025-10-20 22:44:38.421274,'US',NULL)
  -- continue with all data ... 
  ;


--Establishes primary key
CREATE TABLE products (
product_id integer PRIMARY KEY NOT NULL,
product_name varchar(60),
price_monthly float,
annual_disc_amount float,
description varchar,
is_active boolean
);
--csv data imported and mapped in DBeaver

--Establishes pk and foreign keys to create the sample relational database
CREATE TABLE subscriptions (
subscription_id integer PRIMARY KEY NOT NULL,
user_id integer REFERENCES users (user_id),
product_id integer REFERENCES products (product_id),
signup_date TIMESTAMP NOT NULL,
purchase_date TIMESTAMP,
billing_period TEXT,
annual_discount boolean,
churn_date TIMESTAMP,
trial_period_days numeric
);
--csv data imported and mapped in DBeaver
