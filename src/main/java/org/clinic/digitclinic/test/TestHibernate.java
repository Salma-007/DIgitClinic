package org.clinic.digitclinic.test;

import org.clinic.digitclinic.dao.DepartementDAOImpl;
import org.clinic.digitclinic.dao.PatientDAOImpl;
import org.clinic.digitclinic.dao.interfaces.DepartementDAO;
import org.clinic.digitclinic.dao.interfaces.PatientDAO;
import org.clinic.digitclinic.entity.Departement;
import org.clinic.digitclinic.entity.Patient;
import org.clinic.digitclinic.entity.Personne;
import org.clinic.digitclinic.dao.SalleDAOImpl;
import org.clinic.digitclinic.entity.Salle;
import org.clinic.digitclinic.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.time.LocalDate;

public class TestHibernate {
    public static void main(String[] args) {

        PatientDAO patientDAO =  new PatientDAOImpl();

        Patient p = new Patient("allali", "taha", "taha@gmail.com", "1234", 30, 120);

        try{
            patientDAO.save(p);
        }catch(Exception e){
            System.err.println("Erreur -> " + e.getMessage());
            e.printStackTrace();
        }


        System.out.println("patient ajouté avec succès !");
    }
}