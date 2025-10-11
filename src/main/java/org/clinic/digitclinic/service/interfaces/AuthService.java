package org.clinic.digitclinic.service.interfaces;

import org.clinic.digitclinic.entity.Personne;

public interface AuthService {
    Personne login(String email, String motDePasse);
}
