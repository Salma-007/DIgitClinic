package org.clinic.digitclinic.servlets;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.clinic.digitclinic.dao.PatientDAOImpl;
import org.clinic.digitclinic.dao.interfaces.PatientDAO;
import org.clinic.digitclinic.entity.Patient;
import org.clinic.digitclinic.entity.Personne;
import org.clinic.digitclinic.entity.enums.Role;
import org.clinic.digitclinic.service.PatientServiceImpl;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/patients")
public class PatientServlet extends HelloServlet {
    private PatientServiceImpl patientService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        PatientDAO patientDAO = new PatientDAOImpl();
        this.patientService = new PatientServiceImpl(patientDAO);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if (action == null) {
                listPatients(request, response);
            } else {
                switch (action) {
                    case "new":
                        showNewForm(request, response);
                        break;
                    case "edit":
                        showEditForm(request, response);
                        break;
                    case "delete":
                        deletePatient(request, response);
                        break;
                    case "details":
                        showPatientDetails(request, response);
                        break;
                    case "consultations":
                        showPatientConsultations(request, response);
                        break;
                    default:
                        listPatients(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                addPatient(request, response);
            } else if ("update".equals(action)) {
                updatePatient(request, response);
            } else {
                listPatients(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        }
    }

    private void listPatients(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Patient> patients = patientService.findAllPatients();

        Map<String, Object> stats = new HashMap<>();
        stats.put("totalPatients", patients.size());
        stats.put("patientsActifs", patients.size());
        stats.put("nouveauxPatients", patients.stream().limit(5).count());
        stats.put("consultationsTotal", patients.stream().mapToInt(Patient::getConsultationsCount).sum());

        request.setAttribute("patients", patients);
        request.setAttribute("stats", stats);

        request.getRequestDispatcher("/views/patient/patients.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/patient/add-patient.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Patient patient = patientService.findById((long) id);

        if (patient != null) {
            request.setAttribute("patient", patient);
            request.getRequestDispatcher("/views/patient/edit-patient.jsp").forward(request, response);
        } else {
            response.sendRedirect("patients?error=Patient non trouvé");
        }
    }

    private void addPatient(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String mdp = request.getParameter("mdp");
        float poid = Float.parseFloat(request.getParameter("poid"));
        float taille = Float.parseFloat(request.getParameter("taille"));

        Patient existing = patientService.findByEmail(email);
        if (existing != null) {
            response.sendRedirect("patients?action=new&error=Un patient avec cet email existe déjà");
            return;
        }

        Patient patient = new Patient();
        patient.setNom(nom);
        patient.setPrenom(prenom);
        patient.setEmail(email);
        patient.setMdp(mdp);
        patient.setPoid(poid);
        patient.setTaille(taille);
        patient.setRole(Role.PATIENT);

        patientService.save(patient);
        String contextPath = request.getContextPath();
        response.sendRedirect(contextPath + "/patients?success=Patient ajouté avec succès");
    }

    private void updatePatient(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        float poid = Float.parseFloat(request.getParameter("poid"));
        float taille = Float.parseFloat(request.getParameter("taille"));

        Patient patient = patientService.findById((long) id);

        if (patient != null) {
            patient.setNom(nom);
            patient.setPrenom(prenom);
            patient.setEmail(email);
            patient.setPoid(poid);
            patient.setTaille(taille);

            patientService.update(patient);
            response.sendRedirect("patients?success=Patient modifié avec succès");
        } else {
            response.sendRedirect("patients?error=Patient non trouvé");
        }
    }

    private void deletePatient(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        Patient patient = patientService.findById((long) id);
        if (patient != null && patient.getConsultationsCount() > 0) {
            response.sendRedirect("patients?error=Impossible de supprimer: le patient a des consultations");
            return;
        }

        patientService.delete((long) id);
        response.sendRedirect("patients?success=Patient supprimé avec succès");
    }

    private void showPatientDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Patient patient = patientService.findById((long) id);

        if (patient != null) {
            request.setAttribute("patient", patient);
            request.getRequestDispatcher("/views/patient/details-patient.jsp").forward(request, response);
        } else {
            response.sendRedirect("patients?error=Patient non trouvé");
        }
    }

    private void showPatientConsultations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Patient patient = patientService.findById((long) id);

        if (patient != null) {
            request.setAttribute("patient", patient);
            request.setAttribute("consultations", patient.getConsultations());
            request.getRequestDispatcher("/views/patient/consultations-patient.jsp").forward(request, response);
        } else {
            response.sendRedirect("patients?error=Patient non trouvé");
        }
    }
}