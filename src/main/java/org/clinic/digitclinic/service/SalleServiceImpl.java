package org.clinic.digitclinic.service;

import org.clinic.digitclinic.dao.interfaces.SalleDAO;
import org.clinic.digitclinic.entity.Salle;
import org.clinic.digitclinic.service.interfaces.SalleService;

import java.util.List;

public class SalleServiceImpl implements SalleService {
    private SalleDAO dao;

    public SalleServiceImpl(SalleDAO dao){
        this.dao = dao;
    }

    @Override
    public void save(Salle salle) {
        dao.save(salle);
    }

    @Override
    public void update(Salle salle) {
        dao.update(salle);
    }

    @Override
    public void delete(Long id) {
        dao.delete(id);
    }

    @Override
    public Salle findById(Long id) {
        return dao.findById(id);
    }

    @Override
    public List<Salle> findAll() {
        return dao.findAll();
    }
}
