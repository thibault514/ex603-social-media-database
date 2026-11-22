
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

## SECTION 2
## What would a large delta tell someone about your platform, and what should they do about it?

A large increase in the Removal Rate would mean that spammers (or bots) have not infiltrated the system, and that many Likes have been removed because they were spam.
In turn this means that the platform's commercial viability is at risk.

## Why does a running total answer a question that a plain SUM cannot?

The running total gives you the EVOLUTION of failures over time, and allows you to see if the failures are concentrated any specific point in time (using a delta of the cumulative).

Using cumulative also allows you to understand the impact of a specific days removals on the moving or overall average.

## Why did you pick your moving-average window size? A different size tells a different story.

I chose a 30-day window. I first started with a 7-day window, but the data is so sparse that it created volatility. Some 7-day moving averages had 0% removal rate, then it would spike to 30%+.

30-days is short enough to understand if there is something wrong with the platform "right now" without being upward biased because of small sample sizes over a 7-day window.

## What does a gap mean in your platform: a data quality problem, a real stop in activity, or a side effect of how events were recorded? Each needs a different response. Say which one yours is and how you know.

At this point it's unclear. A new like on an old post doesn't really signal anything. If that new like on an old post came from a NEW USER, that would make a lot of sense.

For Post #12, the period of inactivity was followed by legitimate LIKES, so this is just the "nature of the data": Likes are relatively sparse across Posts, and time gaps are normal.
(They are normal unless they are followed by a series of removals).

## RANGE vs. ROWS

If the data is sparse (some days don't have Likes) then you need to use RANGE instead of ROWS. If the data is sparse and you use 7 rows, you might be smoothing over 8 or 9 or 10 days, instead of the 7.
(if you have millions of users and you don't have gaps, then the Row Number will funcationally be the same on the aggregate. But it WON'T at the Post level...!)

## Monthly

Monthly totals approach the aggregate average removal rates.

## SECTION 3:

# Name the feature in your platform that top-N would power. Explain why three is the right number, rather than one or ten.

I selecte the 3-most recent Likes for any post.

This would power the header section of any social media post: Here are the 3 most recent likes! Users can then click on the other users who liked that post, creating engagement.

1 would be too sparse, and would limit the user to only looking up 1 other user. 3 is a good balance. Furthermore, the data is sparse, going back more than 3 would mean "going back further in time" for many posts, and bragging about Likes that are "3 months old" is not a good look!

## What would a large month-over-month change mean in your domain, and what should someone do about it? A number nobody acts on is not a metric.

We should not be so interested in the MoM of the number of Removed Posts.

Rather we should be interested if there is a large difference in the % removal RATE.

A large increase would mean that there is a rapid deteroration of the quality of the social media platform itself.


## REFLECTION

The rolling 30-day moving average of the Removal Rate is impossible to do with a Group By. The Group By would collapse the data per row.

Using the Window Function (esp.Range) we can easily build 7-day, 14-day and 30-day moving averages.

We can also see if the increase in the Removal Rate is due to small sample size issues:
  - an increase of 50% in the removal rate could be because there were only 2 likes on the platform and 1 was removed
  - that's a different situation than if there were 10,000 Likes and 5,000 were removed.
  - In other words, the Window functions also allows us to efficiently do window-over-window sample size

In sum, the window functions allow time series operations not possible with a simple GROUP BY.
