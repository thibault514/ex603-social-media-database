
----------
-- Part 2:
----------

-- 4.2.a: For each producer, compute the total number of events 
-- and the total number of events classified as failures, 
-- add a % metric here
select post_id, count(like_id) as likes,
sum (case when reaction_status='removed' then 1 else 0 end) as removed,
round(100*sum (case when reaction_status='removed' then 1 else 0 end)/count(like_id),2) as removal_rate
from likes
group by post_id
order by count(like_id) desc;



-- 4.2.b:  subtotals per region and a platform grand total:
-- NOTE: the last row with the Client Country as NULL is the GRAND TOTAL
SELECT
    client_country,
    count(like_id) as likes,
	sum (case when reaction_status='removed' then 1 else 0 end) as removed
FROM likes
GROUP BY ROLLUP(client_country)
order by client_country NULLS LAST;


-- 4.3: with a conditional

with quasi as(
	select post_id, count(like_id) as like_count, 
	sum (case when reaction_status='removed' then 1 else 0 end) as removed,
	round(100*(sum (case when reaction_status='removed' then 1 else 0 end))/count(like_id),2) as removal_rate
	from likes
	group by post_id
	order by count(like_id) desc, post_id asc
),
 benchmark as(
	select
	round(100*(sum (case when reaction_status='removed' then 1 else 0 end))/count(like_id),2) as avg_removal
	from likes
)
select * from quasi
cross join benchmark
WHERE quasi.removal_rate < benchmark.avg_removal +5 or like_count<20
order by like_count desc, post_id asc;
