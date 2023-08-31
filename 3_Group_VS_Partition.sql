---GROUP_VS_PARTITION:

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  product_id INT,
  order_date DATE,
  quantity INT,
  price DECIMAL(10,2));
  
INSERT INTO orders (order_id, customer_id, product_id, order_date, quantity, price)
VALUES 
(1021, 101, 7711, '2023-07-01', 2, 50),
(1022, 101, 7712, '2023-07-02', 1, 100),
(1023, 102, 7711, '2023-07-01', 1, 50),
(1024, 103, 7713, '2023-07-01', 5, 20),
(1025, 104, 7712, '2023-07-02', 2, 100),
(1026, 101, 7711, '2023-07-03', 3, 50);

---GROUP BY

---1.)Calculate the total quantity of products sold for each product_id.

SELECT product_id,sum(quantity) as Tot_Qnty
FROM orders
GROUP BY product_id;

---2.)Calculate the total revenue for each customer.

SELECT customer_id,sum(quantity * price) as Tot_Rev
FROM orders 
GROUP BY customer_id;

---3.)Get the maximum quantity ordered in a single order for each product.

SELECT product_id,max(quantity) as Max_Quantity
FROM orders 
GROUP BY product_id;

---4.)Get the number of orders placed by each customer.

SELECT customer_id,	count(order_id) as Ord_Count
FROM orders
GROUP BY customer_id;

---5.)Calculate the total revenue for each day.

SELECT order_date,sum(quantity * price) as Tot_Rev
FROM orders 
GROUP BY order_date;

---6.)Calculate the total revenue fpr each product each day.

SELECT product_id,order_date,sum(quantity * price) as Tot_Rev
FROM orders 
GROUP BY product_id,order_date;


---#PARTITION BY

---1.)Find the cumulative sum of quantity for each product, ordered by date.

SELECT product_id,order_date,quantity,
SUM(quantity) OVER(PARTITION BY product_id ORDER BY order_date)as c_sum_qnty
FROM orders;

---2.)Calculate the average price for each customer_id, considering only the top 3 most expensive orders.

WITH ranked_orders AS (
    SELECT customer_id, price,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY price DESC) as ranke
    FROM orders
)
SELECT customer_id, AVG(price) as avg_price
FROM ranked_orders
WHERE ranke <= 3
GROUP BY customer_id;

---3.)Find the difference in quantity for each product between consecutive orders.

SELECT order_id, product_id, order_date, quantity,
       quantity - LAG(quantity, 1) OVER (PARTITION BY product_id ORDER BY order_date) AS quantity_difference
FROM orders;

---4.)Determine the rank of each order for each customer based on the quantity, in descending order.

SELECT customer_id,order_id,quantity,
RANK() OVER(PARTITION BY customer_id ORDER BY quantity DESC) AS RUNG
FROM orders;

---5.)Find the running total (cumulative sum) of the price for each customer, sorted by order_date.

SELECT customer_id,order_date,
SUM(price)OVER(PARTITION BY customer_id ORDER BY order_date) as Cumulative_Sum
FROM orders;							