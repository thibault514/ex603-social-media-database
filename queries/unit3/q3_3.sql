
-- Preamble :
-------------
-- how many distinct posts are there?  13
select count (distinct post_id) from likes;

-- how many spam rows are there? 12
select count(like_id) from likes where removal_reason='Spam detected';

-- how many distinct post_id have at least 1 spam? 9!!
select count(distinct post_id) from likes where removal_reason='Spam detected';

-- how many TOTAL posts have a like from a user that has 1 spam event? 72!!!!
select count(like_id) from likes where user_id in (select user_id from likes where removal_reason='Spam detected');
-- and that includes the 12 that have 'Spam Detected' --> 72 - 12 = 60

-----------
-- PART 3 :
-----------
-- Question:
-- Which Posts from SPAM DETECTED users were NOT marked as Spam?
-- (so a user likes a post, which is marked as spam. how many *other* likes do 
-- these 'maybe suspicious people' have?)

-- using: IN
select user_id, post_id, like_id, removal_reason
from likes
where user_id in (select user_id from likes where removal_reason='Spam detected')
	and removal_reason!='Spam detected' 
OR user_id in (select user_id from likes where removal_reason='Spam detected')
	and removal_reason is  NULL
order by user_id, post_id, removal_reason;


-- using: CTE
WITH bad_posts as(
	select * from likes
	where removal_reason='Spam detected'
)

select user_id, post_id, like_id, removal_reason
from likes
where   user_id in (select user_id from bad_posts)
	and like_id not in (select like_id from bad_posts)
order by user_id, post_id, removal_reason;


-- using: inner join
select likes.user_id, post_id, likes.like_id, removal_reason
from likes
inner join (select distinct user_id from likes where removal_reason='Spam detected') as baddies on likes.user_id=baddies.user_id
where likes.removal_reason!='Spam detected' or likes.removal_reason is NULL;


-------------------------
---- SHOW THAT IT WORKS :
-------------------------

drop table using_in;
drop table using_cte;
drop table using_join;

-- USING IN
CREATE TEMP TABLE using_in as
select like_id, 1 as in_one 
from likes
where user_id in (select user_id from likes where removal_reason='Spam detected')
	and removal_reason!='Spam detected' 
OR user_id in (select user_id from likes where removal_reason='Spam detected')
	and removal_reason is  NULL
order by user_id, post_id, removal_reason;

-- using CTE
CREATE TEMP TABLE using_cte as

WITH bad_posts as(
	select * from likes
	where removal_reason='Spam detected'
)

select like_id, 1 as cte_one
from likes
where   user_id in (select user_id from bad_posts)
	and like_id not in (select like_id from bad_posts)
order by user_id, post_id, removal_reason;

-- using join
CREATE TEMP TABLE using_join as

select likes.like_id, 1 as join_one
from likes
inner join (select distinct user_id from likes where removal_reason='Spam detected') as baddies on likes.user_id=baddies.user_id
where likes.removal_reason!='Spam detected' or likes.removal_reason is NULL;


--- this is what the micro data looks like
select using_in.like_id, in_one,  cte_one,  join_one
from using_in
full join using_cte on using_in.like_id=using_cte.like_id
full join using_join on using_in.like_id=using_join.like_id;
		 

--- ok here we go
select count(using_in.like_id), (in_one + cte_one + join_one) as row_sum
from using_in
full join using_cte on using_in.like_id=using_cte.like_id
full join using_join on using_in.like_id=using_join.like_id
group by (in_one + cte_one + join_one);
   -- the result is 60 rows, and because each row has 3 columns with bytes 
          -- the expected result is 60 rows, each adding up to 3
		         -- which means each row was included in each subquery




--- 4. Equivalance :
--------------------

-- The equivalance would break if any of the like_ids are NULL.
-- that's because the JOIN would still work (joined on user_ids, then used the micro-data)
-- but the CTE uses in an IN statement on the like_id. If any of the like_ids for bad posts are NULL,
                 -- the part: like_id not in (select like_id from bad_posts) --> wouldn't work.
				       -- (because the right part would have NULLs and I wouldn't get a complete result set back)



