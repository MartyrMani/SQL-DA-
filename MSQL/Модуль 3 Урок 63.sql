#Создание простого View: Напишите SQL-запрос для создания представления (View), 
#которое отображает имена и фамилии всех сотрудников.
CREATE VIEW v_emp_fullname AS
SELECT
	first_name,
    last_name
FROM employees;

SELECT * FROM v_emp_fullname;

#View с JOIN: Создайте представление, которое объединяет таблицы employees и salaries, 
#показывая идентификатор сотрудника, его имя, фамилию и текущую зарплату.
CREATE VIEW v_emp_name_salary AS
SELECT
	e.emp_no,
    e.first_name,
    e.last_name,
    s.salary
FROM employees e
INNER JOIN salaries s ON e.emp_no = s.emp_no
WHERE s.to_date >= CURDATE();

SELECT * FROM v_emp_name_salary;

#View для агрегированных данных: Создайте представление, 
#которое показывает среднюю зарплату по каждому отделу.
CREATE VIEW v_avg_salary_dept AS
SELECT
	de.dept_no,
    AVG(s.salary) AS avg_salary
FROM dept_emp de
INNER JOIN salaries s ON de.emp_no = s.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM v_avg_salary_dept;

#Комбинированный View с JOIN и WHERE: Создайте представление, 
#которое отображает информацию о сотрудниках, работающих в отделе 'Sales'

#По номеру отдела
CREATE VIEW v_emp_sales AS
SELECT
	e.emp_no,
    e.birth_date,
    e.first_name,
    e.last_name,
    e.gender
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
WHERE de.dept_no = 'd007';

SELECT * FROM v_emp_sales;

#По имени отдела
CREATE VIEW v_emp_sales_by_name AS
SELECT
	e.emp_no,
    e.birth_date,
    e.first_name,
    e.last_name,
    e.gender
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

SELECT * FROM v_emp_sales_by_name;