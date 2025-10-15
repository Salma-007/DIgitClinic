package org.clinic.digitclinic.dao.interfaces;

import org.clinic.digitclinic.entity.Patient;

import java.util.List;

public interface PatientDAO extends GenericDAO<Patient> {
    Patient findByEmail(String email);
}
