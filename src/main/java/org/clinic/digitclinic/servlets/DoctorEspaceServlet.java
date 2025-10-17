package org.clinic.digitclinic.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.clinic.digitclinic.dao.ConsultationDAOImpl;
import org.clinic.digitclinic.dao.DocteurDAOImpl;
import org.clinic.digitclinic.dao.interfaces.ConsultationDAO;
import org.clinic.digitclinic.dao.interfaces.DocteurDAO;
import org.clinic.digitclinic.entity.Consultation;
import org.clinic.digitclinic.entity.Docteur;
import org.clinic.digitclinic.entity.Personne;
import org.clinic.digitclinic.entity.enums.Statut;
import org.clinic.digitclinic.exception.ConsultationNotFoundException;
import org.clinic.digitclinic.service.ConsultationServiceImpl;
import org.clinic.digitclinic.service.DocteurServiceImpl;

import java.io.IOException;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@WebServlet("/doctor-space/*")
public class DoctorEspaceServlet extends HttpServlet {
    private ConsultationServiceImpl consultationService;
    private DocteurServiceImpl docteurService;

    @Override
    public void init() throws ServletException {
        ConsultationDAO consultationDAO = new ConsultationDAOImpl();
        DocteurDAO docteurDAO = new DocteurDAOImpl();

        this.consultationService = new ConsultationServiceImpl(consultationDAO);
        this.docteurService = new DocteurServiceImpl(docteurDAO);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Personne user = (Personne) session.getAttribute("user");

        if (user == null || !user.getRole().toString().equals("DOCTEUR")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Docteur docteur = (Docteur) user;

        try {
            if ("update-statut".equals(action)) {
                updateStatutConsultation(request, response, docteur);
            }
            else if ("cancel-consultation".equals(action)) {
                cancelConsultationDoctor(request, response, docteur);
            } else {
                response.sendRedirect("doctor-space?error=Action non valide");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("doctor-space?error=" + URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Personne user = (Personne) session.getAttribute("user");

        if (user == null || !user.getRole().toString().equals("DOCTEUR")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Docteur docteur = (Docteur) user;
        String action = request.getParameter("action");

        try {
            if (action == null) {
                showDoctorDashboard(request, response, docteur);
            } else {
                switch (action) {
                    case "dashboard":
                        showDoctorDashboard(request, response, docteur);
                        break;
                    case "consultations":
                        showDoctorConsultations(request, response, docteur);
                        break;
                    case "today":
                        showTodayConsultations(request, response, docteur);
                        break;
                    default:
                        showDoctorDashboard(request, response, docteur);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("doctor-space?error=" + e.getMessage());
        }
    }

    private void showDoctorDashboard(HttpServletRequest request, HttpServletResponse response, Docteur docteur)
            throws ServletException, IOException {

        List<Consultation> consultations = consultationService.findByDoctor((long) docteur.getId());

        long consultationsAujourdhui = consultations.stream()
                .filter(c -> c.getDate().equals(LocalDate.now()))
                .count();

        long consultationsReservees = consultations.stream()
                .filter(c -> c.getStatut() == Statut.RESERVEE)
                .count();

        long consultationsValidees = consultations.stream()
                .filter(c -> c.getStatut() == Statut.VALIDEE)
                .count();

        long consultationsTerminees = consultations.stream()
                .filter(c -> c.getStatut() == Statut.TERMINEE)
                .count();

        List<Consultation> consultationsToday = consultations.stream()
                .filter(c -> c.getDate().equals(LocalDate.now()))
                .filter(c -> c.getStatut() != Statut.ANNULEE)
                .sorted((c1, c2) -> c1.getHeure().compareTo(c2.getHeure()))
                .toList();

        request.setAttribute("docteur", docteur);
        request.setAttribute("consultations", consultations);
        request.setAttribute("consultationsToday", consultationsToday);
        request.setAttribute("consultationsAujourdhui", consultationsAujourdhui);
        request.setAttribute("consultationsReservees", consultationsReservees);
        request.setAttribute("consultationsValidees", consultationsValidees);
        request.setAttribute("consultationsTerminees", consultationsTerminees);
        request.setAttribute("totalConsultations", consultations.size());

        request.getRequestDispatcher("/views/docteur/dashboard-doctor.jsp").forward(request, response);
    }

    private void showDoctorConsultations(HttpServletRequest request, HttpServletResponse response, Docteur docteur)
            throws ServletException, IOException {

        List<Consultation> consultations = consultationService.findByDoctor((long) docteur.getId());

        List<Consultation> consultationsTriees = consultations.stream()
                .sorted((c1, c2) -> {
                    int dateCompare = c2.getDate().compareTo(c1.getDate());
                    if (dateCompare != 0) return dateCompare;
                    return c1.getHeure().compareTo(c2.getHeure());
                })
                .toList();

        request.setAttribute("docteur", docteur);
        request.setAttribute("consultations", consultationsTriees);
        request.setAttribute("statuts", Statut.values());

        request.getRequestDispatcher("/views/docteur/mes-consultations.jsp").forward(request, response);
    }

    private void showTodayConsultations(HttpServletRequest request, HttpServletResponse response, Docteur docteur)
            throws ServletException, IOException {

        List<Consultation> consultations = consultationService.findByDoctor((long) docteur.getId());

        List<Consultation> consultationsToday = consultations.stream()
                .filter(c -> c.getDate().equals(LocalDate.now()))
                .filter(c -> c.getStatut() != Statut.ANNULEE)
                .sorted((c1, c2) -> c1.getHeure().compareTo(c2.getHeure()))
                .toList();

        request.setAttribute("docteur", docteur);
        request.setAttribute("consultations", consultationsToday);
        request.setAttribute("statuts", Statut.values());

        request.getRequestDispatcher("/views/docteur/consultations-aujourdhui.jsp").forward(request, response);
    }

    private void updateStatutConsultation(HttpServletRequest request, HttpServletResponse response, Docteur docteur)
            throws IOException {
        try {
            int consultationId = Integer.parseInt(request.getParameter("consultationId"));
            Statut nouveauStatut = Statut.valueOf(request.getParameter("statut"));

            Consultation consultation = consultationService.findById((long) consultationId);

            if (consultation == null || consultation.getDocteur().getId() != docteur.getId()) {
                throw new ConsultationNotFoundException("Consultation non trouvée");
            }

            // Validation des transitions de statut
            if (consultation.getStatut() == Statut.ANNULEE) {
                throw new IllegalStateException("Impossible de modifier une consultation annulée");
            }

            if (consultation.getStatut() == Statut.TERMINEE && nouveauStatut != Statut.TERMINEE) {
                throw new IllegalStateException("Impossible de modifier une consultation terminée");
            }

            // Mettre à jour le statut
            consultation.setStatut(nouveauStatut);
            consultationService.update(consultation);

            response.sendRedirect("doctor-space?action=consultations&success=Statut de la consultation mis à jour avec succès");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("doctor-space?action=consultations&error=" + URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    private void cancelConsultationDoctor(HttpServletRequest request, HttpServletResponse response, Docteur docteur)
            throws IOException {
        try {
            int consultationId = Integer.parseInt(request.getParameter("consultationId"));

            Consultation consultation = consultationService.findById((long) consultationId);

            // Vérifier que la consultation appartient au docteur
            if (consultation == null || consultation.getDocteur().getId() != docteur.getId()) {
                throw new ConsultationNotFoundException("Consultation non trouvée");
            }

            if (consultation.getStatut() == Statut.TERMINEE) {
                throw new IllegalStateException("Impossible d'annuler une consultation terminée");
            }

            if (consultation.getStatut() == Statut.ANNULEE) {
                throw new IllegalStateException("La consultation est déjà annulée");
            }

            consultation.setStatut(Statut.ANNULEE);
            consultationService.update(consultation);

            response.sendRedirect("doctor-space?action=consultations&success=Consultation annulée avec succès");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("doctor-space?action=consultations&error=" + URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }
}