package org.clinic.digitclinic.service.interfaces;

import org.clinic.digitclinic.entity.Salle;

import java.util.List;

public interface SalleService {
    void save(Salle salle);
    void update(Salle salle);
    void delete(Long id);
    Salle findById(Long id);
    List<Salle> findAll();
}
