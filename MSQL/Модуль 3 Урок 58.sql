#Найдите количество сотрудников мужского пола (M) и женского пола (F) 
#и выведите записи в порядке убывания по количеству сотрудников.
SELECT
	gender,
    COUNT(*) as amount
FROM employees
GROUP BY gender
ORDER BY amount DESC;

#Найдите среднюю зарплату в разрезе должностей сотрудников (title), 
#округлите эти средние зарплаты до 2 знаков после запятой и выведите записи в порядке убывания.
SELECT
	t.title,
    ROUND(avg(s.salary), 2) as avg_salary
FROM titles t
INNER JOIN salaries s ON s.emp_no = t.emp_no
GROUP BY t.title
ORDER BY avg_salary DESC;

#Вывести месяцы (от 1 до 12), и количество нанятых сотрудников в эти месяцы.
SELECT
	MONTH(hire_date) as month,
    COUNT(emp_no) as amount
FROM employees
GROUP BY MONTH(hire_date)
ORDER BY month;

#Сформируйте запрос, который соединяет employees, dept_emp, departments и titles, 
#чтобы показать имена и фамилии сотрудников, названия их отделов и их текущие должности 
#(именно текущие должности, то есть фильтр по таблице titles, столбец to_date).
SELECT
	e.first_name,
    e.last_name,
    d.dept_name,
    t.title
FROM employees e
INNER JOIN dept_emp de ON de.emp_no = e.emp_no
INNER JOIN departments d ON d.dept_no = de.dept_no
INNER JOIN titles t ON t.emp_no = e.emp_no
WHERE t.to_date >= CURDATE();

#Используйте Self JOIN в таблице employees, 
#чтобы найти пары сотрудников с одинаковыми фамилиями. Отобразите их имена и фамилии.
SELECT
	e1.first_name as person1_name,
    e2.first_name as person2_name,
    e1.last_name
FROM employees e1
INNER JOIN employees e2 
	ON e2.last_name = e1.last_name
    AND e2.emp_no > e1.emp_no;