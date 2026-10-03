#Вся информация из таблицы employees
SELECT * FROM employees;

#Все мужчины из таблицы employees
SELECT * FROM employees WHERE gender = 'M';

#Все сотрудники по имени Elvis
SELECT * FROM employees WHERE first_name LIKE '%Elvis%';

#Уникальные/различные названия должностей
SELECT DISTINCT title FROM titles;

#Все сотрудники, кто был трудоустроен в 2000 году
SELECT * FROM employees WHERE hire_date BETWEEN '2000-01-01' AND '2000-12-31';

#Все сотрудники, кому больше 60 лет на данный момент
SELECT * FROM employees WHERE (CURDATE() - birth_date) > 60;

#Количество строк в таблице salaries
SELECT COUNT(*) FROM salaries;

#Количество строк в таблице salaries, где зарплата > 100.000$
SELECT COUNT(*) FROM salaries WHERE salary > 100000;