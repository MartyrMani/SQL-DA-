-- Выведите сколько пользователей добавили книгу 'Coraline', 
-- сколько пользователей прослушало больше 10%. 
SELECT
	a.title,
	COUNT(DISTINCT ac.user_id) AS users_added,
	COUNT(DISTINCT 
			CASE
				WHEN ac.progress > a.duration * 0.1 THEN ac.user_id
			END) AS users_listened_more_10_percent
FROM audiobooks a
INNER JOIN audio_cards ac ON ac.audiobook_uuid = a.uuid
WHERE a.title = 'Coraline'
GROUP BY a.title;

-- По каждой операционной системе и названию книги 
-- выведите количество пользователей, сумму прослушивания в часах, 
-- не учитывая тестовые прослушивания. 
SELECT
	l.os_name,
	a.title,
	COUNT(DISTINCT l.user_id) AS users_count,
	ROUND(SUM(l.position_to - l.position_from) / 3600.0, 2) AS listeting_hours
FROM listenings l
INNER JOIN audiobooks a ON l.audiobook_uuid = a.uuid
WHERE l.is_test = 0
GROUP BY l.os_name, a.title
ORDER BY l.os_name, a.title;

-- Найдите книгу, которую слушает больше всего людей. 
SELECT
	a.title,
	COUNT(l.user_id) AS users_count
FROM listenings l
INNER JOIN audiobooks a ON l.audiobook_uuid = a.uuid
GROUP BY a.title
ORDER BY users_count DESC
LIMIT 1;

-- Найдите книгу, которую чаще всего дослушивают до конца.
SELECT
	a.title,
	COUNT(DISTINCT ac.user_id) AS finished_users
FROM audio_cards ac
INNER JOIN audiobooks a ON ac.audiobook_uuid = a.uuid
WHERE ac.progress >= a.duration
GROUP BY a.title
ORDER BY finished_users DESC
LIMIT 1;