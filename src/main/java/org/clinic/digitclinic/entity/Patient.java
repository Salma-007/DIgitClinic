package org.clinic.digitclinic.entity;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Column;
import jakarta.persistence.Table;
import org.clinic.digitclinic.entity.enums.Role;

import java.util.ArrayList;

@Entity
@Table(name = "Patient")
public class Patient extends Personne{

    @Column(nullable = false)
    private float poid;

    @Column(nullable = false)
    private float taille;

    private ArrayList<Consultation> consultations;

    public Patient(int id, String nom, String prenom, String email, String mdp, float poid, float taille, ArrayList<Consultation> consultations) {
        super(id, nom, prenom, email, mdp, Role.PATIENT);
        this.poid = poid;
        this.taille = taille;
        this.consultations = consultations;
    }

    public Patient(String nom, String prenom, String email, String mdp, float poid, float taille) {
        super(nom, prenom, email, mdp, Role.PATIENT);
        this.poid = poid;
        this.taille = taille;
    }

    public Patient() {

    }

    public float getPoid() {
        return poid;
    }

    public void setPoid(float poid) {
        this.poid = poid;
    }

    public float getTaille() {
        return taille;
    }

    public void setTaille(float taille) {
        this.taille = taille;
    }

    public ArrayList<Consultation> getConsultations() {
        return consultations;
    }

    public void setConsultations(ArrayList<Consultation> consultations) {
        this.consultations = consultations;
    }
}
