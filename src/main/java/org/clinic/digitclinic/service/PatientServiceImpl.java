package org.clinic.digitclinic.service;

import org.clinic.digitclinic.entity.Patient;

public class PatientServiceImpl extends GenericServiceImpl<Patient> implements PatientService{
    public PatientServiceImpl() {
        super(Patient.class);
    }
}
