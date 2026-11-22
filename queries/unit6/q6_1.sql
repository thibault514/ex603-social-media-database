
select * from likes
order by user_id;

select user_id, count(like_id), sum(is_removed) as removed, avg(is_removed) from likes
group by user_id;

--------------------------------------------
-- in order to make this more efficient
-- I am just to encode the removals as 0/1
--------------------------------------------
ALTER TABLE likes
ADD COLUMN is_removed INT;

UPDATE likes
SET is_removed = CASE
    WHEN reaction_status = 'removed' THEN 1
    ELSE 0
END;

-- 6.1.1. Compare each event to its producer’s average.
--------
select post_id, like_id, reaction_status, 
round(avg(is_removed) over(partition by post_id),3)  as avg_removal
from likes
order by post_id, like_id;

select post_id, sum(is_removed) as removals, round(avg(is_removed), 3) as pct_removed,
round (AVG(avg(is_removed)) over (),3) as overall_removal_rate
from likes
group by post_id;


-- 6.1.1.b - Group by
select post_id, count(*), sum(is_removed) as removed_count, round(avg(is_removed),3) as pct_removed
from likes
group by post_id;


-- 6.1.2 - Rank producers in 3 ways
---------
select post_id, count(*) as likes, sum(is_removed) as removals,
round(avg(is_removed),3)  as avg_removal,
ROW_NUMBER() over (order by avg(is_removed) desc) as rn, 
RANK()       over (order by avg(is_removed) desc) as rank,
DENSE_RANK() over (order by avg(is_removed) desc) as dense_rank
from likes
group by post_id
order by avg_removal desc, removals desc;


-- BEST POST FIRST
select post_id, count(*) as likes, sum(is_removed) as removals,
round(avg(is_removed),3)  as avg_removal,
ROW_NUMBER() over (order by avg(is_removed) asc) as rn, 
RANK()       over (order by avg(is_removed) asc) as rank,
DENSE_RANK() over (order by avg(is_removed) asc) as dense_rank
from likes
group by post_id
order by avg_removal asc, removals desc;


-- 6.1.3 - put them into NTILE
---------
select post_id, sum(is_removed) as removals,
NTILE(4) over(order by sum(is_removed) desc) as quartile
from likes
group by post_id;




