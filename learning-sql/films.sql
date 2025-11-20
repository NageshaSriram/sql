select * from movies;

-- case sensitive 
select * from movies where title like 'Grumpie%' COLLATE utf8mb4_bin;	

-- escape char
select * from movies where title like '%#%%' ESCAPE '#';  -- '#' can be anything, if '/' usinf escape should be '//'

select * from movies where title not like '%19__%';

select * from movies where genres like 'Children_' and title like '%2010%';

-- RLIKE or REGEXP
select * from movies where title RLIKE '^F';
select * from movies where title like 'F%';

-- Match strings containing any digit
select * from movies where title not RLIKE '[0-9]';

-- Match strings ending with 
select char_length(title) from movies where title RLIKE 'Moran$' COLLATE utf8mb4_bin;

-- length of charactor
select char_length(title) from movies where title RLIKE 'Moran$';
select character_length(title) from movies where title RLIKE 'Moran$';

-- Match exactly 3-letter words
select * from movies where title RLIKE '^.{3}$';

-- Match names starting with A/B/C
select * from movies where title RLIKE '^[ABC]'; -- case sensitive

SELECT * FROM movies WHERE title  RLIKE '[aeiou]';
-- Matches any name containing a vowel

-- Match strings without vowels
SELECT * FROM movies WHERE title RLIKE '^[^aeiouAEIOU]+$';
-- Matches: "TV", "NYPD", not "USA", "ICE"

-- Match exactly 3 digits
select * from movies where title RLIKE 'Irwin & Fran{1}';

-- Match at least 2 letters
SELECT * FROM movies WHERE title RLIKE '[A-Za-z]{2,}';

-- Match 5 to 7 characters
SELECT * FROM movies WHERE title RLIKE '^.{5,7}$'; -- don't give space between {5,7}

SELECT * FROM movies WHERE title RLIKE '[0-9]{3,10}$';

select * from movies where title RLIKE '\\(2000\\)$'; -- to escape use '\\'

Match valid email format (simple)
SELECT email FROM users
WHERE email RLIKE '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$';


-- Match Indian phone numbers
SELECT phone FROM contacts
WHERE phone RLIKE '^(\+91)?[6-9][0-9]{9}$';
-- Matches: "9876543210", "+919876543210"

/*

| Symbol  | Meaning                    | Example  | Matches                   |
| ------- | -------------------------- | -------- | ------------------------- |
| `*`     | **0 or more** times        | `a*`     | "", "a", "aa", "aaa", ... |
| `+`     | **1 or more** times        | `a+`     | "a", "aa", "aaa", ...     |
| `?`     | **0 or 1** time (optional) | `a?`     | "", "a"                   |
| `{n}`   | **Exactly n** times        | `a{3}`   | "aaa"                     |
| `{n,}`  | **At least n** times       | `a{2,}`  | "aa", "aaa", "aaaa", ...  |
| `{n,m}` | **Between n and m** times  | `a{1,3}` | "a", "aa", "aaa"          |

*/
