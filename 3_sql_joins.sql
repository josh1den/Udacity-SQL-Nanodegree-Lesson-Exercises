### Intro to Joins
/*
Try pulling all the data from the accounts table, and all the data from the orders table.
*/
SELECT *
FROM accounts
JOIN orders
ON accounts.id = orders.id;

SELECT *
FROM accounts
JOIN orders
USING (id);

/*
Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.
*/
SELECT o.standard_qty, o.gloss_qty, o.poster_qty, a.website, a.primary_poc
FROM orders as o
JOIN accounts as a
ON o.id = a.id;

SELECT o.standard_qty, o.gloss_qty, o.poster_qty, a.website, a.primary_poc
FROM orders as o
JOIN accounts as a
USING (id);

/*
Provide a table for all web_events associated with the account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.
*/
SELECT a.name, a.primary_poc, w.channel, w.occurred_at
FROM web_events AS w
JOIN accounts AS a
ON w.account_id = a.id
WHERE a.name = 'Walmart';

/*
Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to the account name.
*/
SELECT s.name AS sales_rep, r.name AS region, a.name AS act_name
FROM sales_reps AS s
JOIN region AS r
ON s.region_id = r.id
JOIN accounts AS a
ON s.id = a.sales_rep_id
ORDER BY act_name;

/*
Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.
*/
SELECT r.name AS region_name, a.name AS account_name, o.total_amt_usd / (o.total + 0.01) AS unit_price
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
JOIN sales_reps AS s
ON a.sales_rep_id = s.id
JOIN region AS r
ON s.region_id = r.id;

/*
Provide a table that provides the region for each sales_rep along
with their associated accounts. This time only for the Midwest region.
Your final table should include three columns:
the region name, the sales rep name, and the account name.
Sort the accounts alphabetically (A-Z) according to the account name.
*/
SELECT r.name AS region_name, s.name AS sales_rep_name, a.name AS account_name
FROM sales_reps AS s
JOIN accounts AS a
ON s.id = a.sales_rep_id
JOIN region AS r
ON s.region_id = r.id
WHERE r.name = 'Midwest'
ORDER BY account_name;

/*
Provide a table that provides the region for each sales_rep along with
their associated accounts. This time only for accounts where the sales
rep has a first name starting with S and in the Midwest region.
Your final table should include three columns: the region name,
the sales rep name, and the account name. Sort the accounts
alphabetically (A-Z) according to the account name.
*/
SELECT r.name AS region_name, s.name AS sales_rep_name, a.name AS account_name
FROM sales_reps AS s
JOIN accounts AS a
ON s.id = a.sales_rep_id
JOIN region AS r
ON s.region_id = r.id
WHERE s.name LIKE 'S%' AND r.name = 'Midwest'
ORDER BY account_name;

/*
Provide a table that provides the region for each sales_rep along
with their associated accounts. This time only for accounts where
the sales rep has a last name starting with K and in the Midwest
region. Your final table should include three columns: the region
name, the sales rep name, and the account name. Sort the accounts
alphabetically (A-Z) according to the account name.
*/
SELECT r.name AS region_name, s.name AS sales_rep_name, a.name AS account_name
FROM sales_reps AS s
JOIN accounts AS a
ON s.id = a.sales_rep_id
JOIN region AS r
ON s.region_id = r.id
WHERE s.name LIKE 'K%' and r.name = 'Midwest'
ORDER BY account_name;

/*
Provide the name for each region for every order, as well as
the account name and the unit price they paid (total_amt_usd/total)
for the order. However, you should only provide the results if the
standard order quantity exceeds 100. Your final table should have
3 columns: region name, account name, and unit price. In order to
avoid a division by zero error, adding .01 to the denominator here
is helpful total_amt_usd/(total+0.01).
*/
SELECT r.name AS region_name, a.name AS account_name, o.total_amt_usd/(total+0.01) AS unit_price
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
JOIN sales_reps AS s
ON a.sales_rep_id = s.id
JOIN region AS r
ON s.region_id = r.id
WHERE o.standard_qty > 100;

/*
Provide the name for each region for every order, as well as the
account name and the unit price they paid (total_amt_usd/total)
for the order. However, you should only provide the results if
the standard order quantity exceeds 100 and the poster order
quantity exceeds 50. Your final table should have 3 columns:
region name, account name, and unit price. Sort for the smallest
unit price first. In order to avoid a division by zero error,
adding .01 to the denominator here is helpful
(total_amt_usd/(total+0.01)
*/

SELECT r.name AS region_name, a.name AS account_name, o.total_amt_usd/(total+0.01) AS unit_price
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
JOIN sales_reps AS s
ON a.sales_rep_id = s.id
JOIN region AS r
ON s.region_id = r.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50;

/*
Provide the name for each region for every order, as well as the
account name and the unit price they paid (total_amt_usd/total)
for the order. However, you should only provide the results if
the standard order quantity exceeds 100 and the poster order
quantity exceeds 50. Your final table should have 3 columns:
region name, account name, and unit price. Sort for the largest
unit price first. In order to avoid a division by zero error,
adding .01 to the denominator here is helpful
(total_amt_usd/(total+0.01)
*/

SELECT r.name AS region_name, a.name AS account_name, o.total_amt_usd/(total+0.01) AS unit_price
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
JOIN sales_reps AS s
ON a.sales_rep_id = s.id
JOIN region AS r
ON s.region_id = r.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;

/*
What are the different channels used by account id 1001?
Your final table should have only 2 columns: account name
and the different channels. You can try SELECT DISTINCT to
narrow down the results to only the unique values.
*/

SELECT DISTINCT a.name AS account_name, w.channel AS channel
FROM accounts AS a
JOIN web_events AS w
ON a.id = w.account_id
WHERE a.id = 1001;

/*
Find all the orders that occurred in 2015. Your final table
should have 4 columns: occurred_at, account name, order total,
and order total_amt_usd.
*/

SELECT w.occurred_at AS occurred_at, a.name AS account_name, o.total AS order_total, o.total_amt_usd AS order_total_amt_usd
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
JOIN web_events AS w
ON a.id = w.account_id
WHERE w.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY occurred_at;
