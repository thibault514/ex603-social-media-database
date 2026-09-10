Task 1.1: Define the relation schema
For each of the five roles in your theme, write the relation schema: the relation name, its attributes, and the domain of each attribute. State which attribute or attributes form the primary key.

## users

*Start with the users.*

| Attribute      | Domain / Type | Key / Constraint      |
| -------------- | ------------- | --------------------- |
| `user_id`      | INT, positive | PRIMARY KEY, NOT NULL |
| `display_name` | VARCHAR(32)   | NOT NULL              |
| `deactivated`  | BOOLEAN       |                       |

---

## posts

*Users post stuff on social media!*

| Attribute       | Domain / Type        | Key / Constraint              |
| --------------- | -------------------- | ----------------------------- |
| `post_id`       | INT, non-negative    | PRIMARY KEY, NOT NULL         |
| `user_id`       | INT                  | FOREIGN KEY → `users.user_id` |
| `post_title`    | VARCHAR(255)         | NOT NULL                      |
| `activity_flag` | BOOLEAN              |                               |
| `metric`        | DOUBLE, non-negative |                               |
| `deleted`       | BOOLEAN              |                               |

---

## likes

*Likes come from users on specific posts, at specific times.*

| Attribute   | Domain / Type | Key / Constraint                                     |
| ----------- | ------------- | ---------------------------------------------------- |
| `user_id`   | INT           | FOREIGN KEY → `users.user_id`, COMPOSITE PRIMARY KEY |
| `post_id`   | INT           | FOREIGN KEY → `posts.post_id`, COMPOSITE PRIMARY KEY |
| `timestamp` | TIMESTAMP     |                                                      |
| `dwell_ms`  | INT           | NOT NULL                                             |

**Primary Key:** (`user_id`, `post_id`)

This ensures that a user can like a particular post only once.

---

## hashtags

*Stores the hashtags used in each post. Each post can have many hashtags.*

| Attribute | Domain / Type | Key / Constraint                                     |
| --------- | ------------- | ---------------------------------------------------- |
| `post_id` | INT           | FOREIGN KEY → `posts.post_id`, COMPOSITE PRIMARY KEY |
| `hashtag` | VARCHAR(255)  | NOT NULL, COMPOSITE PRIMARY KEY                      |

**Primary Key:** (`post_id`, `hashtag`)

---

## hashtag_catalogue

*Maps individual hashtags such as `#GoGiants` to categories such as `Sports`.*

| Attribute  | Domain / Type | Key / Constraint                |
| ---------- | ------------- | ------------------------------- |
| `hashtag`  | VARCHAR(255)  | NOT NULL, COMPOSITE PRIMARY KEY |
| `category` | VARCHAR(255)  | NOT NULL, COMPOSITE PRIMARY KEY |

**Primary Key:** (`hashtag`, `category`)
