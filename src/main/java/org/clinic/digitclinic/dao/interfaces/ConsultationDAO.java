package org.clinic.digitclinic.dao.interfaces;

import org.clinic.digitclinic.entity.Consultation;

import java.util.List;

public interface ConsultationDAO extends GenericDAO<Consultation> {
    List<Consultation> findByDocteur(Long docteurId);
    List<Consultation> findByPatientId(Long patientId);
    int countByPatientId(Long patientId);
}
