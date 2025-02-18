create schema LibraryManagement;

--------------------------------
-- STEP 1: Create tables (p1.png)
--------------------------------
CREATE TABLE authors (
  author_id int NOT NULL AUTO_INCREMENT,
  author_name varchar(30),
  PRIMARY KEY (author_id)
);

CREATE TABLE genres (
  genre_id int NOT NULL AUTO_INCREMENT,
  genre_name varchar(60) DEFAULT NULL,
  PRIMARY KEY (`genre_id`)
);

CREATE TABLE books (
  book_id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(60),
  publication_year YEAR,
  author_id INT,
  genre_id INT,
  FOREIGN KEY (author_id) REFERENCES authors(author_id),
  FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

CREATE TABLE users (
	user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30),
    email VARCHAR(30)
);

CREATE TABLE borrowed_books (
  borrow_id  INT PRIMARY KEY AUTO_INCREMENT,
  book_id INT,
  user_id INT,
  borrow_date  DATE,
  return_date DATE,
  FOREIGN KEY (book_id) REFERENCES books(book_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

--------------------------------
-- STEP 2: Insert data (p2.png)
--------------------------------
USE librarymanagement;

INSERT INTO authors (author_name) VALUES ('Lesya Ukrainka');
INSERT INTO authors (author_name) VALUES ('Kotsubinsky');
INSERT INTO authors (author_name) VALUES ('Vynnychenko');

INSERT INTO genres (genre_name) VALUES ('драма');
INSERT INTO genres (genre_name) VALUES ('історичний роман');

INSERT INTO users (username, email) VALUES ('Ivan', 'ivan@mail.com');
INSERT INTO users (username, email) VALUES ('Maria', 'maria@mail.com');
INSERT INTO users (username, email) VALUES ('Oleg', 'oleg@mail.com');
INSERT INTO users (username, email) VALUES ('Nina', 'nina@mail.com');

INSERT INTO books (title, publication_year, author_id, genre_id) VALUES ('Лісова пісня', 2001, 1, 1);
INSERT INTO books (title, publication_year, author_id, genre_id) VALUES ('Тіні забутих предків', 1998, 2, 2);
INSERT INTO books (title, publication_year, author_id, genre_id) VALUES ('Сонячна машина', 2010, 3, 2);

INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date) VALUES (1, 4, '2025-03-10', '2025-03-20');
INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date) VALUES (2, 1, '2024-06-01', '2024-07-01');
INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date) VALUES (3, 2, '2024-09-15', '2024-10-10');
INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date) VALUES (1, 3, '2025-01-20', '2025-01-30');

--------------------------------
-- STEP 3: Select data (p3.png)
--------------------------------

SELECT 
    od.order_id, od.quantity,
    o.date, c.name AS customer, c.contact as customer_contact, c.address AS customer_address, c.city AS customer_city, c.postal_code AS postal_code, c.country AS customer_country,
    p.name as product, p.unit, p.price AS product_price,
    cat.name as category, cat.description AS category_description,
    e.first_name AS employee_first_name, e.last_name AS employee_last_name,
    s.name AS supplier_name, s.contact AS supplier_contact,
    sh.name AS shipper_name, sh.phone AS shipper_phone
FROM order_details od
INNER JOIN orders o ON od.order_id = o.id
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers sh ON o.shipper_id = sh.id
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
INNER JOIN suppliers s ON p.supplier_id = s.id;


SELECT COUNT(*) AS total_rows
FROM order_details od
INNER JOIN orders o ON od.order_id = o.id
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers sh ON o.shipper_id = sh.id
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
INNER JOIN suppliers s ON p.supplier_id = s.id;
-- result - (total_rows) 518

SELECT COUNT(*) AS total_rows
FROM order_details od
RIGHT JOIN orders o ON od.order_id = o.id
RIGHT JOIN customers c ON o.customer_id = c.id
LEFT JOIN employees e ON o.employee_id = e.employee_id
LEFT JOIN shippers sh ON o.shipper_id = sh.id
LEFT JOIN products p ON od.product_id = p.id
LEFT JOIN categories cat ON p.category_id = cat.id
LEFT JOIN suppliers s ON p.supplier_id = s.id;
-- result - (total_rows) 535

--------------------------------
-- STEP 4: Select data (p4_*.png)
--------------------------------

