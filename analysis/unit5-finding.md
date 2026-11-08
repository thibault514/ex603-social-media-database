Memo: Data Corruption Issues

Date: 11/8/2026

Memo To: Paul McIntyre, COO

From: Charles Thibault, Director Data Analytics

Subject: Possible Corruption of our “Likes” table


**Introduction**

We believe that the core table associating user Likes to social media Posts has been corrupted.

**Background**

The Performance Team sends weekly and monthly summaries of the business performance of the platform. The reports detail:
  * How many unique users Liked a Social Media Post
  * How many Posts were Liked (that week or that month)
      * How many Likes came from pre-existing Posts
      * How many Likes came from New Posts, aka the New Post Velocity

Furthermore, the Monetization teams directs Ads to Posts with the most Likes:
  * Our Monetization Platforms depend on Like data being correct

**Issue Detected**

The Performance and Monetization teams correctly ask: “Which Users generate Posts that are Liked? Which Posts generate the most Likes?”

They did not ask: “Which Posts have not yet generated any Likes?”

By examining the data, we discovered that 13% of the Posts did not have any associated Likes:
  * Posts #14 and #15 did not have any Likes.

Furthermore, when inspecting the database containing the Likes, we discovered that the data was sorted by Post_ID and that the table was truncated at 200 rows. We believe that this signals an incomplete data export.

Many data tools have default “number of rows” in a result set, and we believe that the data was corrupted as we updated our Oracle database instances.

**Recommendation**

The technology department needs to audit the recent data migration, as we believe it was corrupted.
