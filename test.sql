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