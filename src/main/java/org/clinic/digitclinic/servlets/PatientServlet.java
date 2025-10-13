package org.clinic.digitclinic.servlets;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.clinic.digitclinic.dao.PatientDAOImpl;
import org.clinic.digitclinic.dao.interfaces.PatientDAO;
import org.clinic.digitclinic.entity.Patient;
import org.clinic.digitclinic.service.PatientServiceImpl;
import org.clinic.digitclinic.service.interfaces.PatientService;
import org.clinic.digitclinic.util.HibernateUtil;

import java.io.IOException;
import java.util.List;

@WebServlet("/patient/home")
public class PatientServlet extends HttpServlet {

    private PatientServiceImpl patientService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        PatientDAO patientDAO = new PatientDAOImpl();
        this.patientService = new PatientServiceImpl(patientDAO);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            List<Patient> patients = patientService.findAllPatients();
            System.out.println("sending the data to jsp");
            request.setAttribute("patients", patients);
            request.getRequestDispatcher("/views/patient/home.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Erreur : " + e.getMessage());
        }
    }
}
