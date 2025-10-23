package org.clinic.digitclinic.service.interfaces;

import org.clinic.digitclinic.entity.Consultation;
import java.util.List;

public interface ConsultationService {
    void save(Consultation consultation);
    void update(Consultation consultation);
    void delete(Long id);
    Consultation findById(Long id);
    List<Consultation> findAll();
    List<Consultation> findByPatientId(Long patientId);
    List<Consultation> findByDoctor(Long doctorId);
    int countByPatientId(Long patientId);
}
