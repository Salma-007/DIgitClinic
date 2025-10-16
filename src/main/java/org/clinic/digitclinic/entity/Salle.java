package org.clinic.digitclinic.entity;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import jakarta.persistence.*;

@Entity
@Table(name = "salle")
public class Salle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idsalle")
    private int idSalle;

    @Column(name = "nomsalle", nullable = false)
    private String nomSalle;

    @Column(nullable = false)
    private int capacite;

    @ElementCollection
    @CollectionTable(
            name = "salle_creneaux",
            joinColumns = @JoinColumn(name = "idsalle")
    )
    @Column(name = "creneau_date")
    private List<LocalDate> creneaux = new ArrayList<>();

    public Salle() {}

    public Salle(String nomSalle, int capacite) {
        this.nomSalle = nomSalle;
        this.capacite = capacite;
    }

    public Salle(String nomSalle, int capacite, List<LocalDate> creneaux) {
        this.nomSalle = nomSalle;
        this.capacite = capacite;
        this.creneaux = new ArrayList<>();
    }

    public Salle(int idSalle, String nomSalle, int capacite, List<LocalDate> creneaux) {
        this.idSalle = idSalle;
        this.nomSalle = nomSalle;
        this.capacite = capacite;
        this.creneaux = new ArrayList<>();
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

    public List<LocalDate> getCreneaux() {
        return creneaux;
    }

    public void setCreneaux(List<LocalDate> creneaux) {
        this.creneaux = creneaux;
    }

    public void addCreneau(LocalDate creneau) {
        if (this.creneaux == null) {
            this.creneaux = new ArrayList<>();
        }
        this.creneaux.add(creneau);
    }

    public void removeCreneau(LocalDate creneau) {
        if (this.creneaux != null) {
            this.creneaux.remove(creneau);
        }
    }


}
