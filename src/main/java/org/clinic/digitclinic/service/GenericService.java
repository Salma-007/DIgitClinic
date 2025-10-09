package org.clinic.digitclinic.service;

import java.util.List;

public interface GenericService<T> {
    void save(T entity);
    T findById(Long id);
    List<T> findAll();
    void update(T entity);
    void delete(Long id);
}
