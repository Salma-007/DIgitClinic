package org.clinic.digitclinic.service.interfaces;
import org.clinic.digitclinic.entity.Patient;

import java.util.List;

public interface PatientService {
    void save(Patient patient);
    void update(Patient patient);
    void delete(Long id);
    Patient findById(Long id);
    List<Patient> findAllPatients();
    Patient findByEmail(String email);
}
