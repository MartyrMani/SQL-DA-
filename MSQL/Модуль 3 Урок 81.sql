DROP INDEX idx_hire_date ON employees;

CREATE INDEX idx_hire_date
ON employees(hire_date);

SELECT * FROM employees
WHERE hire_date > '2000-01-01';

#До создания индекса запрос выполнился за 0.234 секунд
#Создание индекса заняло 0.984 секунд
#После создания индекса запрос занял ровно 0 секунд

DROP INDEX idx_name ON employees;

CREATE INDEX idx_name
ON employees(first_name, last_name);

SELECT * FROM employees
WHERE first_name = 'Georgi' AND last_name = 'Facello';

#До создания индекса запрос выполнился за 0.172 секунд
#Создание индекса заняло 1.687 секунду
#После создания индекса запрос занял ровно 0.016 секунд