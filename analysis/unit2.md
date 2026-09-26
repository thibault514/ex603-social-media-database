
> TABLE: users
    - The Primary key of course are the Users
    - Important feature: "deactivated" BOOL
    - Foreign Key: no Foreign Keys because this is the highest possible table; it does not depend on anyone else
    - ON DELETE: no ON Delete because no Foreign Key

> TABLE: posts
    - The Primary Key is post_id, an analytical post (not a composite of the user and the title; the title can change)
    - Important feature: a "deleted" BOOL if a user deletes a post
    - Foreign Key: on user_id
    - ON DELETE: No On Delete, because instead i have a "deactivated" attribute in the users table

      NOTE: I do NOT want the platform to allow the removal or deletion of a "producer" or user.
        ~ instead, we have a flag that marks the user as "deactivated".
        ~ this way, the POST is still retained in the database. We can choose to no longer display the post, but we retain the customer's data

> TABLE: likes
    - Primary key: composite key between the user and post id. This ensures "one like" per post
    - Foreign Keys: to posts and users.
    - ON DELETE: I do have a CASCADE here. If the post is deleted, delete the likes. We don't want orphaned likes

      NOTE: here I have an on DELETE CASCADE because orphaned likes are no good. However, I have a "deleted BOOL" on POSTS so that if a user deletes posts, the history is retained
        ~ that's because I still want to know which users liked which posts, even if those posts might have been deleted from the platform. Data is key for monetization in social media platforms.

> TABLE: post_hashtags
    - Primary Key: composite of the post_id and the hashtag, ensuring only 1 hashtag per post
    - Foreign Key: to posts
    - On deleted: CASCADE. If a post gets deleted, remove the hashtag associations. Again the preference is to leverage the BOOLEAN attribute on posts, but for European privacy laws for example,
      we should delete all materials associated to that post (if it's really deleted)

> TABLE: hashtag_catalogue
    - Primary Key: we want a mapping of a hashtag to a "category", so let's make that a composite primary key
    - Foreign Key: NO FOREIGN KEYS. There are no dependencies. Even if there is a single post that contains a unique hashtag, and that post gets deleted, we can still "leave the mapping". It's an intelligence that I do not want to lose.

> CHECK CONSTRAINTS
    - there are no CHECK constraints right now
    - probably we will want a set of CHECK constraints on foul language for hashtags... that will become a long list and would probably be better treated in a table
    - we will want a pre-defined set of CATALOGUE values, so that too is a good CHECK constraint. But for now we leave it free-floating
>
> 


      
