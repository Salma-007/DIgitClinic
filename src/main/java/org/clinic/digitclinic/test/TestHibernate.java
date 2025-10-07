package org.clinic.digitclinic.test;

import org.clinic.digitclinic.entity.Personne;
import org.clinic.digitclinic.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class TestHibernate {
    public static void main(String[] args) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = session.beginTransaction();

        Personne user = new Personne("Salma", "allai","salma@example.com", "1234");
        session.persist(user);

        tx.commit();
        session.close();

        System.out.println("✅ Utilisateur enregistré avec succès !");
    }
}