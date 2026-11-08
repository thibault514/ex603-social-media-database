
select * from hashtags;
select * from likes order by post_id, user_id;
select * from likes order by like_id;
select * from post_hashtags;
select * from post_media;
select * from posts;
select * from users;

---------
-- 5.1.1 --
---------

-- "Who are the people behind the events?"
-- Translated as: Which Users LIKED Which Posts, and When?
select users.user_name, users.email, users.signup_date, 'LIKED' as event,
 		posts.post_title, posts.posted_on, likes.liked_at, posts.author_country, users.country as liker_country
from users
inner join likes on users.user_id = likes.user_id
inner join posts on likes.post_id = posts.post_id
order by users.user_name, likes.like_id;

---------
-- 5.1.2 --
---------

-- "Return the producers associated with your theme's catalog tag"
-- Translated as: What hashtags are associated to each Post?
select hashtags.hashtag_name, posts.post_title, posts.post_id
from posts
inner join post_hashtags on posts.post_id = post_hashtags.post_id
inner join hashtags on post_hashtags.hashtag_id = hashtags.hashtag_id
order by hashtag_name, post_id;
              --- VIEW it by the "post side of the equation"
select  posts.post_id, posts.post_title, hashtags.hashtag_name 
from posts
inner join post_hashtags on posts.post_id = post_hashtags.post_id
inner join hashtags on post_hashtags.hashtag_id = hashtags.hashtag_id
order by post_id, hashtag_name;


---------
-- 5.1.3 --
---------

-- "How to the producers compare with one another?"
-- Translated as: for each post, how many likes does it have? And how many does it have compared to every other post?
-- NOTE: EVERY OTHER means use the "<>" operator. If I wanted unique pairs I would have used "<"; but I'm ok with the "duplicates"

-- There is a LIKE COUNT in the POSTS table, so we can do a "true self join here"
select a.post_title, a.like_count, b.post_title, b.like_count, a.like_count - b.like_count as difference
from posts as a
inner join posts as b on a.post_id<>b.post_id
order by a.post_title, b.post_title;


-- the LIKE COUNTS from this table are different than the LIKE counts if we summed up on the LIKES table
with sum_a as (
	select count(like_id) as count, post_id
	from likes
	group by post_id
),
 sum_b as (
	select count(like_id) as count, post_id
	from likes
	group by post_id
)
select sum_a.post_id, sum_a.count, sum_b.post_id, sum_b.count, sum_a.count - sum_b.count as difference
from sum_a
inner join sum_b on sum_a.post_id <> sum_b.post_id
order by sum_a.post_id, sum_b.post_id;


