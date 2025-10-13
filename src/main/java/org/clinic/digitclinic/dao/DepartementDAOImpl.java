package org.clinic.digitclinic.dao;

import org.clinic.digitclinic.dao.interfaces.DepartementDAO;
import org.clinic.digitclinic.entity.Departement;
import org.clinic.digitclinic.entity.Docteur;
import org.clinic.digitclinic.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

public class DepartementDAOImpl extends GenericDAOImpl<Departement> implements DepartementDAO {

    public DepartementDAOImpl() {
        super(Departement.class);
    }

    private Session getSession() {
        return HibernateUtil.getSessionFactory().openSession();
    }

    @Override
    public Departement findByNom(String nom) {
        try{
            Session session = null;
            session = getSession();
            Query<Departement> query = session.createQuery(
                    "FROM Departement WHERE nom = :nom", Departement.class);
            query.setParameter("nom", nom);

            Departement departement = query.uniqueResult();

            return departement;
        } catch (Exception e) {
            System.err.println("Erreur recherche département par nom: " + e.getMessage());
            throw new RuntimeException("Erreur lors de la recherche du département par nom", e);
        }
    }

    @Override
    public List<Docteur> findByDepartementId(Long departementId) {
        try{
            Session session = null;
            session = getSession();
            Query<Docteur> query = session.createQuery(
                    "FROM Docteur d WHERE d.departement.id = :departementId", Docteur.class);
            query.setParameter("departementId", departementId);

            List<Docteur> docteurs = query.list();

            return docteurs;
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche des médecins par département", e);
        }
    }
}
