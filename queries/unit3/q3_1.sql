
-----------------
-- SECTION 3.1 --
-----------------

-- Note: I usually like to "look" at the data before I get started
SELECT * FROM users;
SELECT * FROM posts;
SELECT * FROM likes;
SELECT * FROM hashtags;
SELECT * FROM post_hashtags;
SELECT * FROM post_media;

select * from likes where removal_reason='Spam detected';
select * from likes where removal_reason!='Spam detected' ;   -- not equal with NULL's!
select * from likes where removal_reason is NULL;

select post_id, sum(40*weight) as weights
from likes
where removal_reason is NULL
group by post_id
order by post_id;


-- Q.1: What are the Top 10 most Liked Posts?
-------
select post_title, posted_on, like_count
from posts
where  is_visible = TRUE AND like_count > 100
order by like_count desc
limit 10;


-- Q.2: What are the diffrent event statuses?
-------
SELECT count(like_id) as count, removal_reason
from likes
group by removal_reason
order by count desc;

SELECT count(like_id) as count, reaction_status
from likes
group by reaction_status
order by count desc;


-- Q.3: Let's filter some events!
-------

-- which events have a weight greater than 1? numeric range
select * from likes
where weight>1; 

-- which events have a short dwelling time? numeric range
select * from likes
where dwell_ms<10000; 

-- which likes come from customers in Brazil?? using IN
SELECT * from likes
where client_country in ('Brazil'); 


-- Q4. Text and Missing
------
-- Note: the instruction say " Write queries that: find producers whose names match a text pattern using LIKE"
-- However: in the table of "Producers" (posts table) there are no meaningful text variables

-- Which posts come from Vietnam? using the LIKE pattern
select * from posts
where lower(author_country) like '%vietnam%';

-- which customers were invited by someone else? using a NOT NULL reason
select user_id from users
where invited_by IS NOT NULL;

-- which customers were NOT invited by someone else? using a NULL reason
select user_id from users
where invited_by IS NULL;

-- let's use COALESCE for invites
select user_id, coalesce(invited_by::text, 'Not invited') as invited_by
from users
order by user_id;


-- Q5. let's create a metric!
------
-- Business question: on which Posts did users spend the most time, on average?
-- technical specification: what is the average dwell time in seconds for each post? sort it from highest to lowest

select
	post_id,
	round(avg(dwell_ms)/1000,1) as avg_dwell_time_in_seconds,
	RANK() OVER (ORDER BY AVG(dwell_ms) DESC) AS ranking
from likes
where reaction_status in ('active','flagged')
group by post_id
order by  avg(dwell_ms)/1000 desc;



