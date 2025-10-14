package org.clinic.digitclinic.service;

import org.clinic.digitclinic.dao.interfaces.DocteurDAO;
import org.clinic.digitclinic.entity.Docteur;
import org.clinic.digitclinic.service.interfaces.DocteurService;

import java.util.List;

public class DocteurServiceImpl implements DocteurService {
    private DocteurDAO dao ;

    public DocteurServiceImpl(DocteurDAO dao){
        this.dao = dao;
    }


    @Override
    public void save(Docteur doc) {
        System.out.println(doc.getRole().name());
        dao.save(doc);
    }

    @Override
    public void update(Docteur doc) {
        dao.update(doc);
    }

    @Override
    public void delete(Long id) {
        dao.delete(id);
    }

    @Override
    public Docteur findById(Long id) {
        return dao.findById(id);
    }

    @Override
    public List<Docteur> findAll() {
        return dao.findAll();
    }

    @Override
    public Docteur findByEmail(String email) {
        return dao.findByEmail(email);
    }
}
