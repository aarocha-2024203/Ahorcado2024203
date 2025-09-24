package com.aarocha.hangman.controller;

public class CorreoInvalido extends RuntimeException {
    public CorreoInvalido(String message) {
        super(message);
    }
}