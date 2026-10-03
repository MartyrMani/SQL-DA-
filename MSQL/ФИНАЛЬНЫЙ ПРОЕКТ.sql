CREATE VIEW checks AS
SELECT
    ID_client,
    Id_check,
    date_new,
    SUM(Sum_payment) AS check_sum
FROM transactions
GROUP BY
    ID_client,
    Id_check,
    date_new;

# Задание 1
SELECT
    ID_client,
    AVG(check_sum) AS average_check,
    SUM(check_sum) / 12.0 AS average_month_sum,
    COUNT(*) AS operations_count
FROM checks
GROUP BY ID_client
HAVING COUNT(DISTINCT DATE_FORMAT(date_new, '%Y-%m')) = 12
ORDER BY ID_client;

# Задание 2
WITH monthly AS (
    SELECT
        DATE_FORMAT(date_new, '%Y-%m') AS month,
        AVG(check_sum) AS average_check,
        COUNT(*) AS operations_count,
        COUNT(DISTINCT ID_client) AS clients_count,
        COUNT(*) * 1.0 / COUNT(DISTINCT ID_client) AS average_operations_per_client,
        SUM(check_sum) AS month_sum
    FROM checks
    GROUP BY DATE_FORMAT(date_new, '%Y-%m')
)

SELECT
    month,
    average_check,
    operations_count,
    clients_count,
    average_operations_per_client,
    month_sum,
    operations_count * 100.0 / SUM(operations_count) OVER () AS operations_percent,
    month_sum * 100.0 / SUM(month_sum) OVER () AS amount_percent
FROM monthly
ORDER BY month;

WITH gender_month AS (
    SELECT
        DATE_FORMAT(ch.date_new, '%Y-%m') AS month,
        CASE
            WHEN c.Gender IS NULL THEN 'NA'
            ELSE c.Gender
        END AS gender,
        COUNT(DISTINCT ch.ID_client) AS clients_count,
        SUM(ch.check_sum) AS amount
    FROM checks ch
    JOIN customers c ON ch.ID_client = c.Id_client
    GROUP BY DATE_FORMAT(ch.date_new, '%Y-%m'),
        CASE
            WHEN c.Gender IS NULL THEN 'NA'
            ELSE c.Gender
        END
)

SELECT
    month,
    gender,
    clients_count,
    clients_count * 100.0 / SUM(clients_count) OVER (PARTITION BY month) AS clients_percent,
    amount,
    amount * 100.0 / SUM(amount) OVER (PARTITION BY month) AS amount_percent
FROM gender_month
ORDER BY month, gender;

# Задание 3
WITH age_data AS (
    SELECT
        ch.ID_client,
        ch.Id_check,
        ch.date_new,
        ch.check_sum,
        CASE
            WHEN c.Age IS NULL THEN 'NA'
            ELSE CONCAT(FLOOR(c.Age / 10) * 10, '-', FLOOR(c.Age / 10) * 10 + 9)
        END AS age_group
    FROM checks ch
    JOIN customers c ON ch.ID_client = c.Id_client
)

SELECT
    age_group,
    SUM(check_sum) AS total_amount,
    COUNT(*) AS operations_count,
    AVG(check_sum) AS average_check,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS operations_percent,
    SUM(check_sum) * 100.0 / SUM(SUM(check_sum)) OVER () AS amount_percent
FROM age_data
GROUP BY age_group
ORDER BY age_group;

WITH age_data AS (
    SELECT
        ch.ID_client,
        ch.Id_check,
        ch.date_new,
        ch.check_sum,
        CASE
            WHEN c.Age IS NULL THEN 'NA'
            ELSE CONCAT(FLOOR(c.Age / 10) * 10, '-', FLOOR(c.Age / 10) * 10 + 9)
        END AS age_group
    FROM checks ch
    JOIN customers c ON ch.ID_client = c.Id_client
), quarter_data AS (
    SELECT
        CONCAT(
            YEAR(date_new),
            '-Q',
            QUARTER(date_new)
        ) AS quarter,

        age_group,
        ID_client,
        Id_check,
        check_sum

    FROM age_data
)

SELECT
    quarter,
    age_group,
    AVG(check_sum) AS average_check,
    SUM(check_sum) * 1.0 / COUNT(DISTINCT ID_client) AS average_amount_per_client,
    COUNT(*) * 1.0 / COUNT(DISTINCT ID_client) AS average_operations_per_client,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY quarter) AS operations_percent,
    SUM(check_sum) * 100.0 / SUM(SUM(check_sum)) OVER (PARTITION BY quarter) AS amount_percent
FROM quarter_data
GROUP BY quarter, age_group
ORDER BY quarter, age_group;