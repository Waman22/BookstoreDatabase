-- Create and use the database
CREATE DATABASE IF NOT EXISTS BookStore;
USE BookStore;
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
