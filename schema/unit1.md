##### Task 1.4: Write Up Your Reasoning and Modelling Justification

**Cover your key design decisions**

- We want to model each major part of the platform:
  - Users
  - Posts created by users
  - Likes made by users on posts
  - Hashtags associated with posts
- We also need a fact-style table that records each hashtag appearing on each post.
- Finally, we want to analyze categories of hashtags, so we create a mapping of hashtags to categories in a table called `hashtag_catalogue`.

### Primary Keys

Each table has a Primary Key or Composite Primary Key to ensure uniqueness and consistency across the platform.

- **Users**
  - `user_id` is the Primary Key.
  - `user_id` is also referenced as a Foreign Key in other tables.

- **Posts**
  - `post_id` is the Primary Key.
  - `post_id` is also referenced as a Foreign Key in other tables.

- **Likes**
  - The Composite Primary Key is (`user_id`, `post_id`).
  - This ensures that each user can only like a particular post once.
  - This behavior is enforced at the database level.
  - The assumption that a post can only be liked once by a particular user is therefore a business rule imposed by the schema.

- **Hashtags**
  - The Composite Primary Key is (`post_id`, `hashtag`).
  - This ensures that the same hashtag can only appear once for a particular post.
  - There is still some question about how repeated hashtags may appear in the user-facing post itself, but analytically the database will store the post/hashtag combination only once.

- **Hashtag Catalogue**
  - The Composite Primary Key is (`hashtag`, `category`).
  - A hashtag can belong to multiple categories.
  - A category can contain multiple hashtags.
  - However, the same (`hashtag`, `category`) pair cannot be duplicated.

### Rules Enforced Through the Schema

- We enforce uniqueness of Likes for each user/post combination.
- We enforce uniqueness of Hashtags within each Post.
- We enforce uniqueness of (`hashtag`, `category`) pairs.
- We guarantee that every Post has a valid `user_id`.
- We guarantee that every Post has a unique `post_id`.

### ON DELETE Behavior

- For both `user_id` and `post_id`, we use `RESTRICT`.
  - If a user deletes or deactivates an account, the related historical records remain in the database.
  - If a user deletes a post, its historical relationships also remain.
- Instead of physically deleting these records:
  - Users can be marked as deactivated.
  - Posts can be marked as deleted.

### Requirements Left Open

- It is not yet clear whether `activity_flag` in the `posts` table should be defined as NOT NULL.
- It is also not yet clear whether `metric` should use the DOUBLE data type.
  - Depending on the eventual purpose of the metric, it may later be more appropriate to define it as an INT or another numeric type.

### Decisions That Could Have Been Made Differently

- **ON DELETE behavior for Users**
  - `CASCADE` could have been used.
    - In that case, deleting a user would also delete all related posts, likes, and other dependent records.
    - This could be reasonable for privacy purposes.
    - However, for analytics and historical reporting, retaining the records may be preferable.
  - `SET NULL` could also have been considered.
    - This could remove the direct relationship to the user while keeping other records.
    - However, it would require the Foreign Key column to allow NULL values.

- **ON DELETE behavior for Posts**
  - `SET NULL` does not make much sense for dependent Likes and Hashtags because it would leave records without a valid associated Post.
  - `CASCADE` would be a reasonable alternative.
    - Deleting a Post would automatically delete its associated Likes and Hashtag records.

- **Hashtag Catalogue design**
  - The structure of the catalogue table could likely be designed differently.
  - A separate Category table with a category identifier could be introduced later.
  - The exact structure of this mapping is partly a modelling and normalization decision.
