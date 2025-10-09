package org.clinic.digitclinic.entity;
import jakarta.persistence.*;

@Entity
@Table(name = "personne")
@Inheritance(strategy = InheritanceType.JOINED)
public class Personne {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false)
    private String nom;

    @Column(nullable = false)
    private String prenom;

    @Column(nullable = false)
    private String email;

    @Column(nullable = false)
    private String motDePasse;


    public Personne(){

    }

    public Personne(int id, String nom, String prenom, String email, String mdp){
        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.motDePasse = mdp;
    }

    public Personne( String nom, String prenom, String email, String mdp){
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.motDePasse = mdp;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMdp() {
        return motDePasse;
    }

    public void setMdp(String mdp) {
        this.motDePasse = mdp;
    }
}
