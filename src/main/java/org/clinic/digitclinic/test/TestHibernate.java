package org.clinic.digitclinic.test;

import org.clinic.digitclinic.entity.Personne;
import org.clinic.digitclinic.dao.SalleDAOImpl;
import org.clinic.digitclinic.entity.Salle;
import org.clinic.digitclinic.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.time.LocalDate;

public class TestHibernate {
    public static void main(String[] args) {
        SalleDAOImpl salleDAO = new SalleDAOImpl();
        Salle salle1 = new Salle("Salle B", 10);
        salleDAO.save(salle1);
        System.out.println("Salle ajoutée avec succès !");
    }
}