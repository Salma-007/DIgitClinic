package org.clinic.digitclinic.dao;

import jakarta.persistence.TypedQuery;
import org.clinic.digitclinic.dao.interfaces.DocteurDAO;
import org.clinic.digitclinic.entity.Docteur;
import org.clinic.digitclinic.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;

import javax.print.Doc;
import java.util.List;

public class DocteurDAOImpl extends GenericDAOImpl<Docteur> implements DocteurDAO {
    public DocteurDAOImpl() {
        super(Docteur.class);
    }

    private Session getSession() {
        return HibernateUtil.getSessionFactory().openSession();
    }

    @Override
    public Docteur findByEmail(String email) {
        try {
            Session session = null;
            session = getSession();
            Query<Docteur> query = session.createQuery(
                    "FROM Docteur d WHERE d.email = :email", Docteur.class);
            query.setParameter("email", email);

            List<Docteur> result = query.getResultList();
            return result.isEmpty() ? null : result.get(0);

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
