5.1.
-----------------------------------------------------------------------------------------------------------------------------------------------------
**Q1. What feature or report on your platform could use the three-table join from Question 1? What information would it display?**

The 3-table Join shows “Which User liked Which Post, and When”.

The interesting thing is we can now take different attributes from different tables. For example
  * I also included the POSTED_ON date and the LIKED_AT timestamp
      * We can now compute the time distance between the POST and the LIKE, and generate a query using the MIN asking “what’s the quickest each post was liked”.

  * I included the user SIGN_UP date and the post LIKED_AT
      * We can now ask something like “how quickly after sign-up did this user start to like?” And from that we can say something like “on average how long does it take for a user to do their first like”?

  * I included the AUTHOR_COUNTRY and the LIKER_COUNTRY
      * So we can ask “what % of LIKES come from POSTS from the same country?”

Summary: by including attributes that are specific to either the PRODUCER (the post), the EVENT (the like) and the ACTOR (the user) in the 3-table joins, we can start to ask interesting time-difference questions (“how long between when a post was posted and it’s first like?”) or entity-difference questions (“has this user ever liked a post not from their home country?”)

**Q2. Why is the junction table important for answering Question 2? What would make this analysis more difficult without it?** 

The junction table is necessary because some POSTS have multiple HASHTAGS associated with them. In other words, this is a “one to many relationship” and you need a junction table to manage that.
The alternative would be to have an “enum” as a value in a column, which is very cumbersome:
  * “travel; tech”
  * “food”
  * “food; travel”
  * “travel; food”
        *  We would need to parse this out on every join, which is not great


5.2.
-----------------------------------------------------------------------------------------------------------------------------------------------------

**PART A:**

The INNER JOIN missed Posts #14 and #15. 2 posts were missing

That’s because there were no LIKES for those points, and the INNER JOIN only returns results if there are LIKES.

**PART B:**

Confirming that the RIGHT JOIN also returns posts 1 through 13, excluding posts 14 and 15.

A full outer join reveals rows that:
  * are missing from the left table, AND
  * tables that are missing from the right table

In other words, if there were unattributed or orphaned LIKES, the FULL OUTER JOIN would surface them. The Full Outer Join can also surface the users with no LIKES, but by using the FULL OUTER you can get both the Users without Likes and the Likes without Users. Any missing data or missing linkages are “scooped up”.

**PART C:**

Both NOT EXISTS and EXCEPT return Posts #14 and #15.

They operate slightly differently:
  * EXCEPT is a set operator. It looks at one ensemble, and “subtracts out the elements” of the second ensemble to give you what remains: what was in A but not in B. (What Posts are in the Post table but not in the LIKES table).
  * NOT EXISTS is a correlated subquery. For each item in the outer query, it will loop through the inner query. If there are any EXISTS (NOT EXIST is FALSE) it will not return that value.


**WRITE-UP or SUMMARY** 

1. Which producers were excluded by the inner join? Report their identifiers.

Posts #14 and #15 were excluded from the inner join.


2. What does it mean when a producer has no events? What are some possible explanations?

A producer that has no events means a social media POST has no LIKES.

Possible explanations include:
  * The user who posted “has no friends”, so there is no one to like it.
  * The Post has been removed.
  * The POST table has an attribute called “is_visible”. If a post is not liked, it could be because it’s not visible.
  * We also noticed that the LIKES table was sort ordered and the row numbers ended at 200. It’s very improbably that there are exactly 200 likes in the database. More likely that table was truncated, leading to incorrect results.


3. How could a report based only on an inner join give leadership an incomplete picture of the platform?

The INNER JOIN report would not surface posts that have no likes. It’s important for management to understand if there’s widespread engagement with the platform, or if MANY OTHER POSTS also have no likes.


4. Why might leadership want to identify producers who have never been active?

Leadership might want to understand why those specific POSTS have not been liked, to identify if there are any issues with the platform. Maybe the POSTS are just too fresh, maybe the POSTS have been deactivated. Maybe the Platform is faulty. Or maybe the Posts themselves are objectionable, which is why they have no likes.


5. What action could leadership take based on these findings?

Leadership should investigate POSTS 14 and 15. Why specifically did those posts – and those posts ONLY – not generate any likes.

