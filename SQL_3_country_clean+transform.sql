--Users table cleaning cont'd: temporary transformation on country
SELECT country, COUNT(*)
FROM users
GROUP BY country;

--The only country full name returned was United States. Normalization is simplified
SELECT REPLACE(UPPER(country),'UNITED STATES','US') AS ccode, COUNT(*)
FROM users
GROUP BY ccode;

/*Results in 4 country codes of DE, UK, US and CA and 1 null grouping
 * To keep code clean, updates will be written in 2 distinct queries
 */

UPDATE users
SET country = 'US'
WHERE UPPER(country) = 'UNITED STATES';

UPDATE users 
SET country = UPPER(country)
WHERE country <> UPPER(country);

--validate changes
SELECT country, COUNT(*)
FROM users
GROUP BY country;
