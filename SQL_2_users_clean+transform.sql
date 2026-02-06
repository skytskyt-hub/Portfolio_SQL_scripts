--default schema to portfolio rather than public
set search_path to portfolio;

--create temporary transformations before committing changes
SELECT user_id, INITCAP(firstname) AS cleaned_fname, LOWER(status) AS status
FROM users
ORDER BY user_id ASC;

--commit changes
UPDATE users
SET firstname = INITCAP(firstname), status = LOWER(status);

--validate changes
SELECT user_id, firstname, status
FROM users
LIMIT 20;

--test normalized status string data will output boolean wit no null values
SELECT user_id, is_active::boolean 
FROM (SELECT user_id, status, 
	CASE WHEN status = 'active' THEN 'true'
	WHEN status = 'inactive' THEN 'false'
	END AS is_active
	FROM users) AS subquery
ORDER BY user_id ASC;

--create new boolean column
ALTER TABLE users
ADD COLUMN is_active boolean;

--add boolean data based on status data
UPDATE users
SET is_active = 
	CASE WHEN status = 'active' THEN TRUE
	WHEN status = 'inactive' THEN FALSE
	END;

--validate changes
SELECT user_id, status, is_active
FROM users
LIMIT 20;

--delete status column from table
ALTER TABLE users
DROP COLUMN status;

--inspect country data
SELECT country
FROM users;

/*data shows country abbreviations, nulls, and full names.
 A separate table of country codes, abbreviations and names 
 will need to be created to efficiently address these issues*/ 

CREATE TABLE countries (
	country_id integer PRIMARY KEY,
	country_name text,
	region text,
	country_code2 char(2),
	country_code3 char(3)
	);

--validate
SELECT *
FROM countries
LIMIT 15;



