-- Create and use the database
CREATE DATABASE IF NOT EXISTS BookStore;
USE BookStore;

-- Drop tables in reverse order to avoid foreign key conflicts if re-running
DROP TABLE IF EXISTS order_history;
DROP TABLE IF EXISTS order_line;
DROP TABLE IF EXISTS cust_order;
DROP TABLE IF EXISTS order_status;
DROP TABLE IF EXISTS shipping_method;
DROP TABLE IF EXISTS book_author;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS author;
DROP TABLE IF EXISTS book_language;
DROP TABLE IF EXISTS publisher;
DROP TABLE IF EXISTS customer_address;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS address_status;
DROP TABLE IF EXISTS address;
DROP TABLE IF EXISTS country;

-- Create tables
-- country
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

-- address
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- address_status
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- customer
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20)
);

-- customer_address
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- publisher
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(100) NOT NULL
);

-- book_language
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL
);

-- author
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

-- book
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(13) UNIQUE NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    publication_date DATE,
    publisher_id INT,
    language_id INT,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

-- book_author (Many-to-Many)
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- shipping_method
CREATE TABLE shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL,
    cost DECIMAL(10, 2) NOT NULL
);

-- order_status
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- cust_order
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME NOT NULL,
    shipping_method_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- order_line
CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- order_history
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    status_date DATETIME NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);


-- Insert data
-- Countries
INSERT INTO country (country_id, country_name) VALUES 
(1, 'USA'),
(2, 'South Africa'),
(3, 'Zimbabwe'),
(4, 'Canada'),
(5, 'Australia')
ON DUPLICATE KEY UPDATE country_name = country_name;

-- Addresses
INSERT INTO address (address_id, street, city, postal_code, country_id) VALUES 
(1, '15 Sam Hewitt Street', 'Johannesburg', '2000', 2),
(2, '22 Maple Road', 'Toronto', 'M5V 2T6', 4),
(3, '1 George Street', 'Sydney', '2000', 5)
ON DUPLICATE KEY UPDATE street = street, city = city, postal_code = postal_code, country_id = country_id;

-- Address statuses
INSERT INTO address_status (status_id, status_name) VALUES 
(1, 'Current'),
(2, 'Old')
ON DUPLICATE KEY UPDATE status_name = status_name;

-- Customers
INSERT INTO customer (customer_id, first_name, last_name, email, phone) VALUES 
(3, 'Wamaanda', 'Phaswana', 'wamaphaswana@email.com', '555-0001'),
(4, 'Elias', 'Metsing', 'mesting@email.com', '555-0002'),
(5, 'Bongi', 'Keswa', 'keswa@email.com', '555-0003')
ON DUPLICATE KEY UPDATE first_name = first_name, last_name = last_name, email = email, phone = phone;

-- Customer addresses
INSERT INTO customer_address (customer_id, address_id, status_id) VALUES 
(3, 1, 1),
(4, 2, 1),
(5, 3, 1)
ON DUPLICATE KEY UPDATE status_id = status_id;

-- Publishers
INSERT INTO publisher (publisher_id, publisher_name) VALUES 
(3, 'Bloomsbury'),
(4, 'Scholastic'),
(5, 'Simon & Schuster')
ON DUPLICATE KEY UPDATE publisher_name = publisher_name;

-- Book languages
INSERT INTO book_language (language_id, language_name) VALUES 
(1, 'English'),
(2, 'French'),
(3, 'German'),
(4, 'Mandarin')
ON DUPLICATE KEY UPDATE language_name = language_name;

-- Authors
INSERT INTO author (author_id, first_name, last_name) VALUES 
(3, 'J.R.R.', 'Tolkien'),
(4, 'Agatha', 'Christie'),
(5, 'Stephen', 'King')
ON DUPLICATE KEY UPDATE first_name = first_name, last_name = last_name;

-- Books
INSERT INTO book (book_id, title, isbn, price, publication_date, publisher_id, language_id) VALUES 
(3, 'The Hobbit', '9780261102217', 24.99, '1937-09-21', 3, 1),
(4, 'Murder on the Orient Express', '9780062073501', 12.99, '1934-01-01', 4, 1),
(5, 'The Shining', '9780307743657', 18.99, '1977-01-28', 5, 1)
ON DUPLICATE KEY UPDATE title = title, isbn = isbn, price = price, publication_date = publication_date, publisher_id = publisher_id, language_id = language_id;

-- Book authors
INSERT INTO book_author (book_id, author_id) VALUES 
(3, 3),
(4, 4),
(5, 5)
ON DUPLICATE KEY UPDATE book_id = book_id, author_id = author_id;

-- Shipping methods
INSERT INTO shipping_method (method_id, method_name, cost) VALUES 
(1, 'Standard', 5.99),
(3, 'Overnight', 19.99),
(4, 'International', 29.99)
ON DUPLICATE KEY UPDATE method_name = method_name, cost = cost;

-- Order statuses
INSERT INTO order_status (status_id, status_name) VALUES 
(1, 'Pending'),
(2, 'Shipped'),
(3, 'Delivered')
ON DUPLICATE KEY UPDATE status_name = status_name;

-- Customer orders
INSERT INTO cust_order (order_id, order_date, customer_id, shipping_method_id, status_id) VALUES 
(3, NOW(), 3, 3, 1),
(4, NOW(), 4, 4, 2),
(5, NOW(), 5, 1, 3)
ON DUPLICATE KEY UPDATE order_date = order_date, customer_id = customer_id, shipping_method_id = shipping_method_id, status_id = status_id;

-- Order lines
INSERT INTO order_line (order_id, book_id, quantity, price) VALUES 
(3, 3, 1, 24.99),
(4, 4, 2, 12.99),
(5, 5, 1, 18.99)
ON DUPLICATE KEY UPDATE quantity = quantity, price = price;

-- Order history
INSERT INTO order_history (order_id, status_id, status_date) VALUES 
(3, 1, NOW()),
(4, 2, NOW()),
(5, 3, NOW())
ON DUPLICATE KEY UPDATE status_id = status_id, status_date = status_date;

-- Test Queries
-- Query 1: Get all books by a specific author
SELECT b.title, a.first_name, a.last_name
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id
WHERE a.last_name = 'Tolkien';

-- Query 2: Get customer orders with status
SELECT c.first_name, c.last_name, o.order_id, os.status_name
FROM customer c
JOIN cust_order o ON c.customer_id = o.customer_id
JOIN order_status os ON o.status_id = os.status_id;


-- Create an admin user
CREATE USER 'bookstore_admin'@'localhost' IDENTIFIED BY 'secure_password';
GRANT ALL PRIVILEGES ON bookstore.* TO 'bookstore_admin'@'localhost';

-- Create a read-only user
CREATE USER 'bookstore_reader'@'localhost' IDENTIFIED BY 'reader_password';
GRANT SELECT ON bookstore.* TO 'bookstore_reader'@'localhost';

-- Create a user for order management
CREATE USER 'bookstore_order_mgr'@'localhost' IDENTIFIED BY 'order_password';
GRANT SELECT, INSERT, UPDATE ON bookstore.cust_order TO 'bookstore_order_mgr'@'localhost';
GRANT SELECT, INSERT, UPDATE ON bookstore.order_line TO 'bookstore_order_mgr'@'localhost';
GRANT SELECT ON bookstore.book TO 'bookstore_order_mgr'@'localhost';

-- Apply privileges
FLUSH PRIVILEGES;