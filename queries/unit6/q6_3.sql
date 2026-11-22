

-- 6.3.A  - TOP N per category
--------
--- Actually I'm not exactly sure what this is really asking...
--- but I'm going to do the MOST RECENT likes by Post

with recency as(
	select post_id, liked_at,
	ROW_NUMBER() over(partition by post_id order by liked_at desc) as rn,
	FIRST_value(liked_at) over(partition by post_id order by liked_at desc) as most_recent_like
	from likes
	where is_removed<>1
	order by post_id, liked_at desc
)
select post_id, liked_at, most_recent_like
from recency
where rn<=3
order by post_id, liked_at desc;

    -- Note: I don't need to use the UNBOUNDED because I am using DESC and FIRST (not last)
	-- since I am using RN and TIMESTAMPS I don't need to worry about ties. the 3 most recent posts is good enough based on RN.



-- 6.3.B - monthly report
with intermediate as(
	select date_trunc('month', liked_at) as month, count(like_id) as likes, sum(is_removed) as removed,
	round(sum(is_removed)::numeric/ count(like_id)::numeric,3) as removal_rate
	from likes
	group by date_trunc('month', liked_at)
	order by date_trunc('month', liked_at)
)
select month, likes, removed, removal_rate,
lag(removal_rate) over(order by month) as lagged_removal_rate,
removal_rate - lag(removal_rate) over(order by month) as MoM
from intermediate;

    -- A percent-change column that avoids division by zero (for example, with NULLIF(..., 0)).
    -- we don't want the % change in the COUNTS > we want the arithmetic difference of the averages. So this command is not included.


-- SPECIAL > what is the removal rate by the Nth Like ?
------------------------------------------------------
WITH numbered_likes AS (
    SELECT post_id,   like_id, liked_at,is_removed,
        ROW_NUMBER() OVER (PARTITION BY post_id ORDER BY liked_at, like_id) AS like_number
    FROM likes
)

SELECT
    like_number,
    COUNT(*) AS total_likes,
    SUM(is_removed) AS removals,
    ROUND(AVG(is_removed), 3) AS removal_rate

FROM numbered_likes
GROUP BY like_number
ORDER BY like_number;




-- SPECIAL > what is the removal rate post ?
------------------------------------------------------
select post_id, count(like_id) as likes, sum(is_removed) as removed,
round(avg(is_removed),3) as removal_rate
from likes
group by post_id;


-- SPECIAL > what is the removal rate by USER?
------------------------------------------------------
select user_id, count(like_id) as likes, sum(is_removed) as removed,
round(avg(is_removed),3) as removal_rate
from likes
group by user_id
order by sum(is_removed) desc;

