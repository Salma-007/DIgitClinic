package org.clinic.digitclinic.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.*;
import java.util.ArrayList;

@Entity
@Table(name = "docteur")
public class Docteur extends Personne{

    @Column(columnDefinition = "TEXT")
    private String specialite;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "iddepartement", nullable = false)
    private Departement departement;

    private ArrayList<Consultation> planning;

    public Docteur(int id, String nom, String prenom, String email, String mdp, String specialite, Departement departement, ArrayList<Consultation> planning) {
        super(id, nom, prenom, email, mdp);
        this.specialite = specialite;
        this.departement = departement;
        this.planning = planning;
    }

    public Docteur(){}

    public Docteur(String specialite, Departement departement, ArrayList<Consultation> planning) {
        this.specialite = specialite;
        this.departement = departement;
        this.planning = planning;
    }


    public String getSpecialite() {
        return specialite;
    }

    public void setSpecialite(String specialite) {
        this.specialite = specialite;
    }

    public Departement getDepartement() {
        return departement;
    }

    public void setDepartement(Departement departement) {
        this.departement = departement;
    }

    public ArrayList<Consultation> getPlanning() {
        return planning;
    }

    public void setPlanning(ArrayList<Consultation> planning) {
        this.planning = planning;
    }
}
