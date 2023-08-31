---ETL TASKS:

CREATE TABLE Percentage (
    RollNo INT PRIMARY KEY,
    Identity VARCHAR(20),
    Marks DECIMAL(8, 4)
);


INSERT INTO Percentage (RollNo, Identity, Marks)
VALUES
    (1, 'Autumn', 91.345),
    (2, 'Spring', 90),
    (3, 'Random', 99.9232),
    (4, 'Random', 92.1234),
    (5, 'Humidity', 90);

SELECT
    RollNo,
    CONCAT(UCASE(LEFT(Identity, 1)), LCASE(SUBSTRING(Identity, 2))) AS Identity,
    ROUND(CAST(SUBSTRING_INDEX(Marks, '%', 1) AS DECIMAL(10, 1)), 1) AS Marks
FROM Percentage;