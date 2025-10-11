package org.clinic.digitclinic.dao;

import org.clinic.digitclinic.dao.interfaces.DepartementDAO;
import org.clinic.digitclinic.entity.Departement;

public class DepartementDAOImpl extends GenericDAOImpl<Departement> implements DepartementDAO {

    public DepartementDAOImpl() {
        super(Departement.class);
    }
}
