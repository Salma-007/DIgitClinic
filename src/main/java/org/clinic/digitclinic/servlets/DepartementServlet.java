package org.clinic.digitclinic.servlets;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.clinic.digitclinic.dao.DepartementDAOImpl;
import org.clinic.digitclinic.dao.DocteurDAOImpl;
import org.clinic.digitclinic.dao.interfaces.DepartementDAO;
import org.clinic.digitclinic.dao.interfaces.DocteurDAO;
import org.clinic.digitclinic.entity.Departement;
import org.clinic.digitclinic.entity.Docteur;
import org.clinic.digitclinic.service.DepartementServiceImpl;
import org.clinic.digitclinic.service.DocteurServiceImpl;
import org.clinic.digitclinic.util.HibernateUtil;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/departements")

public class DepartementServlet extends HelloServlet {
    private DepartementServiceImpl departementService;
    private DocteurServiceImpl docteurService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        DepartementDAO departementDAO = new DepartementDAOImpl();
        DocteurDAO docteurDAO = new DocteurDAOImpl();

        this.departementService = new DepartementServiceImpl(departementDAO);
        this.docteurService = new DocteurServiceImpl(docteurDAO);

        System.out.println("✅ Service département initialisé avec succès !");
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if (action == null) {
                listDepartements(request, response);
            } else {
                switch (action) {
                    case "new":
                        showNewForm(request, response);
                        break;
                    case "edit":
                        showEditForm(request, response);
                        break;
                    case "delete":
                        deleteDepartement(request, response);
                        break;
                    case "docteurs":
                        showDocteursByDepartement(request, response);
                        break;
                    default:
                        listDepartements(request, response);
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
                addDepartement(request, response);
            } else if ("update".equals(action)) {
                updateDepartement(request, response);
            } else {
                listDepartements(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        }
    }

    private void listDepartements(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("📋 Récupération de la liste des départements...");

        List<Departement> departements = departementService.findAll();

        Map<String, Object> stats = new HashMap<>();
        stats.put("totalDepartements", departements.size());
        stats.put("totalDocteurs", docteurService.findAll().size());
        stats.put("consultationsMois", 125); // Exemple

        request.setAttribute("departements", departements);
        request.setAttribute("stats", stats);

        request.getRequestDispatcher("/views/departement/departements.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/views/departement/add-departement.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Long id = Long.parseLong(request.getParameter("id"));
        Departement departement = departementService.findById(id);

        if (departement != null) {
            request.setAttribute("departement", departement);
            request.getRequestDispatcher("/views/departement/edit-departement.jsp").forward(request, response);
        } else {
            response.sendRedirect("departements?error=Departement non trouvé");
        }
    }

    private void addDepartement(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String nom = request.getParameter("nom");

        Departement existing = departementService.findByNom(nom);
        if (existing != null) {
            response.sendRedirect("departements?error=Un département avec ce nom existe déjà");
            return;
        }

        Departement departement = new Departement();
        departement.setNom(nom);
        departementService.save(departement);
        String contextPath = request.getContextPath();
        response.sendRedirect(contextPath + "/departements?success=Département ajouté");
    }

    private void updateDepartement(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        Long id = Long.parseLong(request.getParameter("id"));
        String nom = request.getParameter("nom");

        Departement departement = departementService.findById(id);

        if (departement != null) {
            departement.setNom(nom);

            departementService.update(departement);

            response.sendRedirect("departements?success=Département modifié avec succès");
        } else {
            response.sendRedirect("departements?error=Département non trouvé");
        }
    }

    private void deleteDepartement(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        Long id = Long.parseLong(request.getParameter("id"));

        System.out.println("🗑️ Suppression du département ID: " + id);

        List<Docteur> docteurs = departementService.findByDepartementId(id);

        if (docteurs != null && !docteurs.isEmpty()) {
            response.sendRedirect("departements?error=Impossible de supprimer: des médecins sont associés à ce département");
            return;
        }

        departementService.delete(id);

        response.sendRedirect("departements?success=Département supprimé avec succès");
    }

    private void showDocteursByDepartement(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Long departementId = Long.parseLong(request.getParameter("id"));
        Departement departement = departementService.findById(departementId);
        List<Docteur> docteurs = departementService.findByDepartementId(departementId);

        request.setAttribute("departement", departement);
        request.setAttribute("docteurs", docteurs);

        request.getRequestDispatcher("/docteurs-departement.jsp").forward(request, response);
    }
}