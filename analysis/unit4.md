
Other questions to the assignment:

Write up For Part A, state the two questions your conditional aggregation answers side by side. 

The conditional aggregation shows the total number of Likes per post and the number of Removals, for a specific Post.

For Part B, name the reader who needs subtotals rather than detail rows, and say what decision the grand total supports that the group rows do not:

Regional managers need the subtotal by Country in order to understand if the users from their market are behaving "legitimately" A 17% removal rate seems high, but the bad Likes are not coming from a specific market. (no one market can be pinpointed as the source of bad actors)

For Part C, state the question the pipeline answers.

The pipeline answers which Posts meet the minimum quality threshold.

Reflection

Conditional aggregation is much more flexible and allows the user to compare row-level metrics more easily to aggregate values. Use the Case Statement with 0/1 Values also allows easier summing and average, and is more naturally embedded in the query.

As the number of rows gets bigger, running the same “avg” queries across millions of rows of data, then fetching the same millions of rows of data to build quasi-aggregates is inefficient. Using conditional aggregation allows the user to compute metrics in a single, more computationally efficient, pass.
