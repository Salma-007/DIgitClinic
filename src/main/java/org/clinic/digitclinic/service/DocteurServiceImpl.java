package org.clinic.digitclinic.service;

import org.clinic.digitclinic.entity.Docteur;

public class DocteurServiceImpl extends GenericServiceImpl<Docteur> implements DocteurService{
    public DocteurServiceImpl() {
        super(Docteur.class);
    }
}
