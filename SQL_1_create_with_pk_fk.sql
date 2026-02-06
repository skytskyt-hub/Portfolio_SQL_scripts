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

SELECT *
FROM users
LIMIT 5;

--Establishes primary key
CREATE TABLE products (
product_id integer PRIMARY KEY NOT NULL,
product_name varchar(60),
price_monthly float,
annual_disc_amount float,
description varchar,
is_active boolean
);

SELECT *
FROM products
LIMIT 5;

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

SELECT *
FROM subscriptions
LIMIT 5;
