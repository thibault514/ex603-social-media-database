
select * from likes;

-- 6.2.A : row to row: average removal for 1 post
---------
with running as (
	select post_id, liked_at, reaction_status, is_removed,
	round( avg(is_removed) over (partition by post_id order by liked_at  ROWS BETWEEN UNBOUNDED PRECEDING
                     AND CURRENT ROW),3)  as removal_avg
    from likes
)

select post_id, liked_at, reaction_status, is_removed,
LAG(removal_avg) OVER (partition by post_id order by liked_at ) as lagged_removal_avg,
removal_avg,
removal_avg - LAG(removal_avg) OVER (partition by post_id order by liked_at ) as delta_avg,
LEAD(removal_avg) over (partition by post_id order by liked_at)  as lead_removal_avg 
from running
where post_id=12
order by post_id, liked_at;
            --- note > seems to trend down after the initial Removal


-- 6.2.B : moving average
--------
with daily as(
	select cast(liked_at as date) as date, count(like_id) as likes, sum(is_removed) as is_removed, round(sum(is_removed)::numeric/count(like_id),4) as removal_rate
	from likes
	group by cast(liked_at as date)
	order by cast(liked_at as date)
)

select date, 
sum(likes) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as likes_cumul,

SUM(is_removed) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as removed_cumul, 

ROUND(SuM(is_removed) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) /
   sum(likes) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),3) as cumul_avg,
   
 ROUND(SUM(is_removed) OVER (ORDER BY date
            ROWS BETWEEN 30 PRECEDING AND CURRENT ROW)::numeric
        / NULLIF(SUM(likes) OVER (ORDER BY date
                ROWS BETWEEN 30 PRECEDING AND CURRENT ROW), 0), 3
    ) AS moving30_removal_rate

from daily;

-- one quarter
select count(likes) as likes, sum(is_removed) as removed, sum(is_removed)/count(likes)::numeric as removal
from likes
where liked_at between '1/1/2023' and '3/31/2023';

select count(likes) as likes, sum(is_removed) as removed, sum(is_removed)/count(likes)::numeric as removal
from likes
where liked_at between '4/1/2023' and '6/30/2023';

select count(likes) as likes, sum(is_removed) as removed, sum(is_removed)/count(likes)::numeric as removal
from likes
where liked_at between '7/1/2023' and '9/30/2023';

select count(likes) as likes, sum(is_removed) as removed, sum(is_removed)/count(likes)::numeric as removal
from likes
where liked_at between '10/1/2023' and '12/31/2023';


-- 6.2.C -- on producer stopped
---------
with time_gaps as (
	select post_id, cast(liked_at as date) as date,
	LAG(cast(liked_at as date)) OVER(partition by post_id order by liked_at) as previous_date,
	cast(liked_at as date) - LAG(cast(liked_at as date)) OVER(partition by post_id order by liked_at) as date_delta
	from likes
)
select post_id, date, previous_date, date_delta
from time_gaps
where date_delta>=90;

select * from likes where post_id=5 order by liked_at;
select * from likes where post_id=9 order by liked_at;
select * from likes where post_id=12 order by liked_at;





