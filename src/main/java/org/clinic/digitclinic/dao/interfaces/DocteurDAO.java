package org.clinic.digitclinic.dao.interfaces;

import org.clinic.digitclinic.entity.Docteur;

public interface DocteurDAO extends GenericDAO<Docteur>{
    Docteur findByEmail(String email);
}
