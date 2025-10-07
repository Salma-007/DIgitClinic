package org.clinic.digitclinic.entity;

import java.time.LocalDate;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Column;
import jakarta.persistence.Table;

@Entity
@Table(name = "Salle")
public class Salle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idSalle;

    @Column(nullable = false)
    private String nomSalle;

    @Column(nullable = false)
    private int capacite;

    private LocalDate creneau;

    public Salle(int idSalle, String nomSalle, int capacite, LocalDate creneau) {
        this.idSalle = idSalle;
        this.nomSalle = nomSalle;
        this.capacite = capacite;
        this.creneau = creneau;
    }

    public Salle(String nomSalle, int capacite, LocalDate creneau) {
        this.nomSalle = nomSalle;
        this.capacite = capacite;
        this.creneau = creneau;
    }

    public int getIdSalle() {
        return idSalle;
    }

    public void setIdSalle(int idSalle) {
        this.idSalle = idSalle;
    }

    public String getNomSalle() {
        return nomSalle;
    }

    public void setNomSalle(String nomSalle) {
        this.nomSalle = nomSalle;
    }

    public int getCapacite() {
        return capacite;
    }

    public void setCapacite(int capacite) {
        this.capacite = capacite;
    }

    public LocalDate getCreneau() {
        return creneau;
    }

    public void setCreneau(LocalDate creneau) {
        this.creneau = creneau;
    }
}
