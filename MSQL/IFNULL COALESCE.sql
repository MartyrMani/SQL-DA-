CREATE DATABASE IF NOT EXISTS TrainingDB;
USE TrainingDB;

CREATE TABLE Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    department_id INT,
    performance_rating INT,
    years_of_service INT,
    salary DECIMAL(10, 2)
);


INSERT INTO Employees (first_name, last_name, department_id, performance_rating, years_of_service, salary)
VALUES
('John', 'Doe', 1, NULL, 5, 50000),
('Jane', 'Smith', NULL, 4, 2, NULL),
('Alice', 'Johnson', 2, 3, 8, 75000),
('Bob', 'Brown', NULL, NULL, NULL, 60000),
('Charlie', 'Davis', 3, 2, 10, 40000);

ALTER TABLE Employees ADD COLUMN default_salary DECIMAL(10, 2);
UPDATE Employees SET default_salary = NULL; 
UPDATE Employees SET default_salary = 28000 WHERE employee_id = 1;
