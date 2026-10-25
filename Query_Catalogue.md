
**-- Removal Rate by Post**
select post_id, count(like_id) as likes,
sum (case when reaction_status='removed' then 1 else 0 end) as removed,
round(100*sum (case when reaction_status='removed' then 1 else 0 end)/count(like_id),2) as removal_rate
from likes
group by post_id
order by count(like_id) desc;

**-- correct query that accomodates for sample size:
-- remove only posts that are more than 5 points above average**
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


**-- Are countries specific sources of removed likes? No**
SELECT
    client_country,
    count(like_id) as likes,
	sum (case when reaction_status='removed' then 1 else 0 end) as removed
FROM likes
GROUP BY ROLLUP(client_country)
order by client_country NULLS LAST;

-- Identify potentially bad USERS
select user_id, 
	count(post_id) as posts_liked,
	count(like_id) as likes,
	sum (case when reaction_status='removed' then 1 else 0 end) as removed,
	round(100*sum (case when reaction_status='removed' then 1 else 0 end)/count(like_id),2) as removal_rate
from likes
group by user_id
order by count(like_id) desc;


