#1. Создать процедуру, в которой мы получаем на вход два параметра p_salary, p_dept и на выходе получим:
#Список сотрудников (emp_no, first_name, gender), у которых средняя зарплата больше p_salary 
#и которые когда-то работали в департаменте p_dept.
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



#			к базе данных World
#1. Посчитайте количество городов в каждой стране, где IndepYear = 1991 (Independence Year).


#2. Узнайте, какая численность населения и средняя продолжительность жизни людей в Аргентине (ARG).


#3. В какой стране самая высокая продолжительность жизни?


#4. Перечислите все языки, на которых говорят в регионе «Southeast Asia».


#5. Посчитайте сумму SurfaceArea для каждого континента.
