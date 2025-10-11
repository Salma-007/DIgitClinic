package org.clinic.digitclinic.service.interfaces;

import org.clinic.digitclinic.entity.Docteur;

import java.util.List;

public interface DocteurService {
    void save(Docteur docteur);
    void update(Docteur docteur);
    void delete(Long id);
    Docteur findById(Long id);
    List<Docteur> findAll();
}
