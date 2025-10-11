package org.clinic.digitclinic.dao;

import org.clinic.digitclinic.dao.interfaces.AuthDAO;
import org.clinic.digitclinic.entity.Personne;
import org.clinic.digitclinic.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class AuthDAOImpl implements AuthDAO {
    @Override
    public Personne login(String email, String motDePasse) {
        Personne user = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Personne> query = session.createQuery(
                    "FROM Personne p WHERE p.email = :email AND p.motDePasse = :motDePasse", Personne.class);
            query.setParameter("email", email);
            query.setParameter("motDePasse", motDePasse);
            user = query.uniqueResult();
            System.out.println("Utilisateur trouvé:5555555");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

}
