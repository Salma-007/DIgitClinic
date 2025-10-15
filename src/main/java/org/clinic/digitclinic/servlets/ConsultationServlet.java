package org.clinic.digitclinic.servlets;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.clinic.digitclinic.dao.ConsultationDAOImpl;
import org.clinic.digitclinic.dao.DocteurDAOImpl;
import org.clinic.digitclinic.dao.PatientDAOImpl;
import org.clinic.digitclinic.dao.SalleDAOImpl;
import org.clinic.digitclinic.dao.interfaces.ConsultationDAO;
import org.clinic.digitclinic.dao.interfaces.DocteurDAO;
import org.clinic.digitclinic.dao.interfaces.PatientDAO;
import org.clinic.digitclinic.dao.interfaces.SalleDAO;
import org.clinic.digitclinic.entity.Consultation;
import org.clinic.digitclinic.entity.Docteur;
import org.clinic.digitclinic.entity.Patient;
import org.clinic.digitclinic.entity.Salle;
import org.clinic.digitclinic.entity.enums.Statut;
import org.clinic.digitclinic.service.ConsultationServiceImpl;
import org.clinic.digitclinic.service.DocteurServiceImpl;
import org.clinic.digitclinic.service.PatientServiceImpl;
import org.clinic.digitclinic.service.SalleServiceImpl;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/consultations")
public class ConsultationServlet extends HelloServlet {
    private ConsultationServiceImpl consultationService;
    private PatientServiceImpl patientService;
    private DocteurServiceImpl docteurService;
    private SalleServiceImpl salleService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        ConsultationDAO consultationDAO = new ConsultationDAOImpl();
        PatientDAO patientDAO = new PatientDAOImpl();
        DocteurDAO docteurDAO = new DocteurDAOImpl();
        SalleDAO salleDAO = new SalleDAOImpl();

        this.consultationService = new ConsultationServiceImpl(consultationDAO);
        this.patientService = new PatientServiceImpl(patientDAO);
        this.docteurService = new DocteurServiceImpl(docteurDAO);
        this.salleService = new SalleServiceImpl(salleDAO);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String action = request.getParameter("action");

        try {
            if (action == null) {
                listConsultations(request, response);
            } else {
                switch (action) {
                    case "new":
                        showNewForm(request, response);
                        break;
//                    case "edit":
//                        showEditForm(request, response);
//                        break;
//                    case "delete":
//                        deleteConsultation(request, response);
//                        break;
//                    case "details":
//                        showConsultationDetails(request, response);
//                        break;
//                    case "updateStatus":
//                        showUpdateStatusForm(request, response);
//                        break;
                    default:
                        listConsultations(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        }
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Docteur> docteurs = docteurService.findAll();
            List<Salle> salles = salleService.findAll();
            List<Patient> patients = patientService.findAllPatients();

            request.setAttribute("docteurs", docteurs);
            request.setAttribute("salles", salles);
            request.setAttribute("patients", patients);
            request.setAttribute("statuts", Statut.values());

            request.getRequestDispatcher("/views/consultation/add-consultation.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("consultations?error=Erreur lors du chargement du formulaire: " + e.getMessage());
        }
    }

    private void listConsultations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Consultation> consultations = consultationService.findAll();
        List<Patient> patients = patientService.findAllPatients();
        List<Docteur> docteurs = docteurService.findAll();
        List<Salle> salles = salleService.findAll();

        Map<String, Object> stats = new HashMap<>();
        stats.put("totalConsultations", consultations.size());
        stats.put("consultationsReservees", consultations.stream()
                .filter(c -> c.getStatut() == Statut.RESERVEE).count());
        stats.put("consultationsValidees", consultations.stream()
                .filter(c -> c.getStatut() == Statut.VALIDEE).count());
        stats.put("consultationsTerminees", consultations.stream()
                .filter(c -> c.getStatut() == Statut.TERMINEE).count());
        stats.put("consultationsAnnulees", consultations.stream()
                .filter(c -> c.getStatut() == Statut.ANNULEE).count());
        stats.put("consultationsAujourdhui", consultations.stream()
                .filter(c -> c.getDate().equals(LocalDate.now())).count());

        request.setAttribute("consultations", consultations);
        request.setAttribute("patients", patients);
        request.setAttribute("docteurs", docteurs);
        request.setAttribute("salles", salles);
        request.setAttribute("stats", stats);
        request.setAttribute("statuts", Statut.values());

        request.getRequestDispatcher("/views/consultation/consultations.jsp").forward(request, response);
    }

    private void addConsultation(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            LocalDate date = LocalDate.parse(request.getParameter("date"));
            LocalTime heure = LocalTime.parse(request.getParameter("heure"));
            Statut statut = Statut.valueOf(request.getParameter("statut"));
            int patientId = Integer.parseInt(request.getParameter("patientId"));
            int docteurId = Integer.parseInt(request.getParameter("docteurId"));
            int salleId = Integer.parseInt(request.getParameter("salleId"));
            String compteRendu = request.getParameter("compteRendu");

            Patient patient = patientService.findById((long) patientId);
            Docteur docteur = docteurService.findById((long) docteurId);
            Salle salle = salleService.findById((long) salleId);

            if (patient == null || docteur == null || salle == null) {
                response.sendRedirect("consultations?action=new&error=Patient, docteur ou salle non trouvé");
                return;
            }

            List<Consultation> consultationsExistantes = consultationService.findAll();

            boolean docteurOccupe = consultationsExistantes.stream()
                    .filter(c -> c.getDocteur().getId() == docteurId)
                    .filter(c -> c.getDate().equals(date))
                    .filter(c -> c.getHeure().equals(heure))
                    .filter(c -> c.getStatut() != Statut.ANNULEE)
                    .findAny()
                    .isPresent();

            if (docteurOccupe) {
                response.sendRedirect("consultations?action=new&error=Le docteur a déjà une consultation à " + heure);
                return;
            }

            boolean salleOccupee = consultationsExistantes.stream()
                    .filter(c -> c.getSalle().getIdSalle() == salleId)
                    .filter(c -> c.getDate().equals(date))
                    .filter(c -> c.getHeure().equals(heure))
                    .filter(c -> c.getStatut() != Statut.ANNULEE)
                    .findAny()
                    .isPresent();

            if (salleOccupee) {
                response.sendRedirect("consultations?action=new&error=La salle est déjà occupée à " + heure);
                return;
            }

            if (heure.getMinute() != 0 && heure.getMinute() != 30) {
                response.sendRedirect("consultations?action=new&error=Les consultations doivent commencer à l'heure ou à la demi-heure");
                return;
            }

            if (heure.isBefore(LocalTime.of(9, 0)) || heure.isAfter(LocalTime.of(18, 0))) {
                response.sendRedirect("consultations?action=new&error=Les consultations doivent être entre 9h00 et 18h00");
                return;
            }

            Consultation consultation = new Consultation();
            consultation.setDate(date);
            consultation.setHeure(heure);
            consultation.setStatut(statut);
            consultation.setPatient(patient);
            consultation.setDocteur(docteur);
            consultation.setSalle(salle);
            consultation.setCompteRendu(compteRendu);

            consultationService.save(consultation);
            response.sendRedirect("consultations?success=Consultation ajoutée avec succès");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("consultations?action=new&error=Erreur lors de l'ajout: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add":
                    addConsultation(request, response);
                    break;
//                case "update":
//                    updateConsultation(request, response);
//                    break;
//                case "updateStatus":
//                    updateConsultationStatus(request, response);
//                    break;
                default:
                    listConsultations(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        }
    }
}