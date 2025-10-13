package org.clinic.digitclinic.service;

import jakarta.annotation.security.DeclareRoles;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;
import org.clinic.digitclinic.dao.interfaces.DepartementDAO;
import org.clinic.digitclinic.entity.Departement;
import org.clinic.digitclinic.entity.Docteur;
import org.clinic.digitclinic.service.interfaces.DepartementService;
import java.util.List;


public class DepartementServiceImpl implements DepartementService {

    private DepartementDAO departementDAO;

    public DepartementServiceImpl(DepartementDAO dao){
        this.departementDAO = dao;
    }

    @Override
    public void save(Departement p) {
        departementDAO.save(p);
    }

    @Override
    public void update(Departement p) {
        departementDAO.update(p);
    }

    @Override
    public void delete(Long id) {
        departementDAO.delete(id);
    }

    @Override
    public Departement findById(Long id) {
        return departementDAO.findById(id);
    }

    @Override
    public List<Departement> findAll() {
        return departementDAO.findAll();
    }

    @Override
    public Departement findByNom(String nom) {
        return departementDAO.findByNom(nom);
    }

    @Override
    public List<Docteur> findByDepartementId(Long departementId) {
        return departementDAO.findByDepartementId(departementId);
    }
}
