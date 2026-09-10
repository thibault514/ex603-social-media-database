Task 1.3: Specify integrity constraints
Write the constraints that protect your data. For each foreign key, state and justify the ON DELETE behavior.


The constraints that protect my data are:
Users
User ID is the Primary Key. Integer, Not Null.
So this ensures basic consistency of behavior in the platform…
Specifying the display_name to NOT NULL means everyone needs a display name
Posts
Post ID must be a positive integer, NOT NULL
A standard primary key
There is a foreign Key on User_ID and it’s NOT NULL
Every post needs a user.
That user needs to be a valid user_id
The Title is NOT NULL
Every post needs a Title
The Activity is a Boolean; right now I don’t know if it needs a NOT NULL constraint
The Metric is a Double, I don’t know if it needs a NOT NULL constraint right now…
Posts can be DELETED, a BOOLEAN. Can be NULL.
Likes
User_ID is a Foreign Key
Every like comes from a valid user
Post ID is a Foreign Key
Every like has to come from an existing post
Timestamp is constrained to the TIMESTAMP metric, so no junk gets in there
Dwell_ms is an INT (time in milliseconds can be an integer)
The Primary Key is User_ID + Post_ID
ensuring the uniqueness of a Like event (a user can like a post just once)
Hashtags:
Refer to a Post Id that is a Foreign Key (guarantees existence)
Hashtags are not null
Composite Primary Key of Post ID + the Hashtag
This guarantees that the database stores only 1 Hashtag per Post
Hashtag catalogue > the point of this table is to classify Hashtags into groupings
Hashtags are VARCHAR and Not Null
Categories are VARCHAR and also NOT NULL
The primary key is a Composite Primary Key of Hashtag + the Category
This ensures that each “wordy hashtag” and Category combo happens only once
But that “wordy hashtags” can still belong to multiple Categories


On Delete Behaviors….
User ID is an FK on:
Posts
Likes
This should be set to RESTRICT
We manage deletions of Accounts by setting the account to DEACTIVATED (deactivated = True)
Post ID is an FK on:
Posts
Post_Hashtags
Likes
Setting this to Restrict means that users can’t delete posts…!
We do not want to pick the NULL option either because then we lose history
Deleting these records is dealt with through the DELETED flag
