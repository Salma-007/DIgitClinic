package org.clinic.digitclinic.service;

import org.clinic.digitclinic.dao.GenericDAO;
import org.clinic.digitclinic.dao.GenericDAOImpl;

import java.util.List;

public class GenericServiceImpl<T> implements GenericService<T>{

    protected final GenericDAO<T> genericDAO;

    public GenericServiceImpl(Class<T> entityClass) {
        this.genericDAO = new GenericDAOImpl<>(entityClass);
    }

    @Override
    public void save(T entity) {
        genericDAO.save(entity);
    }

    @Override
    public T findById(Long id) {
        return genericDAO.findById(id);
    }

    @Override
    public List<T> findAll() {
        return genericDAO.findAll();
    }

    @Override
    public void update(T entity) {
        genericDAO.update(entity);
    }

    @Override
    public void delete(Long id) {
        genericDAO.delete(id);
    }
}
