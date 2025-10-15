package org.clinic.digitclinic.dao;

import org.clinic.digitclinic.dao.interfaces.PatientDAO;
import org.clinic.digitclinic.entity.Docteur;
import org.clinic.digitclinic.entity.Patient;
import org.clinic.digitclinic.entity.Personne;
import org.clinic.digitclinic.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

public class PatientDAOImpl extends GenericDAOImpl<Patient> implements PatientDAO {

    public PatientDAOImpl() {
        super(Patient.class);
    }

    private Session getSession() {
        return HibernateUtil.getSessionFactory().openSession();
    }

    @Override
    public Patient findByEmail(String email) {
        try {
            Session session = null;
            session = getSession();
            Query<Patient> query = session.createQuery(
                    "FROM Patient d WHERE d.email = :email", Patient.class);
            query.setParameter("email", email);

            List<Patient> result = query.getResultList();
            return result.isEmpty() ? null : result.get(0);

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
