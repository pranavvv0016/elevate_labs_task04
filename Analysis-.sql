SELECT
    c.customer_id,
    c.customer_city,
    SUM(oi.price) AS total_spent
FROM olist_customers_dataset c
JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_id, c.customer_city
ORDER BY total_spent DESC
LIMIT 5;




SELECT
    c.customer_id,
    COUNT(o.order_id) AS number_of_orders
FROM olist_customers_dataset c
LEFT JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY number_of_orders DESC;








SELECT
    oi.product_id,
    p.product_category_name,
    oi.price
FROM
    olist_order_items_dataset oi
JOIN
    olist_products_dataset p ON oi.product_id = p.product_id
WHERE
    oi.price > (SELECT AVG(price) FROM olist_order_items_dataset)
LIMIT 20;










SELECT
    SUM(payment_value) AS total_revenue,
    AVG(payment_value) AS average_order_value,
    COUNT(DISTINCT order_id) AS total_orders
FROM olist_order_payments_dataset;








CREATE VIEW RevenueByCategory AS
SELECT
    p.product_category_name,
    SUM(oi.price) AS total_revenue
FROM olist_products_dataset p
JOIN olist_order_items_dataset oi ON p.product_id = oi.product_id
GROUP BY p.product_category_name;

SELECT * FROM RevenueByCategory ORDER BY total_revenue DESC LIMIT 10;











CREATE INDEX idx_orders_customer_id ON olist_orders_dataset(customer_id);