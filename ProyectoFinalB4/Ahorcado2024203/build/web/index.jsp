<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Animated Login</title>
        <link rel="stylesheet" type="text/css" href="Styles/style.css">
    </head>
    <body>
        <div class="wrapper">
            <div class="form-wrapper sign-in">
                <form action="Validar" method="post">
                    <h2>Login</h2>
                    <c:if test="${not empty error}">
                        <p style="color: red; text-align: center; font-size: 14px;">${error}</p>
                    </c:if>
                    <div class="input-group">
                        <input type="email" name="txtCorreo" required>
                        <label for="">Correo</label>
                    </div>
                    <div class="input-group">
                        <input type="password" name="txtPassword" required>
                        <label for="">Contraseña</label>
                    </div>
                    <div class="remember">
                        <label><input type="checkbox"> Recuérdame</label>
                    </div>
                    <button type="submit" name="accion" value="Ingresar">Ingresar</button>
                    <div class="signUp-link">
                        <p>No tienes cuenta? <a href="#" class="signUpBtn-link">Registrate</a></p>
                    </div>
                </form>
            </div>
            <div class="form-wrapper sign-up">
                <form action="Validar" method="post">
                    <h2>Registro</h2>
                    <c:if test="${not empty errorRegistro}">
                        <p style="color: red; text-align: center; font-size: 14px;">${errorRegistro}</p>
                    </c:if>
                    <div class="input-group">
                        <input type="email" name="txtCorreoR" required>
                        <label for="">Correo</label>
                    </div>
                    <div class="input-group">
                        <input type="password" name="txtPasswordR" required>
                        <label for="">Contraseña</label>
                    </div>
                    <div class="input-group">
                        <input type="password" name="confirmar" required>
                        <label for="">Confirmar Contraseña</label>
                    </div>
                    <div class="remember">
                        <label><input type="checkbox"> Acepto los términos y condiciones</label>
                    </div>
                    <button type="submit" name="accion" value="Registro">Registrarse</button>
                    <div class="signUp-link">
                        <p>Ya tienes cuenta? <a href="#" class="signInBtn-link">Ingresar</a></p>
                    </div>
                </form>
            </div>
        </div>
        <script src="Scripts/script.js"></script>
        <script>
            // Show success message on successful registration
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('registro') === 'success') {
                alert('¡Registro exitoso! Ya puedes iniciar sesión.');
            }
        </script>
    </body>
</html>