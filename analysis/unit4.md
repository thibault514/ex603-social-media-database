Summary: We believe bad actors quickly like new posts, biasing the “removal rate” upwards especially for less popular posts. We believe that removing posts based strictly on a “removal rate” without accommodating for sample size and “spammy like timing” will lead to a deterioration of the platform (by removing good content unnecessarily).

We believe the Safety team will want to remove posts from the platform entirely if a high proportion of the Likes on a specific post are flagged for removal. The average removal rate is 17%, and it would not be unreasonable for them to target a 25% “removal rate” as a threshold from removing a post from the platform. In other words, if 25% of the likes on a post are spam, the safety team might believe that the Post itself is spam.

It’s clear from the data that there is a baseline rate of 3 to 4 removed Likes per post. This means the Removal Rate is biased towards posts with a smaller quantity of Likes. In other words, if bad actors uniformly Like all posts across the platforms, then posts will always have a certain number of spammy Likes, and posts with just a few Likes will look “super spammy”.

We have also noticed that Removed Likes are more likely to occur sooner in the Post’s lifecycle. In other words, we believe the bad actors systematically jump onto new posts to Like them. This further exacerbates the small sampling issue, as bad Likes will accumulate much faster than legitimate likes from system users especially in the beginning.

We believe that the proper unit of analysis are the Users who generate spammy likes, not the Posts themselves. In other words, the Safety team should focus on identifying and removing Users whose likes are constantly flagged for removal, instead of removing the posts from legitimate users who might get caught up in a small sample dragnet.

The chart below shows how the Removal Rate climbs quickly in excess of 30% for smaller posts, especially given the baseline of 3 to 4 removed Likes per Post:

If the Safety team does eventually remove Posts for having lots of Likes removed, then it should only do so when the Post has received at least 20 total likes, and the threshold for removal should be 25% (or at the most aggressive 5 percentage points above average).

—---------------

Other questions to the assignment:

Write up For Part A, state the two questions your conditional aggregation answers side by side. The conditional aggregation shows the total number of Likes per post and the number of Removals, for a specific Post.

For Part B, name the reader who needs subtotals rather than detail rows, and say what decision the grand total supports that the group rows do not. Regional managers need the subtotal by Country in order to understand if the users from their market are behaving "legitimately" A 17% removal rate seems high, but the bad Likes are not coming from a specific market. (no one market can be pinpointed as the source of bad actors)

For Part C, state the question the pipeline answers. The pipeline answers which Posts meet the minimum quality threshold.

Reflection

Conditional aggregation is much more flexible and allows the user to compare row-level metrics more easily to aggregate values. Use the Case Statement with 0/1 Values also allows easier summing and average, and is more naturally embedded in the query.

As the number of rows gets bigger, running the same “avg” queries across millions of rows of data, then fetching the same millions of rows of data to build quasi-aggregates is inefficient. Using conditional aggregation allows the user to compute metrics in a single, more computationally efficient, pass.
