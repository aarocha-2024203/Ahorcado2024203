<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Juego del Ahorcado</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/ahorcado.css">
</head>
<body>
    <div class="sidebar">
        <button id="start">Iniciar</button>
        <button id="pause">Pausar</button>
        <button id="restart">Reiniciar</button>
        <button id="showHint">Mostrar pista</button>
    </div>

    <div class="container">
        <h1>Juego del Ahorcado</h1>
        <img id="gallows" src="<%= request.getContextPath() %>/Images/intento0.png" alt="Ahorcado">

        <div id="word"></div>
        <div id="hint"></div>
        <div id="keyboard">
            <div class="key-row">
                <button class="key">Q</button><button class="key">W</button><button class="key">E</button>
                <button class="key">R</button><button class="key">T</button><button class="key">Y</button>
                <button class="key">U</button><button class="key">I</button><button class="key">O</button><button class="key">P</button>
            </div>
            <div class="key-row">
                <button class="key">A</button><button class="key">S</button><button class="key">D</button>
                <button class="key">F</button><button class="key">G</button><button class="key">H</button>
                <button class="key">J</button><button class="key">K</button><button class="key">L</button>
            </div>
            <div class="key-row">
                <button class="key">Z</button><button class="key">X</button><button class="key">C</button>
                <button class="key">V</button><button class="key">B</button><button class="key">N</button><button class="key">M</button>
            </div>
        </div>
        <div id="message"></div>
        <div id="timer">Tiempo: 60s</div>
    </div>

    <script type="text/javascript">
        window.contextPath = "<%= request.getContextPath() %>";
    </script>
    <script src="<%= request.getContextPath() %>/Scripts/ahorcado.js"></script>
</body>
</html>