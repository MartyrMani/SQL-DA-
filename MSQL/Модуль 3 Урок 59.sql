#Нужно вывести Регион, ФИО, Пол(вывести словами), Кол-во услуги, сгрупировать по регионам, dt_reg с января по май 2024 года.
SELECT 
	r.name_ru AS Region,
	CONCAT(p.last_name, ' ', p.first_name, ' ', p.second_name) AS Full_Name,
    CASE
		WHEN p.gender = 0 THEN 'Мужчина'
        WHEN p.gender = 1 THEN 'Женщина'
        ELSE 'Не указано'
    END AS gender,
    COUNT(s.id) AS Number_Of_Service
FROM patients p
INNER JOIN service s ON p.code_service = s.code
INNER JOIN region r ON p.Id_region = r.id
WHERE dt_reg BETWEEN '2024-01-01' AND '2024-05-31'
GROUP BY Region, Full_Name, gender;

#Сколько записей из t1 имеются в t2 по  IIN?
SELECT
	t1.IIN,
	COUNT(*) AS Amount
FROM table1 t1
INNER JOIN table2 t2 ON t1.IIN = t2.IIN
GROUP BY IIN;

#В каждой из таблиц сколько ИИН дублируются и по сколько раз?
SELECT
	IIN,
    COUNT(*) AS Amount
FROM table1
GROUP BY IIN
HAVING COUNT(*) > 1;

SELECT
	IIN,
    COUNT(*) AS Amount
FROM table2
GROUP BY IIN
HAVING COUNT(*) > 1;

#Из Таблицы t2 вытащите людей с возрастом от 30 до 70 лет с указанием даты рождения и возраста на сегодняшний день.
SELECT
	IIN,
	birth_date,
    TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS Age
FROM table2
WHERE TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) BETWEEN 30 AND 70;