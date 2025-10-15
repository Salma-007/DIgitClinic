package org.clinic.digitclinic.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.clinic.digitclinic.dao.ConsultationDAOImpl;
import org.clinic.digitclinic.dao.DocteurDAOImpl;
import org.clinic.digitclinic.dao.SalleDAOImpl;
import org.clinic.digitclinic.dao.interfaces.ConsultationDAO;
import org.clinic.digitclinic.dao.interfaces.DocteurDAO;
import org.clinic.digitclinic.dao.interfaces.SalleDAO;
import org.clinic.digitclinic.entity.*;
import org.clinic.digitclinic.entity.enums.Statut;
import org.clinic.digitclinic.exception.*;
import org.clinic.digitclinic.service.ConsultationServiceImpl;
import org.clinic.digitclinic.service.DocteurServiceImpl;
import org.clinic.digitclinic.service.SalleServiceImpl;

import java.io.IOException;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@WebServlet("/patient-space/*")
public class PatientEspaceServlet extends HttpServlet {
    private ConsultationServiceImpl consultationService;
    private DocteurServiceImpl docteurService;
    private SalleServiceImpl salleService;

    @Override
    public void init() throws ServletException {
        ConsultationDAO consultationDAO = new ConsultationDAOImpl();
        DocteurDAO docteurDAO = new DocteurDAOImpl();
        SalleDAO salleDAO = new SalleDAOImpl();

        this.consultationService = new ConsultationServiceImpl(consultationDAO);
        this.docteurService = new DocteurServiceImpl(docteurDAO);
        this.salleService = new SalleServiceImpl(salleDAO);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Personne user = (Personne) session.getAttribute("user");

        if (user == null || !user.getRole().toString().equals("PATIENT")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Patient patient = (Patient) user;

        try {
            if ("add-consultation".equals(action)) {
                addConsultation(request, response, patient);
            } else {
                response.sendRedirect("patient-space?error=Action non valide");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("new-consultation?error=" + e.getMessage());
        }
    }

    private void addConsultation(HttpServletRequest request, HttpServletResponse response, Patient patient)
            throws IOException {
        try {
            LocalDate date = LocalDate.parse(request.getParameter("date"));
            LocalTime heure = LocalTime.parse(request.getParameter("heure"));
            Statut statut = Statut.RESERVEE;
            int docteurId = Integer.parseInt(request.getParameter("docteurId"));
            int salleId = Integer.parseInt(request.getParameter("salleId"));
            String compteRendu = request.getParameter("compteRendu");

            Docteur docteur = docteurService.findById((long) docteurId);
            Salle salle = salleService.findById((long) salleId);

            if (docteur == null) throw new DocteurNotFoundException("Docteur introuvable");
            if (salle == null) throw new SalleNotFoundException("Salle introuvable");

            List<Consultation> consultationsExistantes = consultationService.findAll();

            boolean docteurOccupe = consultationsExistantes.stream()
                    .filter(c -> c.getDocteur().getId() == docteurId)
                    .filter(c -> c.getDate().equals(date))
                    .filter(c -> c.getHeure().equals(heure))
                    .filter(c -> c.getStatut() != Statut.ANNULEE)
                    .findAny()
                    .isPresent();

            if (docteurOccupe) {
                throw new DocteurOccupeException("Le docteur a déjà une consultation à " + heure);
            }

            boolean salleOccupee = consultationsExistantes.stream()
                    .filter(c -> c.getSalle().getIdSalle() == salleId)
                    .filter(c -> c.getDate().equals(date))
                    .filter(c -> c.getHeure().equals(heure))
                    .filter(c -> c.getStatut() != Statut.ANNULEE)
                    .findAny()
                    .isPresent();

            if (salleOccupee)
                throw new SalleOccupeeException("La salle est déjà occupée à " + heure);

            if (heure.getMinute() != 0 && heure.getMinute() != 30)
                throw new HeureInvalideException("Les consultations doivent commencer à l'heure ou à la demi-heure");

            if (heure.isBefore(LocalTime.of(9, 0)) || heure.isAfter(LocalTime.of(18, 0)))
                throw new HeureInvalideException("Les consultations doivent être entre 9h00 et 18h00");

            if (date.equals(LocalDate.now()) && heure.isBefore(LocalTime.now()))
                throw new HeureInvalideException("Heure invalide, choisissez une heure valide");

            Consultation consultation = new Consultation();
            consultation.setDate(date);
            consultation.setHeure(heure);
            consultation.setStatut(statut);
            consultation.setPatient(patient);
            consultation.setDocteur(docteur);
            consultation.setSalle(salle);
            consultation.setCompteRendu(compteRendu);

            consultationService.save(consultation);
            response.sendRedirect("patient-space/new-consultation?success=Consultation ajoutée avec succès");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/patient-space?action=new-consultation&error=" + URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Personne user = (Personne) session.getAttribute("user");

        if (user == null || !user.getRole().toString().equals("PATIENT")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Patient patient = (Patient) user;
        String action = request.getParameter("action");

        try {
            if (action == null) {
                showPatientHome(request, response, patient);
            } else {
                switch (action) {
                    case "home":
                        showPatientHome(request, response, patient);
                        break;
                    case "consultations":
                        showPatientConsultations(request, response, patient);
                        break;
                    case "new-consultation":
                        showNewConsultationForm(request, response, patient);
                        break;
                    default:
                        showPatientHome(request, response, patient);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("patient-space?error=" + e.getMessage());
        }
    }

    private void showPatientHome(HttpServletRequest request, HttpServletResponse response, Patient patient)
            throws ServletException, IOException {

        List<Consultation> consultations = consultationService.findByPatientId((long) patient.getId());

        long consultationsAujourdhui = consultations.stream()
                .filter(c -> c.getDate().equals(LocalDate.now()))
                .count();

        long consultationsProchaines = consultations.stream()
                .filter(c -> c.getDate().isAfter(LocalDate.now()) ||
                        (c.getDate().equals(LocalDate.now()) &&
                                c.getHeure().isAfter(LocalTime.now())))
                .filter(c -> c.getStatut() != Statut.ANNULEE)
                .count();

        request.setAttribute("patient", patient);
        request.setAttribute("consultations", consultations);
        request.setAttribute("consultationsAujourdhui", consultationsAujourdhui);
        request.setAttribute("consultationsProchaines", consultationsProchaines);
        request.setAttribute("totalConsultations", consultations.size());

        request.getRequestDispatcher("/views/patient/dashboard-patient.jsp").forward(request, response);
    }

    private void showPatientConsultations(HttpServletRequest request, HttpServletResponse response, Patient patient)
            throws ServletException, IOException {

        List<Consultation> consultations = consultationService.findByPatientId((long) patient.getId());

        request.setAttribute("patient", patient);
        request.setAttribute("consultations", consultations);

        request.getRequestDispatcher("/views/patient/mes-consultations.jsp").forward(request, response);
    }

    private void showNewConsultationForm(HttpServletRequest request, HttpServletResponse response, Patient patient)
            throws ServletException, IOException {

        List<Docteur> docteurs = docteurService.findAll();
        List<Salle> salles = salleService.findAll();

        request.setAttribute("patient", patient);
        request.setAttribute("docteurs", docteurs);
        request.setAttribute("salles", salles);
        request.setAttribute("statuts", Statut.values());

        request.getRequestDispatcher("/views/patient/nouvelle-consultation.jsp").forward(request, response);
    }

}
