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


CREATE TABLE users
( user_id INT primary key,
  display_name VARCHAR(32) NOT NULL,
  deactivated BOOL);


CREATE TABLE posts
( post_id int primary key,
  user_id int REFERENCES users(user_id),
  post_title VARCHAR(100) NOT NULL,
  activity_flag BOOL,
  deleted BOOL,
  metric DOUBLE);


CREATE TABLE likes
  (user_id int REFERENCES users(user_id),
  post_id int REFERENCES posts(post_id),
  timestamp TIMESTAMP,
  metric double,
  PRIMARY KEY (user_id, post_id)
);




CREATE TABLE post_hashtags
(post_id int REFERENCES posts(post_id),
hashtag VARCHAR(255) NOT NULL,
primary key(post_id, hashtag));




CREATE TABLE hashtag_catalogue
( hashtag VARCHAR(255) NOT NULL,
 category VARCHAR(255) NOT NULL,
 PRIMARY KEY (hashtag, category));