4.1--------------------------------------------------------------------------------
SELECT count(orders.id) as total
from orders
INNER JOIN customers on orders.customer_id = customers.id
INNER JOIN employees on orders.employee_id = employees.employee_id
INNER JOIN order_details on orders.id = order_details.order_id
INNER JOIN products on order_details.product_id = products.id
INNER JOIN categories on products.category_id = categories.id
INNER JOIN suppliers on products.supplier_id = suppliers.id
INNER JOIN shippers on orders.shipper_id = shippers.id
4.2--------------------------------------------------------------------------------
SELECT count(orders.id) as total
from orders
INNER JOIN customers on orders.customer_id = customers.id
INNER JOIN employees on orders.employee_id = employees.employee_id
LEFT JOIN order_details on orders.id = order_details.order_id
INNER JOIN products on order_details.product_id = products.id
LEFT JOIN categories on products.category_id = categories.id
INNER JOIN suppliers on products.supplier_id = suppliers.id
INNER JOIN shippers on orders.shipper_id = shippers.id
-------------------------------------------------------------------------------
SELECT count(orders.id) as total
from orders
INNER JOIN customers on orders.customer_id = customers.id
INNER JOIN employees on orders.employee_id = employees.employee_id
INNER JOIN order_details on orders.id = order_details.order_id
INNER JOIN products on order_details.product_id = products.id
RIGHT JOIN categories on products.category_id = categories.id
INNER JOIN suppliers on products.supplier_id = suppliers.id
INNER JOIN shippers on orders.shipper_id = shippers.id

4.3--------------------------------------------------------------------------------------
SELECT orders.id as order_id, customers.name as customer, 
employees.last_name as employee, products.name as product, order_details.quantity,
categories.name as category, shippers.name as shipper, suppliers.name as suppliers, 
orders.date as date
from orders
INNER JOIN customers on orders.customer_id = customers.id
INNER JOIN employees on orders.employee_id = employees.employee_id
INNER JOIN order_details on orders.id = order_details.order_id
INNER JOIN products on order_details.product_id = products.id
INNER JOIN categories on products.category_id = categories.id
INNER JOIN suppliers on products.supplier_id = suppliers.id
INNER JOIN shippers on orders.shipper_id = shippers.id
where employees.employee_id > 3 and  employees.employee_id <= 10
4.4--------------------------------------------------------------------------------------
SELECT categories.name as category, COUNT(*) as total_orders, 
AVG(order_details.quantity) as avg_quantity
from orders
INNER JOIN customers on orders.customer_id = customers.id
INNER JOIN employees on orders.employee_id = employees.employee_id
INNER JOIN order_details on orders.id = order_details.order_id
INNER JOIN products on order_details.product_id = products.id
INNER JOIN categories on products.category_id = categories.id
INNER JOIN suppliers on products.supplier_id = suppliers.id
INNER JOIN shippers on orders.shipper_id = shippers.id
where employees.employee_id > 3 and  employees.employee_id <= 10
group by categories.name
4.5--------------------------------------------------------------------------------------
SELECT categories.name AS category,  COUNT(*) AS total_orders, 
AVG(order_details.quantity) AS avg_quantity
from orders
INNER JOIN customers on orders.customer_id = customers.id
INNER JOIN employees on orders.employee_id = employees.employee_id
INNER JOIN order_details on orders.id = order_details.order_id
INNER JOIN products on order_details.product_id = products.id
INNER JOIN categories on products.category_id = categories.id
INNER JOIN suppliers on products.supplier_id = suppliers.id
INNER JOIN shippers on orders.shipper_id = shippers.id
where employees.employee_id > 3 and  employees.employee_id <= 10
group by categories.name
having avg_quantity > 21
4.6--------------------------------------------------------------------------------------
SELECT categories.name AS category,  COUNT(*) AS total_orders, 
AVG(order_details.quantity) AS avg_quantity
from orders
INNER JOIN customers on orders.customer_id = customers.id
INNER JOIN employees on orders.employee_id = employees.employee_id
INNER JOIN order_details on orders.id = order_details.order_id
INNER JOIN products on order_details.product_id = products.id
INNER JOIN categories on products.category_id = categories.id
INNER JOIN suppliers on products.supplier_id = suppliers.id
INNER JOIN shippers on orders.shipper_id = shippers.id
where employees.employee_id > 3 and  employees.employee_id <= 10
group by categories.name
having avg_quantity > 21
order by total_orders desc
4.7--------------------------------------------------------------------------------------
SELECT categories.name AS category,  COUNT(*) AS total_orders, 
AVG(order_details.quantity) AS avg_quantity
from orders
INNER JOIN customers on orders.customer_id = customers.id
INNER JOIN employees on orders.employee_id = employees.employee_id
INNER JOIN order_details on orders.id = order_details.order_id
INNER JOIN products on order_details.product_id = products.id
INNER JOIN categories on products.category_id = categories.id
INNER JOIN suppliers on products.supplier_id = suppliers.id
INNER JOIN shippers on orders.shipper_id = shippers.id
where employees.employee_id > 3 and  employees.employee_id <= 10
group by categories.name
having avg_quantity > 21
order by total_orders desc
limit 4 offset 1

--------------------------------
-- Thanks for your attention! --
--------------------------------
