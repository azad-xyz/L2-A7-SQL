CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) CHECK (price >= 0) NOT NULL,
    stock INT CHECK (stock >= 0) NOT NULL,
    published_year INT CHECK (published_year > 0)
);



CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    joined_date DATE DEFAULT CURRENT_DATE
);



CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
    book_id INT REFERENCES books(id) ON DELETE CASCADE,
    quantity INT CHECK (quantity > 0) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO books (title, author, price, stock, published_year) 
VALUES 
  ('The Catcher in the Rye', 'J.D. Salinger', 15.99, 100, 1951),
  ('To Kill a Mockingbird', 'Harper Lee', 12.99, 200, 1960),
  ('1984', 'George Orwell', 9.99, 50, 1949),
  ('Moby Dick', 'Herman Melville', 19.99, 30, 1851);


INSERT INTO customers (name, email) 
VALUES 
  ('Alice Johnson', 'alice.johnson@example.com'),
  ('Bob Smith', 'bob.smith@example.com'),
  ('Charlie Brown', 'charlie.brown@example.com'),
  ('David White', 'david.white@example.com');


INSERT INTO orders (customer_id, book_id, quantity) 
VALUES 
  (1, 1, 2),
  (2, 3, 1),
  (3, 2, 3),
  (4, 4, 1);


SELECT * FROM books
WHERE stock = 0;


SELECT * FROM books
ORDER BY price DESC
LIMIT 1;

SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id;


SELECT SUM(b.price * o.quantity) AS total_revenue
FROM orders o
JOIN books b ON o.book_id = b.id;


SELECT c.id, c.name, c.email, COUNT(o.id) AS total_orders
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id
HAVING COUNT(o.id) > 1;


SELECT AVG(price) AS average_price
FROM books;


UPDATE books
SET price = price * 1.10
WHERE published_year < 2000;


DELETE FROM customers
WHERE id NOT IN (
    SELECT DISTINCT customer_id
    FROM orders
);