(When we sort the data on POST_ID and LIKE_ID, it’s clear that the data is truncated at 200 rows. The likes stop at post #13. This suggests a bad load of the data into the platform instead of a “business issue”.)

5.3.
-----------------------------------------------------------------------------------------------------------------------------------------------------

**Part A**

Cross-Join the Posts table with the Hashtag table.
  * Posts has 15 row
  * There are 5 Hashtag mappings
  * The Cross-Join indeed has 75 rows = 15 x 5

This query would be useful to create a dataframe for data science models. By cross-joining each Post with the Hashtags, you now have a “grid” or “matrix” which can be used for heatmaps, correlation matrices, or visual representations.


**Part B**

1. Capture the full execution plan.
 
"Sort  (cost=35.98..36.48 rows=200 width=1266)"

"  Sort Key: users.user_name, likes.like_id"

"  ->  Nested Loop  (cost=12.40..28.34 rows=200 width=1266)"

"        ->  Hash Join  (cost=12.25..17.80 rows=200 width=798)"

"              Hash Cond: (likes.user_id = users.user_id)"

"              ->  Seq Scan on likes  (cost=0.00..5.00 rows=200 width=24)"

"              ->  Hash  (cost=11.00..11.00 rows=100 width=782)"

"                    ->  Seq Scan on users  (cost=0.00..11.00 rows=100 width=782)"

"        ->  Memoize  (cost=0.15..0.41 rows=1 width=444)"

"              Cache Key: likes.post_id"

"              Cache Mode: logical"

"              ->  Index Scan using posts_pkey on posts  (cost=0.14..0.40 rows=1 width=444)"

"                    Index Cond: (post_id = likes.post_id)"

2. Identify the join algorithm or algorithms used, such as Nested Loop, Hash Join, or Merge Join.

The query tool used 2 different algorithms:
  * Nested Loop for Posts
  * Hash Map for the Users


3. Explain why PostgreSQL may have selected these algorithms, considering table sizes and available indexes.

We are scanning 3 tables: Likes, Users and Posts. It is efficient to create Hash Maps for the Users since they appear in 2 tables and can be re-used.

There are no indices available to the query tool, so Merge Join (sorted join) no longer is an option.

Since the number of Posts is relatively limited (15) then doing a Nested Loop on the Posts is completely OK.


4. Predict which part of the query might become less efficient as the dataset grows.

If the number of Posts were to grow, the Nested Loop on the Post_ID would no longer be efficient.


WRITE-UP or SUMMARY
-----------------------------------------------------------------------------------------------------------------------------------------------------

1. Give an example of when a Cartesian product could be useful on your platform, or explain why you would not need one.

Cartesian products are useful if you want to build “grids”. Cross-joining Posts x Hashtags provides a dataframe where each Post has a Hashtag. We can fill that grid in with the counts, and create hashmaps.

The Cross-Join result set returns the grid as a bunch of rows; once the hashtags are transposed as column values, we can continue to do analytics like correlation matrices or other dimensionality reduction techniques.


2. Which join algorithms did PostgreSQL choose for your query?

It chose a combination of Nested and Hash Maps.


3. What information in the execution plan helps explain those choices?

The query tool doesn’t provide any comparative metrics or explanations. For example it does not articulate “there were no indexes so sorting becomes inefficient, we’re not going to use a Merge Join”. In other words, it does not explain WHY it is making that decision.

However, each step has clearly articulated costs, which is helpful.


4. Why is it useful to understand the selected join algorithms?
5. What changes to the data or database might make another join algorithm more appropriate?

It is useful because you can understand the computational complexity of your request. Nested Loops are computationally the most inefficient.

For an INNER JOIN on a subset of data using a WHERE clause, the Nested Loop is probably also the most efficient algorithm. However, if you are running an Inner Join on equality and the query analyzer is still deciding to use a Nested Loop, that means that you have work to do:
implementing primary keys which generate indexes
implementing foreign keys which generate indexes on the data
or simply indexing columns so that the Merge Join becomes feasible (Merge Join = a “sorted join”, which is efficient and enabled by sorting and indexing the data)


FINAL REFLECTION
-----------------------------------------------------------------------------------------------------------------------------------------------------

The current data schema does not contain any indexes. It is possible that the query analyzer is then forced to use either Nested Loops or Hash Maps, instead of being able to leverage the indexes in a Merge Join.

In other words, we should be indexing the data.

Furthermore, the number of Users and Posts is relatively small, allowing Nested Loops to be usable. As the database grows, it’s possible that Nested Loops would no longer be feasible over millions of users or millions of posts, forcing the algorithm into Hash Map joins.

Finally, since we are using equi-joins, we can leverage Hash Maps which are efficient. If we were doing a non-equi join AND we did not have indexes, the query tool would be forced to use Nested Loops which is the most inefficient over large datasets.


