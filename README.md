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

See --> https://github.com/thibault514/ex603-social-media-database/tree/main/queries

## Technical Findings

1) Basic NOT EXISTS functionality allowed us to identify that Posts #14 and #15 did not have any likes

Further investigation showed that the likes table was truncated at row 200. We believe the data was improperly truncated during the database migration. See Technical Memo #1.

2) Window Functions are useful for time-series but also analytic functions

Basic time-series operators show that the platform has been behaving properly over the last 30 days: the 30-day moving average is below historical norms.

More interesting, we can build a function that looks at the Removals per LIKE #: It is clear that most removals happen in the beginning of a Post's Lifecycle, creating small sample bias on the % removal rate:
- we should remove a post if it has more than 40% removal of Likes and more than 20 total Likes

3) CTEs are particularly useful as "staging areas" for data

It is easier to build reports, especially using Window functions, using CTE's as staging areas for results.

We can build all sorts of different aggregates in the CTE's and join across CTE's, doing richer analytics.

4) Query Optimization

Query Optimization is quite important when passing through Bridge or Linkage tables.

Reviewing Explain output might show you where you forgot to index a column.

## Findings and Recommendations

Main Finding: The Removal rate is stable around 17%. The platform is performing well.

Secondary Finding: Likes that are removed tend to happen early in the Post Lifecycle. This leads to small sample bias: we must ensure that a Post has at least 20 total Likes before making a decision.

Business Finding: The database was trunctated at 200 rows. This situation needs to be rectified IMMEDIATELY.

## Limitations and Future Improvements

One improvement was already identified: Posts should be looked at within the context of their Lifecycle.

In other words, the Removal rate should look at:
- The number of New Posts
- The Number of New Likes
- the removal rate of Likes within a Post, after 10 Likes or after 90 days of existence.
                ~ this will remove the "early lifecycle" bias

Other limitations include limited information on the nature of the Removals:
- It's not quite clear what Spam Detected means
- It's not quite clear what a Policy Violation is

## VIDEO PRESENTATION

## HOW TO RUN IT






