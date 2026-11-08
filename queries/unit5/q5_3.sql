select * from hashtags;
select * from likes order by post_id, user_id;
select * from likes order by like_id;
select * from post_hashtags;
select * from post_media;
select * from posts;
select * from users;

--------
-- 5.3 :
--------

-- PART A: Explore a Cross-Join
--------------------------------

-- Let's Cross-Join POSTS with the HASHTAG table (kind of like a catalogue)
-- This would be useful to make a "heatmap" of Posts vs. their theme

select posts.post_title, hashtags.hashtag_description
from posts
cross join hashtags

select count(*) from posts;    -- 15
select count(*) from hashtags; -- 5



-- PART B: USING EXPLAIN :
--------------------------

--- first, I'm curious about my cross-join
explain
select posts.post_title, hashtags.hashtag_description
from posts
cross join hashtags;


-- query from 5.1
explain
select users.user_name, users.email, users.signup_date, 'LIKED' as event,
 		posts.post_title, posts.posted_on, likes.liked_at, posts.author_country, users.country as liker_country
from users
inner join likes on users.user_id = likes.user_id
inner join posts on likes.post_id = posts.post_id
order by users.user_name, likes.like_id;











