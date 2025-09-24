package com.aarocha.hangman.repository;

import com.aarocha.hangman.model.Palabras;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PalabrasRepository extends JpaRepository<Palabras, Integer> {
}