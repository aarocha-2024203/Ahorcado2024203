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
                <form action="Ahorcado.jsp">
                    <h2>Login</h2>
                    <div class="input-group">
                        <input type="text" required>
                        <label for="">Nombre</label>
                    </div>
                    <div class="input-group">
                        <input type="password" required>
                        <label for="">Contraseña</label>
                    </div>
                    <div class="remember">
                        <label><input type="checkbox"> Recuerdame</label>
                    </div>
                    <button type="submit">Login</button>
                    <div class="signUp-link">
                        <p>No tienes cuenta? <a href="#" class="signUpBtn-link">Iniciar Secion</a></p>
                    </div>
                </form>
            </div>
            <div class="form-wrapper sign-up">
                <form action="">
                    <h2>Sign Up</h2>
                    <div class="input-group">
                        <input type="text" required>
                        <label for="">Nombre</label>
                    </div>
                    <div class="input-group">
                        <input type="email" required>
                        <label for="">Correo</label>
                    </div>
                    <div class="input-group">
                        <input type="password" required>
                        <label for="">Contraseña</label>
                    </div>
                    <div class="remember">
                        <label><input type="checkbox"> Acepto los terminos y condiciones</label>
                    </div>
                    <button type="submit">Iniciar sesion</button>
                    <div class="signUp-link">
                        <p>Ya tienes cuenta? <a href="#" class="signInBtn-link">Iniciar Sesion</a></p>
                    </div>
                </form>
            </div>
        </div>
        <script src="Scripts/script.js"></script>
    </body>
</html>