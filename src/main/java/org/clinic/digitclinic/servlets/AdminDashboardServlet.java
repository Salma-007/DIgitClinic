package org.clinic.digitclinic.servlets;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.clinic.digitclinic.dao.ConsultationDAOImpl;
import org.clinic.digitclinic.dao.DepartementDAOImpl;
import org.clinic.digitclinic.dao.DocteurDAOImpl;
import org.clinic.digitclinic.dao.PatientDAOImpl;
import org.clinic.digitclinic.dao.interfaces.ConsultationDAO;
import org.clinic.digitclinic.dao.interfaces.DepartementDAO;
import org.clinic.digitclinic.dao.interfaces.DocteurDAO;
import org.clinic.digitclinic.dao.interfaces.PatientDAO;
import org.clinic.digitclinic.entity.Consultation;
import org.clinic.digitclinic.entity.Patient;
import org.clinic.digitclinic.service.ConsultationServiceImpl;
import org.clinic.digitclinic.service.DepartementServiceImpl;
import org.clinic.digitclinic.service.DocteurServiceImpl;
import org.clinic.digitclinic.service.PatientServiceImpl;
import org.clinic.digitclinic.util.HibernateUtil;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/dashboard-admin")
public class AdminDashboardServlet extends HttpServlet {

    private PatientServiceImpl patientService;
    private DocteurServiceImpl docteurService;
    private DepartementServiceImpl departementService;
    private ConsultationServiceImpl consultationService;

    @Override
    public void init() throws ServletException {

        PatientDAO patientDAO = new PatientDAOImpl();
        DocteurDAO docteurDAO = new DocteurDAOImpl();
        DepartementDAO departementDAO = new DepartementDAOImpl();
        ConsultationDAO consultationDAO = new ConsultationDAOImpl();

        this.patientService = new PatientServiceImpl(patientDAO);
        this.docteurService = new DocteurServiceImpl(docteurDAO);
        this.departementService = new DepartementServiceImpl(departementDAO);
        this.consultationService = new ConsultationServiceImpl(consultationDAO);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Map<String, Object> stats = new HashMap<>();
            stats.put("totalPatients", patientService.findAllPatients().size());
            stats.put("totalDocteurs", docteurService.findAll().size());
            stats.put("totalDepartements", departementService.findAll().size());
            stats.put("totalConsultations", consultationService.findAll().size());

            List<Consultation> consultations = consultationService.findAll();
            List<Patient> patients = patientService.findAllPatients();

            request.setAttribute("consultations", consultations);
            request.setAttribute("stats", stats);
            request.setAttribute("patients", patients);

            request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}