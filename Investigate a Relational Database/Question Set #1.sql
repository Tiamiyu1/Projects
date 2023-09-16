/*Question 1
We want to understand more about the movies that families are watching. The following categories are considered family movies: Animation, Children, Classics, Comedy, Family and Music.

Create a query that lists each movie, the film category it is classified in, and the number of times it has been rented out.

ANS: 350 rows
*/
SELECT category_name,SUM(rental_count) category_count
FROM
	(
	SELECT f.title film_title, cc.name category_name, count(r.rental_id) rental_count
	FROM film f
	JOIN film_category c 
	ON f.film_id = c.film_id
	JOIN category cc
	ON cc.category_id = c.category_id
	JOIN inventory i 
	ON i.film_id=f.film_id
	JOIN rental r
	ON r.inventory_id=i.inventory_id
	GROUP BY 1,2
	HAVING cc.name in ('Animation','Children','Classics','Comedy','Family', 'Music')
	ORDER BY 2,1
	) as sub
GROUP BY 1
ORDER BY 2 DESC;

/*Question 2
Now we need to know how the length of rental duration of these family-friendly movies compares 
to the duration that all movies are rented for. Can you provide a table with the movie titles and 
divide them into 4 levels (first_quarter, second_quarter, third_quarter, and final_quarter) based 
on the quartiles (25%, 50%, 75%) of the average rental duration(in the number of days) for movies 
across all categories? Make sure to also indicate the category that these family-friendly movies 
fall into.

ANS:361 rows
*/
SELECT f.title, cc.name, f.rental_duration,  NTILE(4) OVER (PARTITION BY AVG(f.rental_duration)) AS standard_quartile
FROM film f
JOIN film_category c
ON c.film_id=f.film_id
JOIN category cc
ON cc.category_id=c.category_id
GROUP BY 1,2,3
HAVING cc.name in ('Animation','Children','Classics','Comedy','Family', 'Music');

/*Question 3
Finally, provide a table with the family-friendly film category, each of the quartiles, and the corresponding count of movies within each combination of film category for each corresponding rental duration category. The resulting table should have three columns:
Category
Rental length category
Count*/

SELECT category,
       COUNT(CASE WHEN standard_quartile = 1 THEN 1 ELSE NULL END) AS Q_1,
       COUNT(CASE WHEN standard_quartile = 2 THEN 1 ELSE NULL END) AS Q_2,
       COUNT(CASE WHEN standard_quartile = 3 THEN 1 ELSE NULL END) AS Q_3,
       COUNT(CASE WHEN standard_quartile = 4 THEN 1 ELSE NULL END) AS Q_4
FROM (
    SELECT f.title,
           cc.name AS category,
           f.rental_duration,
           NTILE(4) OVER (PARTITION BY AVG(f.rental_duration)) AS standard_quartile
    FROM film f
    JOIN film_category c ON c.film_id = f.film_id
    JOIN category cc ON cc.category_id = c.category_id
    WHERE cc.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
	GRoup BY 1,2,3
) sub1
GROUP BY category
ORDER BY category;
