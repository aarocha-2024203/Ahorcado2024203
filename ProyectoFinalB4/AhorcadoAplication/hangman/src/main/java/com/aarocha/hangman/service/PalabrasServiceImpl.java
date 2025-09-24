package com.aarocha.hangman.service;

import com.aarocha.hangman.controller.ValidacionCorreo;
import com.aarocha.hangman.model.Palabras;
import com.aarocha.hangman.model.Usuarios;
import com.aarocha.hangman.repository.PalabrasRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PalabrasServiceImpl implements PalabrasService{

    private final PalabrasRepository palabrasRepository;

    public PalabrasServiceImpl(PalabrasRepository palabrasRepository) {
        this.palabrasRepository = palabrasRepository;
    }


    @Override
    public List<Palabras> getAllPalabras() {
        return palabrasRepository.findAll();
    }

    @Override
    public Palabras getPalabrasById(Integer id) {
        return palabrasRepository.findById(id).orElse(null);
    }

    @Override
    public Palabras savePalabras(Palabras palabras) {
        List<Palabras> lista = palabrasRepository.findAll();
        for (Palabras p : lista) {
            if (p.getPalabra().equalsIgnoreCase(palabras.getPalabra())) {
                palabras.setPalabra("Mensaje-Palabra");
                return palabras;
            }
            if (p.getPista().equalsIgnoreCase(palabras.getPista())) {
                palabras.setPista("Mensaje-Pista");
                return palabras;
            }
        }
        return palabrasRepository.save(palabras);
    }

    @Override
    public Palabras updatePalabras(Integer id, Palabras palabras) {
        Palabras existinPalabras = palabrasRepository.findById(id).orElse(null);
        if (existinPalabras != null) {
            List<Palabras> lista = palabrasRepository.findAll();
            for (Palabras p : lista) {
                if (!p.getId().equals(id)) {
                    if (p.getPalabra().equalsIgnoreCase(palabras.getPalabra())) {
                        palabras.setPalabra("Mensaje-Palabra");
                        return palabras;
                    }
                    if (p.getPista().equalsIgnoreCase(palabras.getPista())) {
                        palabras.setPista("Mensaje-Pista");
                        return palabras;
                    }
                }
            }
            existinPalabras.setPalabra(palabras.getPalabra());
            existinPalabras.setPista(palabras.getPista());
            return palabrasRepository.save(existinPalabras);
        }
        return null;
    }

    @Override
    public void deletePalabras(Integer id) {
        palabrasRepository.deleteById(id);
    }
}