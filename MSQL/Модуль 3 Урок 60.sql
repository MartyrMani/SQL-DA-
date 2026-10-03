#Найдите всех сотрудников, которые работали как минимум в 2 департаментах. 
#Вывести их имя и фамилию. Показать записи в порядке возрастания.
SELECT
	first_name,
    last_name
FROM employees
WHERE emp_no IN (
	SELECT emp_no
    FROM dept_emp
    GROUP BY emp_no
    HAVING COUNT(*) >= 2
);

#Вывести имя, фамилию и зарплату самого высокооплачиваемого сотрудника.
SELECT
	e.first_name,
    e.last_name,
    s.salary
FROM employees e
INNER JOIN salaries s ON e.emp_no = s.emp_no
WHERE s.salary = (
	SELECT
		MAX(salary)
	FROM salaries
);

#Создайте запрос, который выбирает названия всех отделов, в которых работает более 100 сотрудников.
SELECT
	dept_name
FROM departments
WHERE dept_no IN (
	SELECT
		dept_no
	FROM dept_emp
    GROUP BY dept_no
    HAVING COUNT(emp_no) > 100
);

#Напишите запрос, который находит имена и фамилии всех сотрудников, которые никогда не были менеджерами.
SELECT
	first_name,
    last_name
FROM employees
WHERE emp_no NOT IN (
	SELECT
		emp_no
	FROM dept_manager
);

#Создайте запрос, который для каждого отдела выводит сотрудников, получающих наибольшую зарплату в этом отделе.
SELECT
	de.dept_no,
    de.emp_no,
    s.salary
FROM dept_emp de
INNER JOIN salaries s ON de.emp_no = s.emp_no
WHERE (de.dept_no, s.salary) IN (
	SELECT
		de2.dept_no, 
        MAX(s2.salary)
	FROM dept_emp de2
    INNER JOIN salaries s2 ON de2.emp_no = s2.emp_no
    GROUP BY de2.dept_no
);

#Напишите запрос, который выбирает названия отделов, где средняя зарплата выше общей средней зарплаты по компании.
SELECT
	d.dept_name,
    AVG(s.salary) AS avg_department_salary
FROM departments d
INNER JOIN dept_emp de ON d.dept_no = de.dept_no
INNER JOIN salaries s On de.emp_no = s.emp_no
GROUP BY d.dept_no
HAVING AVG(s.salary) > (
	SELECT
		AVG(salary)
	FROM salaries
);