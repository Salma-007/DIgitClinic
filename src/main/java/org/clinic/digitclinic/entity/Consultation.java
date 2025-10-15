package org.clinic.digitclinic.entity;

import jakarta.persistence.Entity;
import org.clinic.digitclinic.entity.enums.Statut;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

@Entity
@Table(name = "consultation")
public class Consultation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idconsultation")
    private int idConsultation;

    @Column(name = "date_consultation", nullable = false)
    private LocalDate date;

    @Column(name = "heureconsultation", nullable = false)
    private LocalTime heure;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Statut statut;

    @Column(columnDefinition = "TEXT")
    private String compteRendu;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "idpatient", nullable = false)
    private Patient patient;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "iddocteur", nullable = false)
    private Docteur docteur;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "idsalle", nullable = false)
    private Salle salle;

    public Consultation() {}

    public Consultation(LocalDate date, LocalTime heure, Statut statut, Patient patient, Docteur docteur, Salle salle) {
        this.date = date;
        this.heure = heure;
        this.statut = statut;
        this.patient = patient;
        this.docteur = docteur;
        this.salle = salle;
    }

    public int getIdConsultation() {
        return idConsultation;
    }

    public void setIdConsultation(int idConsultation) {
        this.idConsultation = idConsultation;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public LocalTime getHeure() {
        return heure;
    }

    public void setHeure(LocalTime heure) {
        this.heure = heure;
    }

    public Statut getStatut() {
        return statut;
    }

    public void setStatut(Statut statut) {
        this.statut = statut;
    }

    public String getCompteRendu() {
        return compteRendu;
    }

    public void setCompteRendu(String compteRendu) {
        this.compteRendu = compteRendu;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public Docteur getDocteur() {
        return docteur;
    }

    public void setDocteur(Docteur docteur) {
        this.docteur = docteur;
    }

    public Salle getSalle() {
        return salle;
    }

    public void setSalle(Salle salle) {
        this.salle = salle;
    }
}
