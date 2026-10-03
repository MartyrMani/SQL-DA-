#Объединение сотрудников и менеджеров: Напишите запрос, 
#который использует UNION для объединения списка всех сотрудников (мужчин) 
#и всех менеджеров (только идентификаторы сотрудников emp_no).
SELECT 
	emp_no
FROM employees
WHERE gender LIKE 'M'
UNION
SELECT
	emp_no
FROM dept_manager;

#Список уникальных должностей и отделов: Создайте запрос, 
#который объединяет уникальные названия должностей из таблицы titles и названия отделов из departments.
SELECT
	DISTINCT title
FROM titles
UNION
SELECT
	DISTINCT dept_name
FROM departments;

#Сотрудники с зарплатами выше и ниже среднего: Напишите запрос, 
#который использует UNION для объединения двух списков: 
#сотрудников с зарплатой выше 60.000 долларов и сотрудников с зарплатой ниже 40.000 долларов (используйте имя и зарплату).
SELECT
	e.first_name,
    s.salary
FROM employees e
INNER JOIN salaries s ON e.emp_no = s.emp_no
WHERE s.salary > 60000
UNION
SELECT
	e.first_name,
    s.salary
FROM employees e
INNER JOIN salaries s ON e.emp_no = s.emp_no
WHERE s.salary < 40000;

#Объединение текущих и бывших сотрудников: Используйте UNION для создания списка сотрудников, 
#которые в настоящее время работают в компании, и тех, кто уже ушел 
#(используйте имя, фамилию и статус 'Текущий' или 'Бывший' , то есть first_name, last_name, 'Текущий' AS status, 'Бывший' AS status ).
SELECT
	e.first_name,
    e.last_name,
    'Текущий' AS status
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
WHERE de.to_date >= CURDATE()
UNION
SELECT
	e.first_name,
    e.last_name,
    'Бывший' AS status
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
WHERE de.to_date < CURDATE();

#Сравнение зарплат менеджеров и обычных сотрудников: Создайте запрос с использованием UNION, 
#чтобы сравнить средние зарплаты менеджеров и обычных сотрудников 
#(выведите тип сотрудника, либо Менеджер, либо Обычный сотрудник их среднюю зарплату, 
#то есть 'Менеджер' AS type, 'Обычный сотрудник' AS type, AVG(salary) AS avg_salary ).
SELECT
	s.emp_no,
	'Менеджер' AS type,
    AVG(s.salary) AS avg_salary
FROM salaries s
INNER JOIN dept_manager dm ON s.emp_no = dm.emp_no
GROUP BY s.emp_no
UNION
SELECT
	s.emp_no,
	'Обычный сотрудник' AS type,
    AVG(s.salary) AS avg_salary
FROM salaries s
INNER JOIN dept_emp de ON s.emp_no = de.emp_no
WHERE s.emp_no NOT IN (
	SELECT
		emp_no
	FROM dept_manager
)
GROUP BY s.emp_no