package org.clinic.digitclinic.dao.interfaces;

import org.clinic.digitclinic.entity.Consultation;

import java.util.List;

public interface ConsultationDAO extends GenericDAO<Consultation> {
    // pour les methodes specifiques
    List<Consultation> findByDocteur(Long docteurId);
}
