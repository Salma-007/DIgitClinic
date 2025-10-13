package org.clinic.digitclinic.dao.interfaces;

import org.clinic.digitclinic.entity.Departement;
import org.clinic.digitclinic.entity.Docteur;

import java.util.List;

public interface DepartementDAO extends GenericDAO<Departement> {
    Departement findByNom(String nom);
    List<Docteur> findByDepartementId(Long departementId);
}
