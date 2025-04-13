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