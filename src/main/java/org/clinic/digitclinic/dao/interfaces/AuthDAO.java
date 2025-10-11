package org.clinic.digitclinic.dao.interfaces;

import org.clinic.digitclinic.entity.Personne;

public interface AuthDAO {
     Personne login(String email, String motDePasse);
}
