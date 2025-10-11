package org.clinic.digitclinic.service.interfaces;

import org.clinic.digitclinic.entity.Departement;

import java.util.List;

public interface DepartementService{
    void save(Departement p);
    void update(Departement p);
    void delete(Long id);
    Departement findById(Long id);
    List<Departement> findAll();
}
