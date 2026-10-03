#Сколько пользователей зарегистрировалось в 2024 году?
SELECT
	COUNT(*) AS count_2024
FROM users
WHERE YEAR(registration_date) = 2024;

#Сколько пользователей из каждой страны?
SELECT
	country,
	COUNT(*) AS count_users
FROM users
GROUP BY country;

#Средняя длительность просмотра фильма пользователями из США
SELECT
	ROUND(AVG(v.watch_time_min), 1) AS avg_time_min
FROM views v
INNER JOIN users u ON v.user_id = u.user_id
WHERE u.country = 'USA';

#Определите 5 фильмов с наименьшим количеством уникальных зрителей
SELECT
	movie_id,
    COUNT(DISTINCT(user_id)) AS count_users
FROM views
GROUP BY movie_id
ORDER BY count_users ASC
LIMIT 5;

#Подсчитайте месячную выручку от подписок за 2024 год
SELECT
	DATE_FORMAT(start_date, '%Y-%m') AS period,
	SUM(price) AS sum_price
FROM subscriptions
WHERE YEAR(start_date) = 2024
GROUP BY period;

#Для каждого пользователя найдите дату его последнего просмотра
SELECT
	v.user_id,
    MAX(v.view_date) AS max_date
FROM views v
LEFT JOIN users u ON v.user_id = u.user_id
GROUP BY user_id;