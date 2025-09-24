-- Creacion de la DB
DROP DATABASE IF EXISTS DB_Ahorcado;
CREATE DATABASE DB_Ahorcado;
USE DB_Ahorcado;

CREATE TABLE Usuarios(
	codigo_usuario INT AUTO_INCREMENT,
    correo_usuario VARCHAR(150) NOT NULL UNIQUE,
    contraseña_usuario VARCHAR(100) NOT NULL,
	PRIMARY KEY PK_codigo_usuario (codigo_usuario)
);

CREATE TABLE Palabras(
	codigo_palabra INT AUTO_INCREMENT,
    palabra VARCHAR(50) NOT NULL,
    pista VARCHAR(100) NOT NULL,
    PRIMARY KEY PK_codigo_palabra (codigo_palabra)
);

DELIMITER //
CREATE TRIGGER tr_Before_Insert_CorreoUsuarios
BEFORE INSERT ON Usuarios
FOR EACH ROW
BEGIN
    IF (NEW.correo_usuario NOT LIKE '%@gmail.com' AND NEW.correo_usuario NOT LIKE '%@kinal.edu.gt') THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El correo electrónico debe tener el dominio @gmail.com o @kinal.edu.gt';
    END IF;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER tr_Before_Update_CorreoUsuarios
BEFORE UPDATE ON Usuarios
FOR EACH ROW
BEGIN
    IF (NEW.correo_usuario NOT LIKE '%@gmail.com' AND NEW.correo_usuario NOT LIKE '%@kinal.edu.gt') THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El correo electrónico debe tener el dominio @gmail.com o @kinal.edu.gt';
    END IF;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_AgregarUsuario(
    IN correo_usuario VARCHAR(150), 
    IN contraseña_usuario VARCHAR(100))
BEGIN
    INSERT INTO Usuarios(correo_usuario, contraseña_usuario)
        VALUES(correo_usuario, contraseña_usuario);
END //
DELIMITER ;
CALL sp_AgregarUsuario('alejo@gmail.com', 'alejo');
CALL sp_AgregarUsuario('maria.gomez@gmail.com', 'Mgomez#123');
CALL sp_AgregarUsuario('pedro.lopez@gmail.com', 'Plopez@456');
CALL sp_AgregarUsuario('ana.martinez@gmail.com', 'Amartinez#789');
CALL sp_AgregarUsuario('luis.hernandez@gmail.com', 'Lhernandez@101');

-- RegistrarseLogin
DELIMITER //
CREATE PROCEDURE sp_RegistroLogin(
    IN correo_usuario VARCHAR(150), 
    IN contraseña_usuario VARCHAR(100),
    OUT filas INT)
BEGIN
    INSERT INTO Usuarios(correo_usuario, contraseña_usuario)
        VALUES(correo_usuario, contraseña_usuario);
    SET filas = ROW_COUNT();
END //
DELIMITER ;

-- Listar Usuarios
DELIMITER //
CREATE PROCEDURE sp_ListarUsuarios()
BEGIN
    SELECT codigo_usuario, correo_usuario, contraseña_usuario FROM Usuarios;
END //
DELIMITER ;
CALL sp_ListarUsuarios();

-- Eliminar Usuarios
DELIMITER //
CREATE PROCEDURE sp_EliminarUsuario(
    IN _codigo_usuario INT)
BEGIN
    SET FOREIGN_KEY_CHECKS = 0;
    DELETE FROM Usuarios
        WHERE codigo_usuario = _codigo_usuario;
    SELECT ROW_COUNT() AS filasEliminadas;
    SET FOREIGN_KEY_CHECKS = 1;
END//
DELIMITER ;

-- Buscar Usuarios
DELIMITER //
CREATE PROCEDURE sp_BuscarUsuarios(
    IN _codigo_usuario INT)
BEGIN
    SELECT codigo_usuario, correo_usuario, contraseña_usuario FROM Usuarios
        WHERE codigo_usuario = _codigo_usuario;
END //
DELIMITER ;
CALL sp_BuscarUsuarios(1);

-- Editar Usuario
DELIMITER //
CREATE PROCEDURE sp_EditarUsuario(
    IN _codigo_usuario INT,
    IN _correo_usuario VARCHAR(150), 
    IN _contraseña_usuario VARCHAR(100)) 
BEGIN
    UPDATE Usuarios
        SET correo_usuario = _correo_usuario,
        contraseña_usuario = _contraseña_usuario
            WHERE codigo_usuario = _codigo_usuario;
END //
DELIMITER ;

-- Busqueda del Usuario por nombre y contraseña
DELIMITER //
CREATE PROCEDURE sp_BuscarUsuariosNC(
    IN _correo_usuario VARCHAR(100),
    IN _contraseña_usuario VARCHAR(100))
BEGIN
    SELECT codigo_usuario, correo_usuario, contraseña_usuario FROM Usuarios WHERE correo_usuario = _correo_usuario AND contraseña_usuario = _contraseña_usuario;
END //
DELIMITER ;

-- --------------------------- Entidad Palabras --------------------------- 
-- Agregar Palabras
DELIMITER //
CREATE PROCEDURE sp_AgregarPalabras(
    IN palabra VARCHAR(50),
    IN pista VARCHAR(100))
BEGIN
    INSERT INTO Palabras(palabra, pista)
        VALUES (palabra, pista);
END //
DELIMITER ;
CALL sp_AgregarPalabras('HUMBERTO', 'Soy profesor y tengo 38 años.');
CALL sp_AgregarPalabras('MOONKNIGHT', 'Soy el caballero de la luna.');
CALL sp_AgregarPalabras('TELEFONO', 'Me puedes usar para ver redes sociales.');
CALL sp_AgregarPalabras('PAPAGAYO', 'Soy el papa del gayo.');
CALL sp_AgregarPalabras('ESTRELLA', 'Punto brillante visible en la noche.');

-- Listar Palabras
DELIMITER //
CREATE PROCEDURE sp_ListarPalabras()
BEGIN
    SELECT codigo_palabra, palabra, pista FROM Palabras;
END //
DELIMITER ;
CALL sp_ListarPalabras();

-- Eliminar Palabras
DELIMITER //
CREATE PROCEDURE sp_EliminarPalabras(
    IN _codigo_palabra INT)
BEGIN
    SET FOREIGN_KEY_CHECKS = 0;
    DELETE FROM Palabras
        WHERE codigo_palabra = _codigo_palabra;
    SELECT ROW_COUNT() AS filasEliminadas;
    SET FOREIGN_KEY_CHECKS = 1;
END//
DELIMITER ;

-- Buscar Palabras
DELIMITER //
CREATE PROCEDURE sp_BuscarPalabras(
    IN _codigo_palabra INT)
BEGIN
    SELECT codigo_palabra, palabra, pista FROM Palabras
        WHERE codigo_palabra = _codigo_palabra;
END //
DELIMITER ;

-- Editar Palabras
DELIMITER //
CREATE PROCEDURE sp_EditarPalabras(
    IN _codigo_palabra INT,
    IN _palabra VARCHAR(50),
    IN _pista VARCHAR(100)) 
BEGIN
    UPDATE Palabras
        SET palabra = _palabra,
        pista = _pista
            WHERE codigo_palabra = _codigo_palabra;
END //
DELIMITER ;

select * from Palabras;