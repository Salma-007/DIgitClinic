package org.clinic.digitclinic.dao;

import org.clinic.digitclinic.dao.interfaces.DocteurDAO;
import org.clinic.digitclinic.entity.Docteur;

import javax.print.Doc;

public class DocteurDAOImpl extends GenericDAOImpl<Docteur> implements DocteurDAO {
    public DocteurDAOImpl() {
        super(Docteur.class);
    }
}
