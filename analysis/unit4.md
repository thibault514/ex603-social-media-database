** SECTION 4.1

1. The average failure rate is 17%.

2. The interesting thing is that there are about 3-4 failures for every post, invariant to the number of total likes

It's also interesting that the Removals are more likely to occur SOONER rather than LATER in a post's lifecycle...

3. The minimum threshold is 15. In other words, a post cannot be removed because of an average Removal Rate of it's Likes until it has at least 15 likes.

 That's because of 2 things: 
        a. as noted above, there seems to be a baseline of about 3-4 removals per post, regardless of the number of likes.
           So we want to have at least 15 posts so that 4/15 = 26%
        b. That threshold ensures that we keep 75% of the LIkes in the system. If we moved the threshold down, we would be eliminating a good chunk of the platform's data. 

4. I looked at 2 dimensions: USERS and Countries

There does not seem to be a single source of Bad Likes coming from specific countries. (In other words, in social media or other types of digital advertising, there can be a lot of fraud. That fraud might come from bad actors located in specific parts of the world). There is not a single country that is a source of bad likes.

Also, there don't seem to be Users who generate a lot of bad Likes. In other words, for the users that had 10+ likes, none had more than 3 of their likes removed.

** SECTION 4.2

A) state the two questions your conditional aggregation answers side by side:

The conditional aggregation shows the total number of Likes per post and the number of Removals, for a specific Post.

The advantage of combining the data is that we can now create a Removal Rate per post.


B) name the reader who needs subtotals rather than detail rows, and say what decision the grand total supports that the group rows do not:

Regional managers need the subtotal by Country in order to understand if the users from their market are behaving "legitimately". Each row or subtotal is of interest to a different regional manager.

A 17% removal rate seems high, but the bad Likes are not coming from a specific market. (no one market can be pinpointed as the source of bad actors)

C) state the question the pipeline answers:

The pipeline answers which Posts meet the minimum quality threshold.

** Reflection

Conditional aggregation is much more flexible and allows the user to compare row-level metrics more easily vs. the aggregate values. Use the Case Statement with 0/1 Values also allows easier summing and average, and is more naturally embedded in the query.

As the number of rows gets bigger, running the same “avg” queries across millions of rows of data, then fetching the same millions of rows of data to build quasi-aggregates is inefficient. Using conditional aggregation allows the user to compute metrics in a single, more computationally efficient, pass.

It is also a more flexible structure, as the data evolves and the average evolves, having one pass at the data means that the quality thresholds can also be dynamic. (instead of being recomputed in a separate query)
