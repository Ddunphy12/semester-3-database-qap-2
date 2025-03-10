-- Problem 2: Online Store Inventory and Orders System

-- Create tables
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    stock_quantity INT
);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    order_date DATE
);

CREATE TABLE order_items (
    order_id INT REFERENCES orders(id),
    product_id INT REFERENCES products(id),
    quantity INT,
    PRIMARY KEY (order_id, product_id)
);


-- Data
INSERT INTO products (product_name, price, stock_quantity) VALUES
('Laptop', 1200.00, 10),
('Smartphone', 800.00, 15),
('Headphones', 150.00, 30),
('Keyboard', 50.00, 25),
('Mouse', 30.00, 40);

INSERT INTO customers (first_name, last_name, email) VALUES
('Alice', 'Williams', 'alice.williams@example.com'),
('Bob', 'Johnson', 'bob.johnson@example.com'),
('Charlie', 'Miller', 'charlie.miller@example.com'),
('David', 'Anderson', 'david.anderson@example.com');

INSERT INTO orders (customer_id, order_date) VALUES
(1, '2024-02-01'),
(2, '2024-02-02'),
(3, '2024-02-03'),
(4, '2024-02-04'),
(1, '2024-02-05');

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1), (1, 3, 2),
(2, 2, 1), (2, 4, 1),
(3, 1, 1), (3, 5, 2),
(4, 3, 1), (4, 4, 2),
(5, 2, 1), (5, 5, 1);

-- Queries

SELECT * FROM customers;
SELECT * FROM orders;


SELECT product_name, stock_quantity FROM products;

SELECT products.product_name, order_items.quantity FROM order_items
JOIN products ON order_items.product_id = products.id
WHERE order_items.order_id = 1;

SELECT orders.id AS order_id, products.id AS product_id, order_items.quantity FROM orders
JOIN order_items ON orders.id = order_items.order_id
JOIN products ON order_items.product_id = products.id
WHERE orders.customer_id = 1;

-- Update stock after an order
UPDATE products SET stock_quantity = stock_quantity - 1 WHERE id = 1;

-- Delete order and associated items
DELETE FROM order_items WHERE order_id = 1;
DELETE FROM orders WHERE id = 1;
