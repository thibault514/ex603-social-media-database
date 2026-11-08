
select * from hashtags;
select * from likes order by post_id, user_id;
select * from likes order by like_id;
select * from post_hashtags;
select * from post_media;
select * from posts;
select * from users;

-----------
-- PART A :
-----------

-- Use LEFT JOIN to return all producers, including those who have never had an event.

select posts.post_id, posts.post_title, count(likes.like_id)
from posts
left join likes on likes.post_id = posts.post_id
group by posts.post_id
order by posts.post_id;


-- Use an INNER JOIN 

select posts.post_id, posts.post_title, count(likes.like_id)
from posts
inner join likes on likes.post_id = posts.post_id
group by posts.post_id
order by posts.post_id;

-- "Compare the Results"
Select 'The Inner Join missed Post_14 and Post_15';

-- confirm using NOT IN with a safety measure
select count(post_id) from posts
where post_id NOT IN (select post_id from likes where post_id is not null);


-----------
-- PART B :
-----------

-- Write a RIGHT JOIN that returns the same records as your LEFT JOIN from Part A.
select posts.post_id, posts.post_title, count(likes.like_id)
from posts
right join likes on likes.post_id = posts.post_id
group by posts.post_id
order by posts.post_id;

-- confirm that they match
select 'this query also returns Posts #1 through #13, excluding 14 and 15';

-- full outer join
select posts.post_id, posts.post_title, count(likes.like_id)
from posts
full outer join likes on likes.post_id = posts.post_id
group by posts.post_id
order by posts.post_id;


-------------------------------
-- PART C: NOT EXISTS, EXCEPT :
-------------------------------

-- Accounts that have never played anything
-- using NOT EXISTS
SELECT p.post_id, p.post_title
FROM posts p
WHERE NOT EXISTS (
	SELECT 1
	FROM likes l
	WHERE p.post_id = l.post_id
);


-- Accounts that have never played anything
-- using EXCEPT
SELECT post_id from posts
EXCEPT
SELECT post_id from likes;



