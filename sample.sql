CREATE DATABASE IF NOT EXISTS BookStore;
USE BookStore;
-- Insert additional countries


-- Insert additional customers (no 'phone' column exists)
INSERT INTO Customer (first_name, last_name, email) VALUES 

('Alice', 'Johnson', 'alice.j@email.com'),
('Bob', 'Williams', 'bob.w@email.com');

-- Link customers to addresses (using status_id=1 for 'Current')
INSERT INTO customer_address (customer_id, address_id, status_id) VALUES 
(3, 3, 1),  -- Wamaanda's address in South Africa
(4, 4, 1),  -- Alice's address in Canada
(5, 5, 1);  -- Bob's address in Australia

-- Insert additional publishers
INSERT INTO publisher (publisher_name) VALUES 
('Bloomsbury'),
('Scholastic'),
('Simon & Schuster');

-- Insert additional languages
INSERT INTO book_language (language_name) VALUES 
('French'),
('German'),
('Mandarin');

-- Insert additional authors
INSERT INTO author (author_name) VALUES 
('J.R.R. Tolkien'),
('Agatha Christie'),
('Stephen King');

-- Insert additional books
INSERT INTO book (title, isbn, num_pages, publication_date, publisher_id, language_id, price) VALUES 
('The Hobbit', '9780261102217', 310, '1937-09-21', 3, 1, 24.99),          -- Publisher: Bloomsbury (3), Language: English (1)
('Murder on the Orient Express', '9780062073501', 256, '1934-01-01', 4, 1, 12.99), -- Publisher: Scholastic (4)
('The Shining', '9780307743657', 447, '1977-01-28', 5, 1, 18.99);        -- Publisher: Simon & Schuster (5)

-- Link books to authors
INSERT INTO book_author (book_id, author_id) VALUES 
(3, 3),  -- The Hobbit by J.R.R. Tolkien
(4, 4),  -- Murder on the Orient Express by Agatha Christie
(5, 5);  -- The Shining by Stephen King

-- Insert additional shipping methods
INSERT INTO shipping_method (method_name, cost) VALUES 
('Overnight', 19.99),
('International', 29.99);

-- Insert additional orders
INSERT INTO cust_order (order_date, customer_id, shipping_address_id, method_id) VALUES 
(NOW(), 3, 3, 3),  -- Wamaanda's order via Overnight (method_id=3)
(NOW(), 4, 4, 4),  -- Alice's order via International (method_id=4)
(NOW(), 5, 5, 1);  -- Bob's order via Standard (method_id=1)

-- Insert order lines
INSERT INTO order_line (order_id, book_id, quantity, price) VALUES 
(3, 3, 1, 24.99),  -- Order 3: The Hobbit
(4, 4, 2, 12.99),  -- Order 4: 2x Murder on the Orient Express
(5, 5, 1, 18.99);  -- Order 5: The Shining

-- Insert order history updates
INSERT INTO order_history (order_id, status_id, status_date) VALUES 
(3, 1, NOW()),  -- Pending
(4, 2, NOW()),  -- Shipped
(5, 3, NOW());  -- Delivered