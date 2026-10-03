#Цель: Найти наивысшую текущую зарплату в каждом отделе.
SELECT
	de.emp_no,
    s.salary,
    de.dept_no,
    MAX(s.salary) OVER (PARTITION BY de.dept_no) AS max_salary_in_dept
FROM dept_emp de
INNER JOIN salaries s ON de.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01';

#Цель: Сравнить зарплату каждого сотрудника с средней зарплатой в его/ее отделе.
SELECT
	de.emp_no,
    s.salary,
    de.dept_no,
    AVG(s.salary) OVER (PARTITION BY de.dept_no) AS avg_salary_in_dept
FROM dept_emp de
INNER JOIN salaries s ON de.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01';

#Цель: Ранжировать сотрудников в каждом отделе по длительности их работы в компании.
SELECT
	de.emp_no,
    e.hire_date,
    de.dept_no,
    ROW_NUMBER() OVER (PARTITION BY de.dept_no ORDER BY e.hire_date) AS experience_rank
FROM dept_emp de
INNER JOIN employees e ON de.emp_no = e.emp_no;

#Цель: Определить, какая должность будет следующей для каждого сотрудника в ходе их карьеры.
SELECT
	emp_no,
    title,
    LEAD(title, 1, 'No info') OVER (PARTITION BY emp_no ORDER BY from_date) AS next_title
FROM titles;

#Цель: Узнать, какая была начальная и какая текущая зарплата у каждого сотрудника.
SELECT
	emp_no,
    salary,
	FIRST_VALUE(salary) OVER (PARTITION BY emp_no ORDER BY emp_no) AS first_salary,
    LAST_VALUE(salary) OVER (PARTITION BY emp_no ORDER BY emp_no) AS last_salary
FROM salaries;

#Цель: Вычислить скользящее среднее зарплаты для каждого сотрудника, основываясь на его последних трех зарплатах.
SELECT
	emp_no,
    from_date,
    salary,
    AVG(salary) OVER (PARTITION BY emp_no ORDER BY emp_no ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg_salary
FROM salaries;