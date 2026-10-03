
DROP DATABASE IF EXISTS streamy_db;
CREATE DATABASE streamy_db;
USE streamy_db;


CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    registration_date DATE,
    country VARCHAR(50)
);

CREATE TABLE subscriptions (
    sub_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    start_date DATE,
    end_date DATE,
    price DECIMAL(6,2),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200),
    genre VARCHAR(50),
    release_year INT,
    duration_min INT
);

CREATE TABLE views (
    view_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    movie_id INT,
    view_date DATE,
    watch_time_min INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);


INSERT INTO users (name, registration_date, country)
SELECT 
  CONCAT('User_', LPAD(t.n, 4, '0')),
  DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 700) DAY),
  ELT(FLOOR(1 + RAND() * 6), 'USA', 'UK', 'Germany', 'France', 'Canada', 'Australia')
FROM (
  SELECT @row := @row + 1 AS n
  FROM 
    (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 
     UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
    (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 
     UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
    (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 
     UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c,
    (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 
     UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) d,
    (SELECT @row := 0) r
) t
LIMIT 1000;


INSERT INTO users (name, registration_date, country)
SELECT 
    CONCAT('User_new_', LPAD(t.n, 3, '0')),
    DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 700) DAY),
    ELT(FLOOR(1 + RAND() * 6), 'USA', 'UK', 'Germany', 'France', 'Canada', 'Australia')
FROM (
    SELECT @row2 := @row2 + 1 AS n
    FROM 
        (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 
         UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
        (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 
         UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
        (SELECT @row2 := 0) r
) t
LIMIT 97;


INSERT INTO movies (title, genre, release_year, duration_min)
SELECT 
  CONCAT('Movie_', LPAD(t.n, 3, '0')),
  ELT(FLOOR(1 + RAND() * 6), 'Action', 'Drama', 'Sci-Fi', 'Comedy', 'Animation', 'Crime'),
  FLOOR(1990 + RAND() * 35),
  FLOOR(80 + RAND() * 80)
FROM (
  SELECT @m := @m + 1 AS n
  FROM 
    (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 
     UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
    (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 
     UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
    (SELECT @m := 0) r
) t
LIMIT 100;


INSERT INTO subscriptions (user_id, start_date, end_date, price)
SELECT 
  user_id,
  DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 400) DAY),
  DATE_ADD('2023-06-01', INTERVAL FLOOR(RAND() * 700) DAY),
  ELT(FLOOR(1 + (RAND() * 3)), 9.99, 12.99, 14.99)
FROM users;


SET @min_user := (SELECT MIN(user_id) FROM users);
SET @max_user := (SELECT MAX(user_id) FROM users) - 97; 
SET @min_movie := (SELECT MIN(movie_id) FROM movies);
SET @max_movie := (SELECT MAX(movie_id) FROM movies);

INSERT INTO views (user_id, movie_id, view_date, watch_time_min)
SELECT 
    u.user_id,
    FLOOR(@min_movie + RAND() * (@max_movie - @min_movie + 1)),
    DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND() * 300) DAY),
    FLOOR(30 + RAND() * 180)
FROM users u
WHERE u.user_id <= @max_user
ORDER BY RAND()
LIMIT 10000;


SELECT COUNT(*) AS total_users FROM users;       -- 1097
SELECT COUNT(*) AS total_movies FROM movies;     -- 100
SELECT COUNT(*) AS total_subscriptions FROM subscriptions;
SELECT COUNT(*) AS total_views FROM views;       -- 10000


SELECT u.user_id, u.name
FROM users u
LEFT JOIN views v ON u.user_id = v.user_id
WHERE v.user_id IS NULL
ORDER BY u.user_id DESC
LIMIT 10;
