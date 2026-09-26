# ex603-social-media-database

This repo develops the database platform for a Social Media platform, as part of the &lt;Master's of Science in Software Engineering for Artifical Intelligence>

<img width="781" height="500" alt="image" src="https://github.com/user-attachments/assets/b8a18942-d8b9-4e56-89e9-7a0dc66b8692" />

In this repository we:
- define the schema
- discuss the various attribute constraints
- review the behavior of the platform, including ON DELETEs
- and offer a general discussion on the platform design itself

The tables are:
- USERS > a table that contains the user_id, their names, and email address
- POSTS > a table containing each user's posts, including the post's title and it's "deleted" status
- LIKES > a table tracking the 'likes' on a posts
- POST_HASHTAGS > a table that extracts the hashtags present on each post
- HASHTAG_CATALOGUE > a table that maps each #hashtag to a category, so that we can summarize activity on the social platform more effectively, and potentially monetize it for ads
