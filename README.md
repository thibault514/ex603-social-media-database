# ex603-social-media-database

This repo analyzes the performance of a Social Media platform. We are specifically interested in how many Likes a Post receives, and whether Removed Likes (spam) are a sign of a deteroriating product.

## The Domain

The Domain included Social Media Posts:
- The Post ID
- The user who Posted it
- The user who Liked it
- When the user Liked it
- and whether that Like was removed (aka spam)

Posts had other secondary attributes such as:
- Hashtags associated with the post
- and whether that Post had any other media assigned to it

The data can answer the following questions:
- Which Users published Posts that were the most liked?
- Which Users are the most active in terms of Likes on the platform?
- Are there specific users that are constantly getting flagged? In other words, are there users whose Likes are constantly flagged for removal, signalling a Bad Actor?
- Are there specific Posts whose Likes have been Removed?

## Database Overview

The tables are:
- USERS > a table that contains the user_id, their names, and email address
- POSTS > a table containing each user's posts, including the post's title and it's "deleted" status
- LIKES > a table tracking the 'likes' on a posts
- POST_HASHTAGS > a table that extracts the hashtags present on each post
- HASHTAG_CATALOGUE > a table that maps each #hashtag to a category, so that we can summarize activity on the social platform more effectively, and potentially monetize it for ads


<img width="781" height="500" alt="image" src="https://github.com/user-attachments/assets/b8a18942-d8b9-4e56-89e9-7a0dc66b8692" />

## QUERY CATALOGUE

| Unit | SQL file | Question it Answers |
| --- | --- | --- |
| 3 | q3_1 | What are the Top 10 Most liked Posts? |
| 3 | q3_2 | Which Likes were removed because of a "user request"? |
| 3 | q3_3 | Which Other Posts did Users with Removed Likes also Like? |
| 4 | q4_1 | What is the average Removal Rate? By Post? |
| 4 | q4_2 | How does each Post's removal rate compare to the Average?  | 
| 5 | q5_1 | Which Posts were the most liked? Compared to others? |
| 5 | q5_2 | Are there any Posts without any Likes?? |
| 5 | q5_3 | Generate a HeatMap of Posts across Hashtags |
| 6 | q6_1 | How do individual Posts behave over time, quality-wise? |
| 6 | q6_2 | How is the Aggregate Removal Rate evolving over time? |
| 6 | q6_3 | What are the most recent likes per Post? |






NOTE: Assignment query catalogues in a separate document called Query Catalogue
