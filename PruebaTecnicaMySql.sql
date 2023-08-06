CREATE TABLE Oficinas (
    ID INT NOT NULL PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Ciudad VARCHAR(100) NOT NULL,
    Estado VARCHAR(100) NOT NULL,
    Pais VARCHAR(100) NOT NULL,
    Division INT NOT NULL
);


DELIMITER //
CREATE PROCEDURE SP_InsertOrUpdateOficina
    (IN Accion INT, 
    IN ID INT,
    IN Nombre VARCHAR(255),
    IN Direccion VARCHAR(255),
    IN Ciudad VARCHAR(100),
    IN Estado VARCHAR(100),
    IN Pais VARCHAR(100),
    IN Division INT)
BEGIN
    IF Accion = 1 THEN
        INSERT INTO Oficinas (ID, Nombre, Direccion, Ciudad, Estado, Pais, Division)
        VALUES (ID, Nombre, Direccion, Ciudad, Estado, Pais, Division);
    ELSEIF Accion = 0 THEN
        UPDATE Oficinas
        SET Direccion = Direccion
        WHERE ID = ID;
    END IF;
END //
DELIMITER ;


CREATE TABLE Secuencias (
    Nombre VARCHAR(255),
    Id INT PRIMARY KEY
);

INSERT INTO Secuencias (Nombre, Id) VALUES ('IDOFICINA_SEC', 1);

DELIMITER //
CREATE TRIGGER tr_InsertarOficina
BEFORE INSERT ON Oficinas
FOR EACH ROW
BEGIN
    DECLARE IDSecuencia INT;

    SELECT Id INTO IDSecuencia FROM Secuencias WHERE Nombre = 'IDOFICINA_SEC';

    SET NEW.ID = IDSecuencia;

    UPDATE Secuencias SET Id = Id + 1 WHERE Nombre = 'IDOFICINA_SEC';
END //
DELIMITER ;