**BUSINESS CONTEXT**

Creators on our platform are rewarded for content that generates engagement. For many years, we used the number of impressions as our monetization metric. In order to promote higher quality content, we now use Likes as the primary monetization metric.

On our platform, today:
There are currently 15 posts
Which have generated 200 likes
12 of which have been marked as Spam

**THE SITUATION**

The Trust & Safety team recently published a report stating that our platform has only 22 likes that have not been marked as Spam.

This has created some confusion at the Board of Directors, leading them to believe that our platform is riddled with spam. In fact 5% spam behavior is within the normal KPI range for a social media platform (12/200).

What’s more, their query design has led to a ‘Stop Payment’ to our key creators.

**THE TECHNICAL ERROR**

High quality posts have no ‘removal reason’ identified.

In their query, the Trust & Safety team asked:
Which posts do not have ‘Spam detected’ as a Removal Reason
This is quite logical… good posts don’t have this as a Removal Reason

Rather, the Trust & Safety team should have asked:
Which posts have no recorded Removal Reason

Imagine a list of likes with their removal reasons. Asking which likes don’t have a specific Removal Reason only looks at the subset of likes that have a recorded Removal Reason. When filtering data on a condition, the database only looks at the rows where there is a condition to look at…

The proper queries ask: which likes have no recorded Removal Reason (‘missing’ removal reasons). In other words, look for the rows where there is no condition to look at.

**PAYMENTS ARE AUTHORIZED**

The Data Science team confirms there are 166 legitimate Likes on the platform.

Monetization reports in the Creator platform are correct, and payments to creators should resume.

The Data Science team has debriefed with the Trust & Safety team to correct their reports moving forward.

**SUMMARY**

Frozen payments to Creators should be released.

The faulty query logic has been corrected.
