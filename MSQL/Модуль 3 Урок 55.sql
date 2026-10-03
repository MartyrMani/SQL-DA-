#Выведите список всех менеджеров, а именно их emp_no, имена/фамилии, номер департамента, который они курируют, и дату найма в компанию. 
#(именно менеджером, то есть подсказка dept_manager)
SELECT 
	dm.emp_no,
    CONCAT(e.first_name, ' ', e.last_name) as full_name,
    dm.dept_no,
    e.hire_date
FROM dept_manager dm
INNER JOIN employees e ON e.emp_no = dm.emp_no;

#Существует ли сотрудник по фамилии Markovitch, который когда-то был менеджером департамента. 
#Может быть таких сотрудников несколько? (именно менеджером, то есть подсказка dept_manager)
SELECT
	COUNT(*)
FROM dept_manager dm
INNER JOIN employees e ON e.emp_no = dm.emp_no
WHERE e.last_name LIKE 'Markovitch'
GROUP BY dm.emp_no;

#Вывести список сотрудников, имена/фамилии, дату найма, должность в компании, 
#у которых имя начинается на М, а фамилия заканчивается на H.
SELECT
	e.emp_no,
    CONCAT(e.first_name, ' ', e.last_name) as full_name,
    e.hire_date,
    t.title
FROM employees e
INNER JOIN titles t ON t.emp_no = e.emp_no
WHERE e.first_name LIKE 'M%' AND e.last_name LIKE '%h';

#Создайте временную таблицу на основе salaries, где у вас будет emp_no 
#и его/ее максимальная и минимальная зарплата за весь период работы в компании. 
#Далее сделайте JOIN используя эту временную таблицу и таблицу employees чтобы получить 
#список сотрудников, их имена/фамилии, и их мин/макс зарплат.
CREATE TEMPORARY TABLE salaries_temp
SELECT 
	emp_no,
    MAX(salary) as max_salary,
    MIN(salary) as min_salary
FROM salaries
GROUP BY emp_no;

SELECT * FROM salaries_temp;

SELECT
	st.emp_no,
    CONCAT(e.first_name, ' ', e.last_name) as full_name,
    st.max_salary,
    st.min_salary
FROM salaries_temp st
INNER JOIN employees e ON e.emp_no = st.emp_no;