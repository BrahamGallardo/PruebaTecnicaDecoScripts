CREATE TABLE Oficinas (
    ID INT NOT NULL PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Ciudad VARCHAR(100) NOT NULL,
    Estado VARCHAR(100) NOT NULL,
    Pais VARCHAR(100) NOT NULL,
    Division INT NOT NULL
);


CREATE PROCEDURE SP_InsertOrUpdateOficina
    @Accion INT,
    @ID INT,
    @Nombre VARCHAR(255),
    @Direccion VARCHAR(255),
    @Ciudad VARCHAR(100),
    @Estado VARCHAR(100),
    @Pais VARCHAR(100),
    @Division INT
AS
BEGIN
    IF @Accion = 1
    BEGIN
        INSERT INTO Oficinas (ID, Nombre, Direccion, Ciudad, Estado, Pais, Division)
        VALUES (@ID, @Nombre, @Direccion, @Ciudad, @Estado, @Pais, @Division)
    END
    ELSE IF @Accion = 0
    BEGIN
        UPDATE Oficinas
        SET Direccion = @Direccion
        WHERE ID = @ID
    END
END


CREATE SEQUENCE IDOFICINA_SEC
    AS INT
    START WITH 1
    INCREMENT BY 1;

CREATE TRIGGER tr_InsertarOficina
ON Oficinas
AFTER INSERT
AS
BEGIN
    DECLARE @IDSecuencia INT;
    
    SELECT @IDSecuencia = NEXT VALUE FOR IDOFICINA_SEC;
    
    UPDATE Oficinas
    SET ID = @IDSecuencia
    WHERE ID IN (SELECT ID FROM INSERTED);
END