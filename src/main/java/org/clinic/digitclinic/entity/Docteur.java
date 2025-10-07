package org.clinic.digitclinic.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.*;
import java.util.ArrayList;

@Entity
@Table(name = "docteur")
public class Docteur {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iddocteur")
    private int idDocteur;

    @Column(columnDefinition = "TEXT")
    private String specialite;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "iddepartement", nullable = false)
    private Departement departement;

    private ArrayList<Consultation> planning;

    public Docteur(int idDocteur, String specialite, Departement departement, ArrayList<Consultation> planning) {
        this.idDocteur = idDocteur;
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


    public int getIdDocteur() {
        return idDocteur;
    }

    public void setIdDocteur(int idDocteur) {
        this.idDocteur = idDocteur;
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
