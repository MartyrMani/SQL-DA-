#							Задание №1
#Напишите запрос SQL, выводящий одним числом количество уникальных пользователей в этой таблице в период с 2023-11-07 по 2023-11-15.
SELECT
	COUNT(DISTINCT user_id) AS count_users
FROM users
WHERE date BETWEEN '2023-11-07' AND '2023-11-15';

#Определите пользователя, который за весь период посмотрел наибольшее количество объявлений.
SELECT
	user_id
FROM users
ORDER BY view_adverts DESC
LIMIT 1;

#Определите день с наибольшим средним количеством просмотренных рекламных объявлений на пользователя, 
#но учитывайте только дни с более чем 500 уникальными пользователями.
SELECT
	date,
    ROUND(AVG(view_adverts), 2) AS avg_adverts
FROM users
GROUP BY date
HAVING COUNT(DISTINCT user_id) > 500
ORDER BY avg_adverts DESC
LIMIT 1;

#Напишите запрос возвращающий LT (продолжительность присутствия пользователя на сайте) по каждому пользователю. 
#Отсортировать LT по убыванию.
SELECT
	user_id,
    COUNT(DISTINCT date) AS LT
FROM users
GROUP BY user_id
ORDER BY LT DESC;

#Для каждого пользователя подсчитайте среднее количество просмотренной рекламы за день, 
#а затем выясните, у кого самый высокий средний показатель среди тех, кто был активен как минимум в 5 разных дней.
SELECT
	user_id,
    ROUND(AVG(view_adverts), 2) AS avg_adverts
FROM users
GROUP BY user_id
HAVING COUNT(DISTINCT date) >= 5
ORDER BY avg_adverts DESC
LIMIT 1;

#							Задание №2
CREATE DATABASE mini_project;

CREATE TABLE T_TAB1(
ID INT UNIQUE PRIMARY KEY,
Goods_Type VARCHAR(100) NOT NULL,
Quantity INT NOT NULL,
Amount INT NOT NULL,
Seller_Name VARCHAR(100) NOT NULL
);

CREATE TABLE T_TAB2(
ID INT UNIQUE PRIMARY KEY,
Name VARCHAR(100) NOT NULL,
Salary INT NOT NULL,
Age INT NOT NULL
);

INSERT INTO T_TAB1(ID, Goods_Type, Quantity, Amount, Seller_Name)
VALUES
	(1, 'MOBILE PHONE', 2, 400000, 'MIKE'),
	(2, 'KEYBOARD', 1, 10000, 'MIKE'),
	(3, 'MOBILE PHONE', 1, 50000, 'JANE'),
	(4, 'MONITOR', 1, 110000, 'JOE'),
	(5, 'MONITOR', 2, 80000, 'JANE'),
	(6, 'MOBILE PHONE', 1, 130000, 'JOE'),
	(7, 'MOBILE PHONE', 1, 60000, 'ANNA'),
	(8, 'PRINTER', 1, 90000, 'ANNA'),
	(9, 'KEYBOARD', 2, 10000, 'ANNA'),
	(10, 'PRINTER', 1, 80000, 'MIKE');
    
INSERT INTO T_TAB2(ID, Name, Salary, Age)
VALUES
	(1, 'ANNA', 110000, 27),
	(2, 'JANE', 80000, 25),
	(3, 'MIKE', 120000, 25),
	(4, 'JOE', 70000, 24),
	(5, 'RITA', 120000, 29);
    
#Напишите запрос, который вернёт список уникальных категорий товаров (GOODS_TYPE). 
#Какое количество уникальных категорий товаров вернёт запрос?
SELECT
	DISTINCT Goods_Type
FROM T_TAB1;

#Напишите запрос, который вернет суммарное количество и суммарную стоимость проданных мобильных телефонов. 
#Какое суммарное количество и суммарную стоимость вернул запрос?
SELECT
	SUM(Quantity) AS total_quantity,
    SUM(Amount) AS total_amount
FROM T_TAB1
WHERE Goods_Type = 'MOBILE PHONE';

#Напишите запрос, который вернёт список сотрудников с заработной платой > 100000. 
#Какое кол-во сотрудников вернул запрос?
SELECT
	*
FROM T_TAB2
WHERE Salary > 100000;

#Напишите запрос, который вернёт минимальный и максимальный возраст сотрудников, 
#а также минимальную и максимальную заработную плату.
SELECT
	MIN(Age) AS min_age,
    MAX(Age) AS max_age,
    MIN(Salary) AS min_salary,
    MAX(Salary) AS max_salary
FROM T_TAB2;

#Напишите запрос, который вернёт среднее количество проданных клавиатур и принтеров.
SELECT
	ROUND(AVG(Quantity), 2) AS avg_quantity
FROM T_TAB1
WHERE Goods_Type = 'KEYBOARD' OR Goods_Type = 'PRINTER';

#Напишите запрос, который вернёт имя сотрудника и суммарную стоимость проданных им товаров.
SELECT
	Seller_Name,
    SUM(Amount) AS total_amount
FROM T_TAB1
GROUP BY Seller_Name;

#Напишите запрос, который вернёт имя сотрудника, тип товара, 
#кол-во товара, стоимость товара, заработную плату и возраст сотрудника MIKE.
SELECT
	t1.Seller_Name,
    t1.Goods_Type,
    t1.Quantity,
    t1.Amount,
    t2.Salary,
    t2.Age
FROM T_TAB1 t1
INNER JOIN T_TAB2 t2 ON t1.Seller_Name = t2.Name
WHERE t1.Seller_Name = 'MIKE';

#Напишите запрос, который вернёт имя и возраст сотрудника, который ничего не продал. 
#Сколько таких сотрудников?
SELECT
	Name,
    Age
FROM T_TAB2
WHERE Name NOT IN (
	SELECT
		Seller_Name
	FROM T_TAB1
);

#Напишите запрос, который вернёт имя сотрудника и его заработную плату с возрастом меньше 26 лет? 
#Какое количество строк вернул запрос?
SELECT
	Name,
    Salary
FROM T_TAB2
WHERE Age < 26;

#Сколько строк вернёт следующий запрос:
#SELECT * FROM T_TAB1 t
#JOIN T_TAB2 t2 ON t2.name = t.seller_name
#WHERE t2.name = 'RITA';

#Вернёт 0 строк так как RITA ничего не продавала.