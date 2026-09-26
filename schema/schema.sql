-- ======================================
-- EX 603 Assignment #2 - schema.sql
-- Database: Social Media
-- Author: Charles Thibault
-- Target: PostgreSQL 18
-- =====================================


-- This section deletes tables in reverse order
-- ++++++++++++++++++++++++++++++++++++++++++++++++

DROP TABLE IF EXISTS hashtag_catalogue  CASCADE;
DROP TABLE IF EXISTS post_hashtags   	CASCADE;
DROP TABLE IF EXISTS likes    			CASCADE;
DROP TABLE IF EXISTS posts    			CASCADE;
DROP TABLE IF EXISTS users    			CASCADE;



-- This section creates tables in the correct order
-- ++++++++++++++++++++++++++++++++++++++++++++++++

-- first we create the USERS table
-- users are the PK
-- all main attributes (email, display_name must be NOT NULL
-- I am using deactivated BOOL because I want to deactivate a customer without stripping out there whole history
CREATE TABLE users
( user_id 			INT,
  display_name 		VARCHAR(32) NOT NULL,
  email				VARCHAR(300) NOT NULL,
  deactivated 		BOOL,

  CONSTRAINT pk_users
  	PRIMARY KEY (user_id),

  CONSTRAINT uq_users_email
  	UNIQUE (email),

  CONSTRAINT uq_display_names
     UNIQUE (display_name)
  
  );


-- next, users create POSTS
-- let's creat an analytical post_id primary key
-- I don't want to remove POSTS from the database, instead there is a DELETED BOOL
CREATE TABLE posts
( post_id 		int, 
  user_id 		int, 
  post_title 	VARCHAR(100) NOT NULL,
  activity_flag BOOL,
  deleted 		BOOL,
  metric 		NUMERIC(10,2),
  
  CONSTRAINT pk_posts
  	PRIMARY KEY (post_id),
	  
  CONSTRAINT fk_users_post
    FOREIGN KEY (user_id) REFERENCES users (user_id) 
  );


-- users can like other user's posts
-- FK's to both USERS and POSTS
-- in case a post gets delete, remove the Likes too
CREATE TABLE likes
  (user_id 		INT,
  post_id 		INT,
  timestamp 	TIMESTAMP,
  metric 		BIGINT,

 CONSTRAINT pk_users_like
  	PRIMARY KEY (user_id, post_id),
	  
  CONSTRAINT fk_users
    FOREIGN KEY (user_id) REFERENCES users (user_id) ,

  CONSTRAINT fk_posts
    FOREIGN KEY (post_id) REFERENCES posts (post_id) 
	ON DELETE CASCADE
);


-- individual tables can have HASHTAGS!
-- in the CASE that a post is deleted (even though there is a deleted BOOL)
----~ we CASCADE the ON DELETE
CREATE TABLE post_hashtags
(post_id 	INT,
hashtag 	VARCHAR(100) NOT NULL,

 CONSTRAINT pk_post_hashtags
 	PRIMARY KEY (post_id, hashtag),

 CONSTRAINT fk_post_hashtags
    FOREIGN KEY (post_id) REFERENCES posts (post_id)
	ON DELETE CASCADE
);


-- finally, I want a "map" of hashtags
-- this is for analytical reporting
-- we will need some kind of data science text clustering tool later on to make "Categories"
CREATE TABLE hashtag_catalogue
( hashtag VARCHAR(100) NOT NULL,
 category VARCHAR(100) NOT NULL,

 CONSTRAINT pk_hashtags_per_category
 PRIMARY KEY (hashtag, category));










