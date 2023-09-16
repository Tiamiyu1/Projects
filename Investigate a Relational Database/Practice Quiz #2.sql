/*Quiz Question
Write a query that displays a table with 4 columns: actor's full name, film title, length of movie, and a column name "filmlen_groups" that classifies movies based on their length. Filmlen_groups should include 4 categories: 1 hour or less, Between 1-2 hours, Between 2-3 hours, More than 3 hours.

Match the filmlen_groups with the movie titles in your result dataset.

ANS
Academy Dinosaur:Between 1-2 hours
Color Philadelphia:Between 2-3 hours
Oklahoma Jumanji:1 hour or less
*/

SELECT CONCAT(a.first_name, ' ', a.last_name) as full_name, 
	f.title, 
	CASE WHEN f.length <=60  THEN '1 hour or less'
		 WHEN f.length > 60 AND f.length <=120 THEN 'Between 1-2 hours'
		 WHEN f.length > 120 AND f.length <=180 THEN 'Between 2-3 hours'
		 ELSE 'More than 3 hours' END as filmlen_groups
FROM actor a
JOIN film_actor fa
ON a.actor_id=fa.actor_id
JOIN film f
ON f.film_id=fa.film_id;


/*Quiz Question
Now, we bring in the advanced SQL query concepts! Revise the query you wrote above to create a count of movies in each of the 4 filmlen_groups: 1 hour or less, Between 1-2 hours, Between 2-3 hours, More than 3 hours.

Match the count of movies in each filmlen_group.

ANS
1 hour or less:104
Between 1-2 hours:439
Between 2-3 hours:418
More than 3 hours:39
*/
SELECT CASE WHEN f.length <=60  THEN '1 hour or less'
			 WHEN f.length > 60 AND f.length <=120 THEN 'Between 1-2 hours'
			 WHEN f.length > 120 AND f.length <=180 THEN 'Between 2-3 hours'
			 ELSE 'More than 3 hours' END  filmlen_group,
			 count(1) as counter
FROM film f
GROUP BY 1;



