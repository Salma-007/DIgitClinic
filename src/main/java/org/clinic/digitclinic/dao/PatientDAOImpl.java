package org.clinic.digitclinic.dao;

import org.clinic.digitclinic.dao.interfaces.PatientDAO;
import org.clinic.digitclinic.entity.Patient;
import org.clinic.digitclinic.entity.Personne;

import java.util.List;

public class PatientDAOImpl extends GenericDAOImpl<Patient> implements PatientDAO {

    public PatientDAOImpl() {
        super(Patient.class);
    }

}
