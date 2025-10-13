package org.clinic.digitclinic.service;

import org.clinic.digitclinic.dao.AuthDAOImpl;
import org.clinic.digitclinic.dao.interfaces.AuthDAO;
import org.clinic.digitclinic.entity.Personne;
import org.clinic.digitclinic.service.interfaces.AuthService;

public class AuthServiceImpl implements AuthService {
    private final AuthDAO authDAO = new AuthDAOImpl();

    @Override
    public Personne login(String email, String motDePasse) {

        if (email == null || motDePasse == null || email.isEmpty() || motDePasse.isEmpty()) {
            throw new IllegalArgumentException("Email et mot de passe sont obligatoires");
        }

        Personne user = authDAO.login(email, motDePasse);

        if (user == null) {
            throw new RuntimeException("Email ou mot de passe incorrect");
        }


        return user;
    }

}
