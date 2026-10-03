#Все женщины, у которых emp_no заканчивается на 7
SELECT * FROM employees 
WHERE gender = 'F' AND emp_no LIKE '%7';

#Все emp_no сотрудников, кто не работал в департаменте d005
SELECT emp_no FROM dept_emp
WHERE dept_no NOT LIKE 'd005';

#Все названия департаментов, где есть буквы ‘u’ и ‘o’
SELECT dept_name FROM departments
WHERE dept_name LIKE '%u%o%';

#Имена всех сотрудников, где есть либо ‘z’ либо ‘t’
SELECT first_name FROM employees
WHERE first_name LIKE '%z%' OR first_name LIKE '%t%';

#Все фамилии сотрудников, которые были наняты на работу между ‘1993-01-15’ и ‘1993-12-31’
SELECT last_name FROM employees
WHERE hire_date BETWEEN '1993-01-15' AND '1993-12-31';

#Список со всеми сотрудницами, чье имя Kellie
SELECT * FROM employees
WHERE gender = 'F' AND first_name LIKE 'Kellie';

#Список со всеми сотрудницами, чье имя Kellie или Aruna
SELECT * FROM employees
WHERE gender = 'F' AND (first_name LIKE 'Kellie' OR first_name LIKE 'Aruna');

#Вся информация из таблицы salaries где зарплаты между 66 000 и 70 000 долларов
SELECT * FROM salaries
WHERE salary BETWEEN 66000 AND 70000;