CREATE DATABASE university;

CREATE TABLE Address(
Id INT PRIMARY KEY AUTO_INCREMENT,
Country NVARCHAR(100) NOT NULL,
County NVARCHAR(100) NOT NULL,
City NVARCHAR(100) NOT NULL,
Street NVARCHAR(100) NOT NULL,
Number NVARCHAR(10) NOT NULL
);

CREATE TABLE Person(
Id INT PRIMARY KEY AUTO_INCREMENT,
FirstName NVARCHAR(100) NOT NULL,
LastName NVARCHAR(100) NOT NULL,
PhoneNumber NVARCHAR(100) NOT NULL,
BirthDate Date NOT NULL,
AddressId INT NOT NULL,
FOREIGN KEY (AddressId) REFERENCES Address(Id)
);

CREATE TABLE Student(
Id INT PRIMARY KEY AUTO_INCREMENT,
PersonId INT NOT NULL,
FOREIGN KEY (PersonId) REFERENCES Person(Id),
Description NVARCHAR(250)
);

CREATE TABLE Teacher(
Id INT PRIMARY KEY AUTO_INCREMENT,
Position NVARCHAR(100) NOT NULL,
PersonId INT NOT NULL,
FOREIGN KEY (PersonId) REFERENCES Person(Id)
);

CREATE TABLE Course(
Id INT PRIMARY KEY AUTO_INCREMENT,
Name NVARCHAR(100) NOT NULL,
Credits DECIMAL(10,2) NOT NULL,
Description NVARCHAR(250) NOT NULL,
TeacherId INT NOT NULL,
FOREIGN KEY (TeacherId) REFERENCES Teacher(Id)
);

INSERT INTO Address (Country, County, City, Street, Number)
VALUES
(N'Казахстан', N'Костанайский Регион', N'Костанай', N'Улица Абая', N'15'),
(N'Казахстан', N'Акмолинский Регион', N'Астана', N'Мангелик Ел', N'22A'),
(N'Казахстан', N'Алматинский Регион', N'Алматы', N'Толе Би', N'101'),
(N'Казахстан', N'Карагандинский Регион', N'Караганда', N'Бухар Жырау', N'45'),
(N'Казахстан', N'Шымкентский Регион', N'Шымкент', N'Тауке Хан', N'78');

INSERT INTO Person (FirstName, LastName, PhoneNumber, BirthDate, AddressId)
VALUES
(N'Даяна', N'Иванова', N'+77011234567', N'2005-03-15', 1),
(N'Алексей', N'Смирнов', N'+77017654321', N'1998-07-21', 2),
(N'Мария', N'Петрова', N'+77025554433', N'2001-11-02', 3),
(N'Нурсултан', N'Акхметов', N'+77039887766', N'1995-01-10', 4),
(N'Елена', N'Сидорова', N'+77045556677', N'2000-09-18', 5);

INSERT INTO Student (PersonId, Description)
VALUES
(1, N'Студент Игформационных Систем'),
(3, N'Заинтересован в Дата Аналитике'),
(5, NULL),
(2, N'Заочное обучение'),
(4, N'Студент по сфере Бизнеса');

INSERT INTO Teacher (Position, PersonId)
VALUES
(N'Старший преподаватель', 2),
(N'Профессор', 4),
(N'Ассистент преподавателя', 1),
(N'Координатор курса', 3),
(N'Инструктор лаборатории', 5);

INSERT INTO Course (Name, Credits, Description, TeacherId)
VALUES
(N'Системы Дата Аналитики', 5.00, N'Изучение SQL и реляционных баз данных', 1),
(N'Основы Программирования', 4.00, N'Введение в концепции программирования', 2),
(N'Дата Аналитика', 6.00, N'Анализ данных с помощью Python и SQL', 3),
(N'Web Разработка', 5.00, N'Frontend и backend основы', 4),
(N'Бизнес Приложения', 3.00, N'Разработка корпоративного программного обеспечения', 5);

SELECT * FROM Address;
SELECT * FROM Person;
SELECT * FROM Student;
SELECT * FROM Teacher;
SELECT * FROM Course;