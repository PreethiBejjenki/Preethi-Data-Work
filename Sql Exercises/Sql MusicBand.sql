
/* Who is the senior most employee based on job title? */

SELECT top 1 title, last_name, first_name 
FROM employee
ORDER BY levels DESC;

/* Which countries have the most Invoices */

SELECT COUNT(invoice_id) AS TotalInvoices, billing_country 
FROM invoice
GROUP BY billing_country
ORDER BY TotalInvoices DESC;

/* What are top 3 values of total invoice? */

SELECT  TOP 3 total , invoice_id
FROM invoice
ORDER BY total DESC;

/* Which city has the best customers? We would like to throw a promotional Music Festival in the city 
we made the most money. Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

SELECT TOP 1 billing_city,SUM(total) AS InvoiceTotal
FROM invoice
GROUP BY billing_city
ORDER BY InvoiceTotal DESC;


/*  Who is the best customer? The customer who has spent the most money will be declared the best 
customer. Write a query that returns the person who has spent the most money.*/

SELECT  c.customer_id, c.first_name, c.last_name, SUM(i.total) AS TotalMoneySpent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY TotalMoneySpent DESC;


/*  Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

SELECT DISTINCT(c.email) AS EmailID, c.first_name AS FirstName, c.last_name AS LastName, g.name AS Name
FROM customer AS c
JOIN invoice AS i ON i.customer_id = c.customer_id
JOIN invoice_line AS il ON il.invoice_id = i.invoice_id
JOIN track AS t ON t.track_id = il.track_id
JOIN genre AS g ON g.genre_id = t.genre_id
WHERE g.name LIKE 'Rock'
ORDER BY email;


/* Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

SELECT TOP 10 art.artist_id, art.name AS artist_name, COUNT(t.track_id) AS track_count
FROM artist AS art
JOIN album AS al ON art.artist_id = al.artist_id
JOIN track AS t ON al.album_id = t.album_id
JOIN genre AS g ON t.genre_id = g.genre_id
WHERE g.name LIKE 'Rock'
GROUP BY art.artist_id, art.name
ORDER BY track_count DESC;

/* Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed
first. */

SELECT name,milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_track_length
	FROM track )
ORDER BY milliseconds DESC;

/* Find how much amount spent by each customer on artists? Write a query to return customer name,
artist name and total spent */

WITH best_selling_artist AS (
    SELECT  artist.artist_id AS artist_id, artist.name AS artist_name, 
	SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
    FROM invoice_line
    JOIN track ON track.track_id = invoice_line.track_id
    JOIN album ON album.album_id = track.album_id
    JOIN artist ON artist.artist_id = album.artist_id
    GROUP BY artist.artist_id, artist.name
    --ORDER BY total_sales DESC
)
SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY c.customer_id, c.first_name, c.last_name, bsa.artist_name
ORDER BY amount_spent DESC;
 
/* Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount. */

WITH CustomerWithCountry AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        c.country,
        SUM(i.total) AS total_spending,
        ROW_NUMBER() OVER(PARTITION BY c.country ORDER BY SUM(i.total) DESC) AS RowNo
    FROM
        invoice i
        JOIN customer c ON c.customer_id = i.customer_id
    GROUP BY
        c.customer_id, c.first_name, c.last_name, c.country
)
SELECT * FROM CustomerWithCountry WHERE RowNo <= 1;
