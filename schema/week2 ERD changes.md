
I made some changes to the ERD compared to Week 1.

What Changed:
- post_title went from varchar(255) to a more reasonable n=100
- in the table posts, DOUBLE does not exist as a data type. I changed it to NUMERIC(10,2) for now until we find out more about what the metric really is
- in the table likes, DOUBLE does not exist as a data type. I change the “metric” to BIGINT
- in multiple tables, strings were marked as varchar(255), they were all changed to varchar(100)
- Users emails and display name are now globally unique
- I decided to make Hashtags unique per post in post_hashtags, leveraging the Primary Key methodology
