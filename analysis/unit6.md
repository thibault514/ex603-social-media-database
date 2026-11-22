
## SECTION 1
## Write a question that needs each row shown next to its group’s average. Explain why the group average alone (GROUP BY) cannot answer it.

A question would be: is this specific event something different or unexpected for this Post?
By seeing each row, we can understand whether THAT SPECIFIC removal is anomalous.
- A removal with a low group average = that's anomalous
- A removal when there is a high group average = that's expected.

GROUP BY Collapses the data into a single row.

## Ranking is never neutral: someone is being ordered, and tie handling decides who counts as equal.
## Name a platform feature that would use your ranking, and explain which of the three functions it should use and why.

We might want to have a ranking of the "BEST" posts, aka the ones with the lowest removal of Likes.

In which case, if we had a TOP 10, we would want to use EITHER Row Number or Dense Rank.
  * using Rank might only give us "8 or 9" posts instead of the 10 we wanted.
  * Dense Rank would give us "at least the Top 10"
  * Row Number would give us exactly 10, but we might drop 1 or many rows if there was a tie (probably OK, but better to have Dense Rank)



