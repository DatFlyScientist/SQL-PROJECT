
Select * from category;
select * from customer;
select * from employee;
select * from order_details;
select * from orders;
select * from products;
select * from shippers;
select * from suppliers;

-- Total Number of Products Sold So Far
SELECT SUM(quantity) AS total_products_sold
FROM order_details;

-- Total Revenue So Far
SELECT SUM(quantity * price) AS total_revenue
FROM order_details
join products on order_details.ProductID = products.ProductID;

 -- Total Unique Products Sold Based on Category
SELECT category, COUNT(DISTINCT productid) AS total_unique_products
FROM products
LEFT JOIN order_details ON products.productid = order_details.productid
GROUP BY category;

-- Total Number of Purchase
SELECT COUNT(*) AS total_purchase
FROM orders;

-- Compare Orders made between 2021 – 2022
SELECT YEAR(orderdate) AS order_year, COUNT(*) AS total_orders
FROM orders
WHERE orderdate >= '2021-01-01' AND orderdate <= '2022-12-31'
GROUP BY order_year;

-- What is total number of customers? Compare those that have made transaction and those that haven't XXX
SELECT
    CASE
        WHEN COUNT(orders.customerid) > 0 THEN 'Made Transaction'
        ELSE 'No Transaction'
    END AS transaction_status,
    COUNT(*) AS customer_count
FROM customer c
LEFT JOIN orders o ON customer.customerid = orders.customerid
GROUP BY transaction_status;

-- Who are the Top 5 customers with the highest purchase value?
SELECT
    customer.CustomerName,
    COUNT(order_details.OrderID) AS order_count,
    SUM(products.price) AS total_order_price
FROM customer 
LEFT JOIN orders ON customer.CustomerID = orders.CustomerID
LEFT JOIN order_details ON orders.OrderID = order_details.OrderID
LEFT JOIN products ON order_details.ProductID = products.ProductID
GROUP BY customer.CustomerName
order by order_count desc
limit 5;

-- Top 5 Best Selling Products
SELECT products.ProductName, SUM(order_details.quantity) AS Total_Quantity_Sold
FROM products 
JOIN order_details ON products.ProductID = order_details.ProductID
GROUP BY products.ProductName
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- What is the Transaction value per month?
SELECT YEAR(orderdate) AS order_year, MONTH(orderdate) AS order_month, SUM(total_price) AS monthly_transaction_value
FROM (
    SELECT o.OrderID, o.order_date, SUM(od.quantity * od.unit_price) AS total_price
    FROM orders o
    JOIN order_details od ON o.OrderID = od.OrderID
    GROUP BY o.OrderID
) AS order_totals
GROUP BY order_year, order_month;




