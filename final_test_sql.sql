create database final_test;
use final_test;

-- Создать таблицы с иерархией из диаграммы в БД
CREATE TABLE Animals (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    birth_date DATE
);

CREATE TABLE DomesticAnimals (
    id INT PRIMARY KEY AUTO_INCREMENT,
    animal_id INT,
    FOREIGN KEY (animal_id) REFERENCES Animals(id)
);

CREATE TABLE PackAnimals (
    id INT PRIMARY KEY AUTO_INCREMENT,
    animal_id INT,
    FOREIGN KEY (animal_id) REFERENCES Animals(id)
);

CREATE TABLE Dogs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    domestic_animal_id INT,
    command VARCHAR(100),
    FOREIGN KEY (domestic_animal_id) REFERENCES DomesticAnimals(id)
);

CREATE TABLE Cats (
    id INT PRIMARY KEY AUTO_INCREMENT,
    domestic_animal_id INT,
    command VARCHAR(100),
    FOREIGN KEY (domestic_animal_id) REFERENCES DomesticAnimals(id)
);

CREATE TABLE Hamsters (
    id INT PRIMARY KEY AUTO_INCREMENT,
    domestic_animal_id INT,
    command VARCHAR(100),
    FOREIGN KEY (domestic_animal_id) REFERENCES DomesticAnimals(id)
);

CREATE TABLE Horses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pack_animal_id INT,
    command VARCHAR(100),
    FOREIGN KEY (pack_animal_id) REFERENCES PackAnimals(id)
);

CREATE TABLE Camels (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pack_animal_id INT,
    command VARCHAR(100),
    FOREIGN KEY (pack_animal_id) REFERENCES PackAnimals(id)
);

CREATE TABLE Donkeys (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pack_animal_id INT,
    command VARCHAR(100),
    FOREIGN KEY (pack_animal_id) REFERENCES PackAnimals(id)
);


-- Заполнить низкоуровневые таблицы именами(животных), командами
-- которые они выполняют и датами рождения
INSERT INTO Animals (name, birth_date) VALUES ('Dude', '2020-08-11');
INSERT INTO DomesticAnimals (animal_id) VALUES (LAST_INSERT_ID());
INSERT INTO Dogs (domestic_animal_id, command) VALUES (LAST_INSERT_ID(), 'Sit');

INSERT INTO Animals (name, birth_date) VALUES ('Buddy', '2022-11-02');
INSERT INTO DomesticAnimals (animal_id) VALUES (LAST_INSERT_ID());
INSERT INTO Cats (domestic_animal_id, command) VALUES (LAST_INSERT_ID(), 'Jump');

INSERT INTO Animals (name, birth_date) VALUES ('Jason', '2023-01-01');
INSERT INTO DomesticAnimals (animal_id) VALUES (LAST_INSERT_ID());
INSERT INTO Hamsters (domestic_animal_id, command) VALUES (LAST_INSERT_ID(), 'Run');

INSERT INTO Animals (name, birth_date) VALUES ('Rome', '2023-07-14');
INSERT INTO PackAnimals (animal_id) VALUES (LAST_INSERT_ID());
INSERT INTO Horses (pack_animal_id, command) VALUES (LAST_INSERT_ID(), 'Run');

INSERT INTO Animals (name, birth_date) VALUES ('Humphrey', '2019-01-20');
INSERT INTO PackAnimals (animal_id) VALUES (LAST_INSERT_ID());
INSERT INTO Camels (pack_animal_id, command) VALUES (LAST_INSERT_ID(), 'Carry');

INSERT INTO Animals (name, birth_date) VALUES ('Eeyore', '2023-01-14');
INSERT INTO PackAnimals (animal_id) VALUES (LAST_INSERT_ID());
INSERT INTO Donkeys (pack_animal_id, command) VALUES (LAST_INSERT_ID(), 'Transportation');


-- Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой
-- питомник на зимовку. Объединить таблицы лошади, и ослы в одну таблицу.
DELETE FROM Camels;

CREATE TABLE HorsesAndDonkeys AS
SELECT * FROM Horses
UNION ALL
SELECT * FROM Donkeys;


-- Создать новую таблицу “молодые животные” в которую попадут все
-- животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью
-- до месяца подсчитать возраст животных в новой таблице
CREATE TABLE YoungAnimals AS
SELECT 
    a.id,
    a.name,
    a.birth_date,
    TIMESTAMPDIFF(MONTH, a.birth_date, CURDATE()) AS age_in_months
FROM 
    Animals a
JOIN 
    (
        SELECT id, birth_date FROM Animals 
        WHERE TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) > 1 
        AND TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) < 3
    ) young ON a.id = young.id;
    
    
-- Объединить все таблицы в одну, при этом сохраняя поля, указывающие на
-- прошлую принадлежность к старым таблицам.
CREATE TABLE AllAnimals AS
SELECT a.*, 'Dog' AS animal_type FROM Animals a
JOIN DomesticAnimals da ON a.id = da.animal_id
JOIN Dogs d ON da.id = d.domestic_animal_id
UNION ALL
SELECT a.*, 'Cat' AS animal_type FROM Animals a
JOIN DomesticAnimals da ON a.id = da.animal_id
JOIN Cats c ON da.id = c.domestic_animal_id
UNION ALL
SELECT a.*, 'Hamster' AS animal_type FROM Animals a
JOIN DomesticAnimals da ON a.id = da.animal_id
JOIN Hamsters h ON da.id = h.domestic_animal_id
UNION ALL
SELECT a.*, 'Horse' AS animal_type FROM Animals a
JOIN PackAnimals pa ON a.id = pa.animal_id
JOIN Horses ho ON pa.id = ho.pack_animal_id
UNION ALL
SELECT a.*, 'Donkey' AS animal_type FROM Animals a
JOIN PackAnimals pa ON a.id = pa.animal_id
JOIN Donkeys d ON pa.id = d.pack_animal_id;
