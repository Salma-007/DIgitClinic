package org.clinic.digitclinic.dao;

import org.clinic.digitclinic.entity.Salle;

public class SalleDAOImpl extends GenericDAOImpl<Salle> implements SalleDAO {
    public SalleDAOImpl() {
        super(Salle.class);
    }
}
