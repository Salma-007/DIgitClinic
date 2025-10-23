package org.clinic.digitclinic.dao;

import org.clinic.digitclinic.dao.interfaces.ConsultationDAO;
import org.clinic.digitclinic.entity.Consultation;
import org.clinic.digitclinic.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

public class ConsultationDAOImpl extends GenericDAOImpl<Consultation> implements ConsultationDAO {

    public ConsultationDAOImpl() {
        super(Consultation.class);
    }


    @Override
    public List<Consultation> findByDocteur(Long docteurId) {
        try(Session session = HibernateUtil.getSessionFactory().openSession()){
            String hql = "From Consultation c where c.docteur.id = :docteurId";
            Query<Consultation> query = session.createQuery(hql, Consultation.class);
            query.setParameter("docteurId", docteurId);
            return query.getResultList();
        }
    }

    @Override
    public List<Consultation> findByPatientId(Long patientId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT c FROM Consultation c " +
                    "LEFT JOIN FETCH c.patient " +
                    "LEFT JOIN FETCH c.docteur " +
                    "LEFT JOIN FETCH c.salle " +
                    "WHERE c.patient.id = :patientId " +
                    "ORDER BY c.date DESC, c.heure DESC";

            Query<Consultation> query = session.createQuery(hql, Consultation.class);
            query.setParameter("patientId", patientId);

            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }

    @Override
    public int countByPatientId(Long patientId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT COUNT(c) FROM Consultation c WHERE c.patient.id = :patientId";
            Long count = session.createQuery(hql, Long.class)
                    .setParameter("patientId", patientId)
                    .uniqueResult();
            return count != null ? count.intValue() : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}
