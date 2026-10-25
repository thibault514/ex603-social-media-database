
select * from likes
order by post_id, liked_at;

select post_id, liked_at, reaction_status from likes
order by post_id, liked_at;

select * from posts;

-- Premable: exploring my failures
select count(like_id), reaction_status
from likes
group by reaction_status;

-- failures by REASON
select count(like_id), reaction_status, removal_reason
from likes
group by reaction_status, removal_reason;

-------
-- Q1 :
-------

-- Calculate the following statistics across the entire event table,
-- using your theme's metric: 
-- the count, total, average, minimum, and maximum
-- of your theme’s metric across the whole event table, and how many distinct actors appear.

-- Note, the question says "actors" which are users
-- the preamble to the questions said Producers which are the posts

-- before I get started, what's my average failure rate? 17%
select avg(case when reaction_status='removed' then 1 else 0 end) as removed
from likes;

-- Calculate the my overall summary statistics, using posts as an anchor
with quasi as(
	select count(like_id) as like_count, post_id,
	sum (case when reaction_status='removed' then 1 else 0 end) as removed
	from likes
	group by post_id
)
select count(post_id) as post_count, min(like_count) as min_likes,
max(like_count) as max_likes, avg(like_count) as avg_likes, avg(removed) as avg_posts_removed,
round(100*avg(removed)/avg(like_count),2) as avg_removal_rate
from quasi;

-- Calculate the summary statistics, using USERS
with quasi as(
	select count(like_id) as like_count, user_id,
	sum (case when reaction_status='removed' then 1 else 0 end) as removed
	from likes
	group by user_id
)
select count(user_id) as user_count, min(like_count) as min_likes,
max(like_count) as max_likes, avg(like_count) as avg_likes, avg(removed) as avg_removed
from quasi;



-- Note:
-- There are 15 posts in the POSTS table
-- but only 13 posts in the LIKES table; and only 200 rows
-- I'm going to *assume* that this is just because we were given the first 200 rows
-- otherwise there are 2 posts that have no likes
-- summary: I think that that's just because of the set up of this problem, not a real phenomemnon


-------
-- Q2 :
-------

-- Write a query that calculates the event count and average metric for each producer.
-- Note, I think you're asking for the failure rate here

select post_id, count(like_id) as likes,
sum (case when reaction_status='removed' then 1 else 0 end) as removed
from likes
group by post_id
order by count(like_id) desc;

-- add a % metric here
select post_id, count(like_id) as likes,
sum (case when reaction_status='removed' then 1 else 0 end) as removed,
round(100*sum (case when reaction_status='removed' then 1 else 0 end)/count(like_id),2) as removal_rate
from likes
group by post_id
order by count(like_id) desc;

-- Consider what these results tell you about differences in activity and performance across producers.
-- Response: an about 20% failure rate seems to be "normal"

-------
-- Q3 :
-------

-- Choose a minimum event-count threshold and use HAVING to include only producers who meet that threshold.
-- Explain why you selected your threshold.
select post_id, count(like_id) as likes,
sum (case when reaction_status='removed' then 1 else 0 end) as removed,
round(100*sum (case when reaction_status='removed' then 1 else 0 end)/count(like_id),2) as removal_rate
from likes
group by post_id
having count(like_id)>15
order by count(like_id) desc;

-- Picked 15 as the bottom threshold.
-- Initially I picked 10 to get a good statistical representation
-- without cutting too much data out.
-- The observation with 6 likes had 2 removals for 33%, so that's a small sample bias.
-- Looking at the observations with 11-16 likes, the removal ratio was about 23%-31%
-- which is higher than the averages of for the top Producers.
-- Also picking 16 and higher means I keep 145 likes or 72.5% "of the data" :-4


-------
-- Q4 :
-------

-- How does the picture change along two dimensions at once?
-- Leadership also wants to understand how performance varies across regions.

-- Here is a view of the aggregate performance, first by client_country
select 	client_country,
	count(distinct user_id) as users,
	count(like_id) as likes, 
	count(distinct post_id) as posts,
	sum (case when reaction_status='removed' then 1 else 0 end) as removed,
	round(100*sum (case when reaction_status='removed' then 1 else 0 end)/count(like_id),2) as removal_rate
from likes
group by client_country
order by count(like_id) desc;

-- Here is a view of the performance by Country, by POST:
-- aka which Regions are producing the most Likes, by Post?
select 	client_country,
	post_id,
	count(distinct user_id) as users_liking,
	count(like_id) as likes, 
	sum (case when reaction_status='removed' then 1 else 0 end) as removed,
	round(100*sum (case when reaction_status='removed' then 1 else 0 end)/count(like_id),2) as removal_rate
from likes
group by client_country, post_id
order by client_country asc, count(like_id) desc, post_id asc;

-------------
-- ANALYSIS :
-------------

-- Actually we want to know WHICH users are BAD USERS!
select user_id, 
	count(post_id) as posts_liked,
	count(like_id) as likes,
	sum (case when reaction_status='removed' then 1 else 0 end) as removed,
	round(100*sum (case when reaction_status='removed' then 1 else 0 end)/count(like_id),2) as removal_rate
from likes
group by user_id
order by count(like_id) desc;



