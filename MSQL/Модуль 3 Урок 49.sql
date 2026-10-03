#Вывести hire_date в годах, и количество сотрудников, которых наняли в эти года.
SELECT 
	YEAR(hire_date) AS year, 
    COUNT(emp_no) AS amount
FROM employees
GROUP BY YEAR(hire_date);

#Вывести dept_no и рядом количество сотрудников, которые когда-либо работали в этих департаментах.
SELECT 
	dept_no,
    COUNT(emp_no) as amount
FROM dept_emp
GROUP BY dept_no;

#Вывести birth_date и количество сотрудников, которые родились в эти дни. 
#Отфильтровать birth_date не равен 1952-02-13 и вывести только те дни, где количество сотрудников > 60. 
#Отсортировать по убыванию (по количеству сотрудников), и далее показать только топ 20 birth_date (по количеству сотрудников). 
SELECT
	birth_date,
    COUNT(emp_no) as amount
FROM employees
WHERE birth_date <> '1952-02-13'
GROUP BY birth_date
HAVING COUNT(emp_no) > 60
ORDER BY amount DESC
LIMIT 20;

#Вывести имена (которые начинается на А) и количество сотрудников с этим именем в компании. 
#Отфильтровать имена, у которых количество сотрудников с этим именем больше 250, 
#отсортировать по количеству сотрудников и показать только топ 10 first_name (по количеству сотрудников).
SELECT
	first_name,
    COUNT(emp_no) as amount
FROM employees
WHERE first_name LIKE 'A%'
GROUP BY first_name
HAVING COUNT(emp_no) > 250
ORDER BY amount
LIMIT 10;

#Создать копию таблицы employees, где имена начинается на B. 
#Удалить строки в employees, где имена начинаются на B, далее из копии нашей таблицы вставить обратно эти строки. 
#Удалить все строки из копии нашей таблицы, далее дропнуть эту таблицу.
CREATE TABLE employees_copy_B LIKE employees;
INSERT INTO employees_copy_B
SELECT * FROM employees WHERE first_name LIKE 'B%';

SELECT * FROM employees_copy_B;

DELETE FROM employees WHERE first_name LIKE 'B%';

SELECT * FROM employees;

INSERT INTO employees
SELECT * FROM employees_copy_B;

DELETE FROM employees_copy_B;
DROP TABLE employees_copy_B;