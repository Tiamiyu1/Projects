/* Quiz Question
 Let's start with creating a table that provides the following details: actor's first and last name combined as full_name, film title, film description and length of the movie.
 How many rows are there in the table? 
ANS: 5462 rows */

SELECT CONCAT(a.first_name, ' ', a.last_name) as full_name, f.title, f.description,f.length
FROM actor a
JOIN film_actor fa
ON a.actor_id=fa.actor_id
JOIN film f
ON f.film_id=fa.film_id;



/*Quiz Question

Write a query that creates a list of actors and movies where the movie length was more than 60 minutes. How many rows are there in this query result?
ANS: 4900 rows */

SELECT CONCAT(a.first_name, ' ', a.last_name) as full_name, f.title
FROM actor a
JOIN film_actor fa
ON a.actor_id=fa.actor_id
JOIN film f
ON f.film_id=fa.film_id
WHERE f.length > 60;


/*Quiz Question

Write a query that captures the actor id, full name of the actor, and counts the number of movies each actor has made. (HINT: Think about whether you should group by actor id or the full name of the actor.) Identify the actor who has made the maximum number movies.
ANS: Gina Degeneres (42 Movies) */

SELECT a.actor_id, CONCAT(a.first_name, ' ', a.last_name) as full_name, count(a.actor_id) movie_count
FROM actor a
JOIN film_actor fa
ON a.actor_id=fa.actor_id
JOIN film f
ON f.film_id=fa.film_id 
GROUP BY a.actor_id
ORDER BY movie_count DESC;