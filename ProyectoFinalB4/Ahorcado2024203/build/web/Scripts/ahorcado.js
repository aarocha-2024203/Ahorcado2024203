document.addEventListener('DOMContentLoaded', () => {
    const wordDisplay = document.getElementById('word');
    const hintDisplay = document.getElementById('hint');
    const gallowsImage = document.getElementById('gallows');
    const messageDisplay = document.getElementById('message');
    const timerDisplay = document.getElementById('timer');
    const keyboard = document.getElementById('keyboard');
    const startButton = document.getElementById('start');
    const pauseButton = document.getElementById('pause');
    const restartButton = document.getElementById('restart');
    const showHintButton = document.getElementById('showHint');

    let words = [];
    let currentWord = '';
    let currentHint = '';
    let maskedWord = [];
    let incorrectGuesses = 0;
    const maxErrors = 6;
    let timer = 60;
    let timerInterval = null;
    let gameActive = false;
    let isPaused = false;

    // Use contextPath from JSP
    const contextPath = window.contextPath || '';

    async function fetchWords() {
        try {
            const response = await fetch('Controlador?menu=PalabrasJuego');
            if (!response.ok) {
                throw new Error('Failed to fetch words from the server.');
            }
            words = await response.json();
            console.log('Palabras cargadas:', words); // Debug log to check data
            if (words.length > 0) {
                resetGame();
            } else {
                messageDisplay.textContent = 'No hay palabras disponibles para el juego.';
            }
        } catch (error) {
            console.error('Error fetching words:', error);
            messageDisplay.textContent = 'Error al cargar las palabras. Inténtalo de nuevo más tarde.';
        }
    }

    function startGame() {
        if (!gameActive && words.length > 0) {
            gameActive = true;
            isPaused = false;
            messageDisplay.textContent = '';
            updateGallowsImage(0);
            keyboard.querySelectorAll('.key').forEach(button => {
                button.disabled = false;
            });

            clearInterval(timerInterval);
            timer = 60;
            timerDisplay.textContent = `Tiempo: ${timer}s`;
            timerInterval = setInterval(() => {
                if (!isPaused && gameActive) {
                    timer--;
                    timerDisplay.textContent = `Tiempo: ${timer}s`;
                    if (timer <= 0) {
                        endGame(false);
                    }
                }
            }, 1000);
            startButton.disabled = true;
        } else if (words.length === 0) {
            messageDisplay.textContent = 'Cargando palabras, por favor espere...';
            fetchWords();
        }
    }

    function pauseGame() {
        if (gameActive) {
            if (!isPaused) {
                // Pause
                isPaused = true;
                clearInterval(timerInterval);
                keyboard.querySelectorAll('.key').forEach(button => {
                    button.disabled = true;
                });
                messageDisplay.textContent = 'Juego pausado. Presiona Pausar para continuar.';
                pauseButton.textContent = 'Continuar';
            } else {
                // Resume
                isPaused = false;
                timerInterval = setInterval(() => {
                    if (!isPaused && gameActive) {
                        timer--;
                        timerDisplay.textContent = `Tiempo: ${timer}s`;
                        if (timer <= 0) {
                            endGame(false);
                        }
                    }
                }, 1000);
                // Re-enable only letters that haven't been guessed yet
                keyboard.querySelectorAll('.key').forEach(button => {
                    const letter = button.getAttribute('data-letter');
                    if (letter && !maskedWord.includes(letter) && maskedWord.includes('_')) {
                        button.disabled = false;
                    }
                });
                messageDisplay.textContent = '';
                pauseButton.textContent = 'Pausar';
            }
        }
    }

    function resetGame() {
        if (words.length > 0) {
            const randomIndex = Math.floor(Math.random() * words.length);
            currentWord = words[randomIndex].palabra.toUpperCase();
            currentHint = words[randomIndex].pista;
            maskedWord = Array(currentWord.length).fill('_');
            wordDisplay.textContent = maskedWord.join(' ');
            hintDisplay.textContent = '';
            incorrectGuesses = 0;
            updateGallowsImage(0);
            messageDisplay.textContent = '¡Adivina la palabra!';
            keyboard.querySelectorAll('.key').forEach(button => {
                button.disabled = false;
            });
            clearInterval(timerInterval);
            timer = 60;
            timerDisplay.textContent = `Tiempo: ${timer}s`;
            gameActive = false;
            isPaused = false;
            startButton.disabled = false;
            pauseButton.textContent = 'Pausar';
        }
    }

    function updateGallowsImage(attempts) {
        const imgSrc = `${contextPath}/Images/intento${attempts}.png`;
        gallowsImage.src = imgSrc;
        gallowsImage.onerror = () => {
            console.error('Image failed to load:', imgSrc);
            gallowsImage.src = `${contextPath}/Images/fondo.png`; // Fallback
        };
    }

    function handleGuess(letter) {
        if (!gameActive || isPaused) return;

        const letterButton = document.querySelector(`.key[data-letter="${letter}"]`);
        if (letterButton) {
            letterButton.disabled = true;
        }

        if (currentWord.includes(letter)) {
            let updated = false;
            for (let i = 0; i < currentWord.length; i++) {
                if (currentWord[i] === letter) {
                    maskedWord[i] = letter;
                    updated = true;
                }
            }
            if (updated) {
                wordDisplay.textContent = maskedWord.join(' ');
                if (!maskedWord.includes('_')) {
                    endGame(true);
                }
            }
        } else {
            incorrectGuesses++;
            updateGallowsImage(incorrectGuesses);
            if (incorrectGuesses >= maxErrors) {
                endGame(false);
            }
        }
    }

    function endGame(win) {
        gameActive = false;
        isPaused = false;
        clearInterval(timerInterval);
        if (win) {
            messageDisplay.textContent = '¡Felicidades, ganaste!';
            messageDisplay.style.color = '#2ecc71';
        } else {
            messageDisplay.textContent = `¡Perdiste! La palabra era: ${currentWord}`;
            messageDisplay.style.color = '#e74c3c';
        }
        keyboard.querySelectorAll('.key').forEach(button => {
            button.disabled = true;
        });
        startButton.disabled = false;
        pauseButton.textContent = 'Pausar';
    }

    // Event Listeners
    startButton.addEventListener('click', startGame);
    pauseButton.addEventListener('click', pauseGame);
    restartButton.addEventListener('click', resetGame);
    showHintButton.addEventListener('click', () => {
        if (currentHint && (gameActive || !isPaused)) {
            hintDisplay.textContent = `Pista: ${currentHint}`;
        }
    });

    // Generate keyboard dynamically
    function createKeyboard() {
        const rows = ['QWERTYUIOP', 'ASDFGHJKLÑ', 'ZXCVBNM'];
        keyboard.innerHTML = '';
        rows.forEach(row => {
            const rowDiv = document.createElement('div');
            rowDiv.classList.add('key-row');
            for (const letter of row) {
                const button = document.createElement('button');
                button.classList.add('key');
                button.textContent = letter;
                button.setAttribute('data-letter', letter);
                button.addEventListener('click', () => {
                    handleGuess(letter);
                });
                rowDiv.appendChild(button);
            }
            keyboard.appendChild(rowDiv);
        });
    }
    
    // Initial setup
    createKeyboard();
    fetchWords();
});