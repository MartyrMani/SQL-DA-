#1. Создать процедуру, в которой мы получаем на вход два параметра p_salary, p_dept и на выходе получим:
#Список сотрудников (emp_no, first_name, gender), у которых средняя зарплата больше p_salary
# и которые когда-то работали в департаменте p_dept.
DELIMITER $$

CREATE PROCEDURE GetEmployeesFromDept(IN p_salary DECIMAL(10, 2), IN p_dept CHAR(4))
BEGIN
	SELECT
		e.emp_no,
        e.first_name,
        e.gender
	FROM employees e
    WHERE p_salary < (
		SELECT
			AVG(s.salary)
		FROM salaries s
        WHERE s.emp_no = e.emp_no
        GROUP BY emp_no
    )
    AND
    p_dept IN (
		SELECT
			de.dept_no
		FROM dept_emp de
        WHERE de.emp_no = e.emp_no
    );
END$$

DELIMITER ;

CALL GetEmployeesFromDept(50000, 'd005');

#2. Создать функцию, которая получает на вход f_name и выдает максимальную зарплату среди сотрудников с именем f_name.
DELIMITER $$

CREATE FUNCTION f_max_salary_for_name(f_name VARCHAR(100)) RETURNS DECIMAL(10, 2)
DETERMINISTIC READS SQL DATA
BEGIN
	DECLARE f_max_salary DECIMAL(10, 2);
    
    SELECT
		MAX(s.salary) INTO f_max_salary
	FROM salaries s
    INNER JOIN employees e ON s.emp_no = e.emp_no
    WHERE e.first_name = f_name;
    
    RETURN f_max_salary;
END$$

DELIMITER ;

SELECT f_max_salary_for_name('Suzette');


#				 к базе данных World
#1. Посчитайте количество городов в каждой стране, где IndepYear = 1991 (Independence Year).
SELECT
	ct.CountryCode,
	COUNT(ct.ID) AS count_of_cities
FROM city ct
INNER JOIN country cntr ON ct.CountryCode = cntr.Code
WHERE cntr.IndepYear = 1991
GROUP BY ct.CountryCode;

#2. Узнайте, какая численность населения и средняя продолжительность жизни людей в Аргентине (ARG).
SELECT
	Population,
    LifeExpectancy
FROM country
WHERE Code LIKE 'ARG';

#3. В какой стране самая высокая продолжительность жизни?
SELECT
	Name,
    LifeExpectancy
FROM country
ORDER BY LifeExpectancy DESC
LIMIT 1;

#4. Перечислите все языки, на которых говорят в регионе «Southeast Asia».
SELECT
	DISTINCT cl.Language
FROM countrylanguage cl
INNER JOIN country cntr ON cl.CountryCode = cntr.Code
WHERE cntr.Region = 'Southeast Asia';

#5. Посчитайте сумму SurfaceArea для каждого континента.
SELECT
	Continent,
    SUM(SurfaceArea) AS total_area
FROM country
GROUP BY Continent;