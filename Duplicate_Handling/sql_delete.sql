SELECT *
 FROM bakery.customer_sweepstakes;
 
 # ALTER TABLE customer_sweepstakes RENAME COLUMN `ï»¿sweepstake_id` TO `sweepstake_id
 
 
 SELECT *
 FROM (
 SELECT customer_id,
 ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY customer_id) AS row_num
 FROM bakery.customer_sweepstakes) AS table_row
 WHERE row_num>1;
 
 DELETE
 FROM customer_sweepstakes
 WHERE sweepstake_id IN
 
 
	(SELECT sweepstake_id
	FROM (
	SELECT sweepstake_id,
		ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY customer_id) AS row_num
		FROM bakery.customer_sweepstakes) AS table_row
		WHERE row_num>1);
        
        
WITH ranked_customers AS (
    SELECT sweepstake_id,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY sweepstake_id) AS row_num
    FROM bakery.customer_sweepstakes
)
DELETE FROM bakery.customer_sweepstakes
WHERE sweepstake_id IN (
    SELECT sweepstake_id
    FROM ranked_customers
    WHERE row_num > 1
);
