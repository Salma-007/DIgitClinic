package org.clinic.digitclinic.entity;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "departement")
public class Departement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String nom;

    @OneToMany(mappedBy = "departement", fetch = FetchType.EAGER)
    private List<Docteur> docteurs = new ArrayList<>();

    public Departement() {

    }

    public Departement(String nom) {
        this.nom = nom;
    }


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public List<Docteur> getDocteurs() {
        return docteurs;
    }

    public void setDocteurs(List<Docteur> docteurs) {
        if (docteurs != null) {
            this.docteurs = docteurs;
        }
    }

    public void addDocteur(Docteur docteur) {
        if (docteur != null && !this.docteurs.contains(docteur)) {
            this.docteurs.add(docteur);
            docteur.setDepartement(this);
        }
    }

    public void removeDocteur(Docteur docteur) {
        if (docteur != null) {
            this.docteurs.remove(docteur);
            docteur.setDepartement(null);
        }
    }

    @Override
    public String toString() {
        return "Departement{id=" + id + ", nom='" + nom + "'}";
    }
}