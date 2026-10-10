
---------------
-- SECTION 2 --
---------------

-- PART A :
-----------

-- count the rows where the removal_reason is NOT 'User Request'   (ans:27) not correct
select count (like_id)
from likes
where removal_reason!='User request';


--- how many rows are in the table?  (ans:200)
select count(like_id) from likes;
-- how many rows have the removal_reason as "user request?"  (ans:7)
select count (like_id)
from likes
where removal_reason='User request';

--- put them together
--- "Show that the two counts do not sum to the table total" 
--- add where the removal is User Request and where it's NOT --> ans:34
select (select count(like_id) from likes where removal_reason='User request') + (select count (like_id) from likes where removal_reason!='User request');

-- another way is that the count /minus/ both conditions should be 0
select 
    (select count(like_id) from likes)
-      (select count(like_id) from likes where removal_reason='User request')
-      (select count (like_id) from likes where removal_reason!='User request');

-- make it TRUE OR FALSE
select 
   ( (select count(like_id) from likes)
-      (select count(like_id) from likes where removal_reason='User request')
-      (select count (like_id) from likes where removal_reason!='User request'))
   =0 as equal_to_zero;



--- REPAIR IT : do it in 2 different ways
---------------
-- Repair query, using NOT NULL
select count (like_id)
from likes
where removal_reason!='User request' OR removal_reason is NULL;

-- Repair query, using COALESCE
select count (like_id)
from likes
where COALESCE(removal_reason, 'Not Removed') !='User request';


-- PART B: The Alias :
----------------------

-- show me the posts that are longer than 1 minute
select
	like_id,
	dwell_ms/1000 as duration_in_seconds
from likes
where duration_in_seconds>60;

-- FIX IT > in the where
select
	like_id,
	dwell_ms/1000 as duration_in_seconds
from likes
where dwell_ms/1000>60 ;


-- fix it with a CTE
with LONG_POSTS as (
select
	like_id,
	dwell_ms/1000 as duration_in_seconds
from likes)

select
count(like_id)
from LONG_POSTS
where duration_in_seconds>60;

