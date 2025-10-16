package org.clinic.digitclinic.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.*;
import org.clinic.digitclinic.entity.enums.Role;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "docteur")
public class Docteur extends Personne{

    @Column(columnDefinition = "TEXT")
    private String specialite;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "iddepartement", nullable = false)
    private Departement departement;

    @OneToMany(mappedBy = "docteur", fetch = FetchType.EAGER)
    private List<Consultation> planning = new ArrayList<>();

    public Docteur(int id, String nom, String prenom, String email, String mdp, String specialite, Departement departement, ArrayList<Consultation> planning) {
        super(id, nom, prenom, email, mdp, Role.DOCTEUR);
        this.specialite = specialite;
        this.departement = departement;
        this.planning = planning;
    }

    public Docteur(){}

    public Docteur(String nom, String prenom, String email, String mdp,String specialite, Departement departement, ArrayList<Consultation> planning) {
        super(nom, prenom, email, mdp, Role.DOCTEUR);
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

    public List<Consultation> getPlanning() {
        return planning;
    }

    public void setPlanning(ArrayList<Consultation> planning) {
        this.planning = planning;
    }
}
