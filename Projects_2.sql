-- Create Database
CREATE DATABASE OnlineBookstore;

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

-- Retrieving the all data after importing
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM Books
WHERE genre = 'Fiction';

-- 2) Find books published after the year 1950:
SELECT * FROM Books
WHERE published_year > 1950;

-- 3) List all customers from the Canada:
SELECT * FROM customers
WHERE country = 'Canada';

-- 4) Show orders placed in November 2023:
SELECT * FROM orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:
SELECT book_id, title AS Book_name, stock AS Total_stock
FROM books;

-- 6) Find the details of the most expensive book:
SELECT * FROM books 
ORDER BY price DESC
LIMIT 1;


-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM orders
WHERE quantity > 1;


-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT order_id AS Order, total_amount AS Amount 
FROM orders
WHERE total_amount > 20;


-- 9) List all genres available in the Books table:
SELECT DISTINCT(genre) FROM books;


-- 10) Find the book with the 10 lowest stock:
SELECT title AS Book_name, stock AS Lowest_stock 
FROM books
ORDER BY stock
LIMIT 10;

-- 11) Calculate the total revenue generated from all orders:
SELECT * FROM Orders;

SELECT SUM(total_amount) AS Total_revenue
FROM orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
SELECT * FROM books;
SELECT * FROM orders;

SELECT b.genre, SUM(o.quantity) AS Total_sold_quantity 
FROM books b JOIN orders o on b.book_id = o.book_id
GROUP BY b.genre;

-- 2) Find the average price of books in the "Fantasy" genre:
SELECT ROUND(AVG(price),2) AS average_price_fantasy
FROM books
WHERE genre = 'Fantasy';

-- 3) List customers who have placed at least 2 orders:
SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT customers.customer_id, customers.name, COUNT(orders.order_id) 
FROM orders JOIN customers 
ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id
HAVING COUNT(orders.order_id) > 1;


-- 4) Find the most frequently ordered book:
SELECT * FROM Orders;

SELECT book_id, COUNT(order_id) AS order_count
FROM orders
GROUP BY book_id
ORDER BY order_count DESC
LIMIT 1;



-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT title AS book_name, price FROM books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:
SELECT * FROM Books;
SELECT * FROM Orders;

SELECT books.author, COUNT(orders.quantity) AS Total_books_sold
FROM orders JOIN books
ON books.book_id = orders.book_id
GROUP BY books.author;


-- 7) List the cities where customers who spent over $30 are located:
SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT customers.name, customers.city, orders.total_amount AS Total_spent
FROM customers JOIN orders 
ON customers.customer_id = orders.customer_id
WHERE orders.total_amount > 30;

-- 8) Find the customer who spent the most on orders:

SELECT customers.name, SUM(orders.order_id) AS Total_spent
FROM customers JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.name
ORDER BY total_spent DESC
LIMIT 1;




