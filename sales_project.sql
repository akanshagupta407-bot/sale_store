create database sale_store;
use sale_store;
select * from sales_store;
CREATE TABLE sales AS 
SELECT * FROM sales_store;
select * from sales;
# which products are most frequently cancelled?
# what are top 5 selling products by quantity?
# what time of the day has the highest number of purchase?
# who are the top 5 highest spending customers?
# which product category generates the highest revenue?

#Data cleaning-- to check for duplicate
SELECT transaction_id, COUNT(*) AS duplicate_count
FROM sales
GROUP BY transaction_id
HAVING COUNT(*) > 1;
DELETE FROM sales
WHERE transaction_id IN (
    SELECT transaction_id
    FROM (
        SELECT transaction_id,
               ROW_NUMBER() OVER (
                   PARTITION BY transaction_id
                   ORDER BY transaction_id
               ) AS rn
        FROM sales
    ) AS temp
    WHERE rn > 1
);

# Correction of Headers
ALTER TABLE sales
RENAME COLUMN quantiy TO quantity;
DESCRIBE sales;

-- Adding a new column with a defined data type
ALTER TABLE users 
ADD email VARCHAR(100);

-- Changing an existing column's data type (Syntax varies slightly by SQL dialect)
ALTER TABLE sales
Modify COLUMN transaction_id VARCHAR(15),
Modify COLUMN customer_id VARCHAR(15),
Modify COLUMN customer_name VARCHAR(50),
Modify COLUMN gender VARCHAR(10),
Modify COLUMN product_id VARCHAR(15);

# what are top 5 selling product category by quantity?
select product_category,
sum(quantity) as total_quantity
from sales
group by product_category
order by total_quantity DESC
LIMIT 5;

# which products are most frequently cancelled?
select product_name,
count(*) as total_cancelled
from sales
where status = 'cancelled'
group by product_name
order by total_cancelled DESC;

# who are the top 5 highest spending customers?
select customer_name,
sum(price*quantity) as total_spend
from sales
group by customer_name
order by total_spend desc
LIMIT 5;

# which product category generates the highest revenue?
select product_category,
sum(price*quantity) as total_revenue
from sales
group by product_category
order by total_revenue DESC;
select * from sales;

# what is the cancellation rate per product category?
select product_category,
count(*) as total_products,
sum(case when status = 'cancelled' then 1 else 0 END) as cancelled_count,
round(sum(case when status = 'cancelled' then 1 else 0 END) / count(*) *100 ,2) as cancelled_pct
from sales
group by product_category




















