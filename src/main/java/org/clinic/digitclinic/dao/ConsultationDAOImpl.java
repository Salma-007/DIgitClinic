package org.clinic.digitclinic.dao;

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
}
