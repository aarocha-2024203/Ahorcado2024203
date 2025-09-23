// Arocha
const palabras = ["HUMBERTO", "PAPAGAYO", "JAVASCRIPT", "PROGRAMAR", "AHORCADO"];
const pistas = {
  "HUMBERTO": [
    "Es un profesor",
    "Tiene 36 años",
    "Tiene un hijo"
  ],
  "PAPAGAYO": [
    "Es un ave",
    "Muy colorida",
    "Puede hablar"
  ],
  "JAVASCRIPT": [
    "Lenguaje de programación",
    "Se usa en la web",
    "Funciona en navegadores"
  ],
  "PROGRAMAR": [
    "Escribir código",
    "Crear software",
    "Resolver problemas"
  ],
  "AHORCADO": [
    "Juego clásico",
    "Usa letras",
    "Pierdes con 6 fallos"
  ]
};

let palabra = "";
let palabraOculta = [];
let intentos = 0;
const maxIntentos = 6;

let tiempo = 60;
let temporizador = null;
let pausado = false;
let iniciado = false;

// contador de pistas
let pistaIndex = 0;

function iniciarJuego() {
  palabra = palabras[Math.floor(Math.random() * palabras.length)];
  palabraOculta = Array(palabra.length).fill("_");
  intentos = 0;
  tiempo = 60;
  clearInterval(temporizador);
  iniciado = false;
  pausado = false;
  pistaIndex = 0;

  document.getElementById("gallows").src = "Images/intento0.png";
  document.getElementById("word").textContent = palabraOculta.join(" ");
  document.getElementById("message").textContent = "";
  document.getElementById("hint").textContent = "";
  document.getElementById("timer").textContent = "Tiempo: 60s";
  document.getElementById("pause").textContent = "Pausar";

  // teclado deshabilitado hasta dar iniciar
  document.querySelectorAll(".key").forEach(btn => {
    btn.disabled = true;
    btn.style.background = "#007BFF";
    btn.onclick = () => manejarLetra(btn.textContent, btn);
  });
}

function manejarLetra(letra, btn) {
  if (!iniciado || pausado) return; // si no inició o está pausado no deja jugar

  btn.disabled = true;
  if (palabra.includes(letra)) {
    for (let i = 0; i < palabra.length; i++) {
      if (palabra[i] === letra) {
        palabraOculta[i] = letra;
      }
    }
    document.getElementById("word").textContent = palabraOculta.join(" ");
    if (!palabraOculta.includes("_")) {
      document.getElementById("message").textContent = "¡Ganaste! 🎉";
      detenerJuego();
    }
  } else {
    intentos++;
    document.getElementById("gallows").src = "Images/intento" + intentos + ".png";
    if (intentos >= maxIntentos) {
      document.getElementById("message").textContent = "Perdiste 😢. La palabra era: " + palabra;
      detenerJuego();
    }
  }
}

function deshabilitarTeclado() {
  document.querySelectorAll(".key").forEach(btn => btn.disabled = true);
}

function habilitarTeclado() {
  document.querySelectorAll(".key").forEach(btn => {
    if (!btn.disabled) return;
    if (palabraOculta.includes("_") && intentos < maxIntentos) {
      btn.disabled = false;
    }
  });
}

function detenerJuego() {
  clearInterval(temporizador);
  temporizador = null;
  deshabilitarTeclado();
}

// --- BOTONES ---
document.getElementById("restart").addEventListener("click", () => {
  iniciarJuego();
});

document.getElementById("start").addEventListener("click", () => {
  if (!temporizador) {
    iniciado = true;
    pausado = false;
    document.querySelectorAll(".key").forEach(btn => btn.disabled = false);

    temporizador = setInterval(() => {
      if (!pausado) {
        tiempo--;
        document.getElementById("timer").textContent = "Tiempo: " + tiempo + "s";
        if (tiempo <= 0) {
          document.getElementById("message").textContent = "⏰ Se acabó el tiempo. La palabra era: " + palabra;
          detenerJuego();
        }
      }
    }, 1000);
  }
});

document.getElementById("pause").addEventListener("click", () => {
  if (!iniciado) return;

  pausado = !pausado;
  if (pausado) {
    document.getElementById("pause").textContent = "Reanudar";
    deshabilitarTeclado();
  } else {
    document.getElementById("pause").textContent = "Pausar";
    habilitarTeclado();
  }
});

// BOTÓN DE PISTAS
document.getElementById("showHint").addEventListener("click", () => {
  if (pistaIndex < pistas[palabra].length) {
    document.getElementById("hint").innerHTML += `<p>${pistas[palabra][pistaIndex]}</p>`;
    pistaIndex++;
  } else {
    document.getElementById("hint").innerHTML += `<p>No hay más pistas disponibles.</p>`;
  }
});

// iniciar automáticamente con la primera palabra
iniciarJuego();