#Если сотрудник работает более 30 лет, его статус будет "Veteran Employee", в противном случае - "New Employee".
SELECT 
    emp_no,
    first_name,
    (IF(TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) > 30,
        'Veteran Employee',
        'New Employee')) AS status
FROM employees;

#Если возраст сотрудника превышает 63 года, вместо числового значения возраста выводится статус "Пенсионер", в противном случае - "Активный сотрудник".
SELECT
	*,
    TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS age,
    IF(TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) > 63, 
	   'Пенсионер', 
       'Активный сотрудник') as status
FROM employees;

#Предполагается, что "молодой" - младше 30 лет, "средний" - от 30 до 50 лет, "старший" - старше 50 лет.
SELECT
	*,
    TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) as age,
    CASE
		WHEN TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) < 30 THEN 'Молодой'
        WHEN TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) BETWEEN 30 AND 50 THEN 'Средний'
        WHEN TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) > 50 THEN 'Старший'
    END as classify_by_age
FROM employees;

#Чьи имена начинаются на букву 'A' или 'B' в таблице employees.
SELECT * FROM employees WHERE first_name REGEXP '^A' OR first_name REGEXP '^B';

#Для сотрудников, у которых не указана зарплата (salary равно NULL), нужно отобразить значение зарплаты как 'Unknown'. 
SELECT
	first_name,
	department_id,
    IFNULL(salary, 'Unknown') as salary
FROM employees;

#В случае, если и salary, и default_salary равны NULL, тогда присвоить зарплату 25000.
SELECT
	*,
	COALESCE(salary, default_salary, 25000) as total_default_salary
FROM employees;