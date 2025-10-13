package org.clinic.digitclinic.service;

import org.clinic.digitclinic.dao.interfaces.PatientDAO;
import org.clinic.digitclinic.entity.Patient;
import org.clinic.digitclinic.entity.Personne;
import org.clinic.digitclinic.service.interfaces.PatientService;

import java.util.List;
import java.util.stream.Collectors;

public class PatientServiceImpl implements PatientService {

    private PatientDAO dao;
    public PatientServiceImpl(PatientDAO dao) {
        this.dao = dao;
    }

    @Override
    public void save(Patient patient) {
        dao.save(patient);
    }

    @Override
    public void update(Patient patient) {
        dao.update(patient);
    }

    @Override
    public void delete(Long id) {
        dao.delete(id);
    }

    @Override
    public Patient findById(Long id) {
        return dao.findById(id);
    }

    @Override
    public List<Patient> findAllPatients() {
        List<? extends Personne> personnes = dao.findAll();
        List<Patient> patients = personnes.stream()
                .filter(personne -> "PATIENT".equalsIgnoreCase(personne.getRole().toString()))
                .map(personne -> (Patient) personne)
                .collect(Collectors.toList());
        return patients;
    }


}
