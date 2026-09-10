##### Task 1.3: Specify integrity constraints

*Write the constraints that protect your data. For each foreign key, state and justify the `ON DELETE` behavior.*

The constraints that protect my data are:

- **Users**
  - `user_id` is the Primary Key. Integer, NOT NULL.
    - This ensures basic consistency of behavior in the platform.
  - Specifying `display_name` as NOT NULL means everyone needs a display name.

- **Posts**
  - `post_id` must be a positive integer, NOT NULL.
    - A standard primary key.
  - There is a Foreign Key on `user_id`, and it is NOT NULL.
    - Every post needs a user.
      - That user needs to be a valid `user_id`.
  - `post_title` is NOT NULL.
    - Every post needs a title.
  - `activity_flag` is a BOOLEAN; right now I don't know if it needs a NOT NULL constraint.
  - `metric` is a DOUBLE; I don't know if it needs a NOT NULL constraint right now.
  - Posts can be deleted using `deleted`, a BOOLEAN. It can be NULL.

- **Likes**
  - `user_id` is a Foreign Key.
    - Every like comes from a valid user.
  - `post_id` is a Foreign Key.
    - Every like has to come from an existing post.
  - `timestamp` is constrained to the TIMESTAMP type, so no junk gets in there.
  - `dwell_ms` is an INT.
    - Time in milliseconds can be represented as an integer.
  - The Primary Key is `user_id` + `post_id`.
    - This ensures the uniqueness of a Like event.
    - A user can like a post only once.

- **Hashtags**
  - `post_id` is a Foreign Key.
    - This guarantees that the referenced post exists.
  - `hashtag` is NOT NULL.
  - The Composite Primary Key is `post_id` + `hashtag`.
    - This guarantees that the database stores only one instance of a particular hashtag per post.

- **Hashtag Catalogue**
  - The point of this table is to classify hashtags into groupings.
  - `hashtag` is VARCHAR and NOT NULL.
  - `category` is VARCHAR and NOT NULL.
  - The Primary Key is a Composite Primary Key of `hashtag` + `category`.
    - This ensures that each hashtag and category combination occurs only once.
    - A hashtag can still belong to multiple categories.

### ON DELETE Behaviors

- `user_id` is a Foreign Key in:
  - `posts`
  - `likes`
    - This should be set to `RESTRICT`.
    - We manage deletion of accounts by setting the account to deactivated (`deactivated = TRUE`).

- `post_id` is a Foreign Key in:
  - `post_hashtags`
  - `likes`
    - Setting this to `RESTRICT` means that users cannot physically delete posts that are referenced by these tables.
    - We do not want to use `SET NULL` because then we would lose the relationship to the original post.
    - Deletion is instead handled through the `deleted` flag.
