/*Question Set 2
The questions in this question set use the more advanced techniques of the course. 
These are meant to help you practice some of these more advanced techniques. 


Question 1:
We want to find out how the two stores compare in their count of rental orders during every 
month for all the years we have data for. Write a query that returns the store ID for the store, 
the year and month and the number of rental orders each store has fulfilled for that month. 
Your table should include a column for each of the following: year, month, store ID and count of 
rental orders fulfilled during that month.
ANS: 10 rows
*/

SELECT rental_year, store_id,SUM(Count_rentals)
FROM
		(SELECT DATE_PART ('month', r.rental_date) Rental_month, 
		   DATE_PART ('year', r.rental_date) Rental_year,
		   s.store_id,
			   COUNT(2) as Count_rentals
		FROM rental r
		JOIN store s
		ON r.staff_id=s.manager_staff_id
		GROUP BY 1,2,3
		ORDER BY 2,1, 4 DESC
		)
GROUP BY 1,2
ORDER BY 1,2,3 DESC;


/*Question 2
We would like to know who were our top 10 paying customers, how many payments they made on a 
monthly basis during 2007, and what was the amount of the monthly payments. 
Can you write a query to capture the customer name, month and year of payment, 
and total payment amount for each month by these top 10 paying customers?
ANS: 1874 rows
*/
SELECT TO_CHAR (pay_month, 'month') month_name, SUM(pay_amount) total_amount
FROM 
	(SELECT DATE_TRUNC('month', p.payment_date)pay_month,
		CONCAT(c.first_name, ' ', c.last_name)fullname,
		count(1) pay_count_per_month,
		SUM(p.amount) pay_amount
	FROM customer c
	JOIN payment p
	on c.customer_id=p.customer_id
	GROUP BY 1,2
	ORDER BY 2,1,4 DESC)
GROUP BY 1 
ORDER BY 2 DESC;

/*Question 3
Finally, for each of these top 10 paying customers, I would like to find out the difference 
across their monthly payments during 2007. Please go ahead and write a query to compare the payment 
amounts in each successive month. Repeat this for each of these 10 paying customers. 
Also, it will be tremendously helpful if you can identify the customer name who paid the most 
difference in terms of payments.
ANS: 3/4 rows per customer
*/

SELECT pay_month,
	   fullname,
		pay_count_per_month,
		pay_amount,
		ABS(LAG(pay_amount) OVER (ORDER BY 2,1) - pay_amount) as lead_difference
	FROM 
		(SELECT DATE_TRUNC('month', p.payment_date)pay_month,
				CONCAT(c.first_name, ' ', c.last_name)fullname,
				count(1) pay_count_per_month,
				SUM(p.amount) pay_amount

		FROM customer c
		JOIN payment p
		on c.customer_id=p.customer_id
		GROUP BY 1,2
		ORDER BY 2,1
		) 
		--WHERE fullname = 'Eleanor Hunt'
		;