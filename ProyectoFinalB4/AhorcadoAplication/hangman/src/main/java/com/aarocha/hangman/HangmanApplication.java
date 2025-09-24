// Alejandro José Arocha Virula 2024203

package com.aarocha.hangman;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class HangmanApplication implements CommandLineRunner {

	public static void main(String[] args) {
            SpringApplication.run(HangmanApplication.class, args);
	}

    @Override
    public void run(String... args) throws Exception {
        System.out.println("Api funciona");
    }
}
