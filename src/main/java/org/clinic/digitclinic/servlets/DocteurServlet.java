package org.clinic.digitclinic.servlets;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.clinic.digitclinic.dao.DocteurDAOImpl;
import org.clinic.digitclinic.dao.DepartementDAOImpl;
import org.clinic.digitclinic.dao.interfaces.DocteurDAO;
import org.clinic.digitclinic.dao.interfaces.DepartementDAO;
import org.clinic.digitclinic.entity.Docteur;
import org.clinic.digitclinic.entity.Departement;
import org.clinic.digitclinic.entity.enums.Role;
import org.clinic.digitclinic.service.DocteurServiceImpl;
import org.clinic.digitclinic.service.DepartementServiceImpl;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/docteurs")
public class DocteurServlet extends HelloServlet {
    private DocteurServiceImpl docteurService;
    private DepartementServiceImpl departementService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        DocteurDAO docteurDAO = new DocteurDAOImpl();
        DepartementDAO departementDAO = new DepartementDAOImpl();

        this.docteurService = new DocteurServiceImpl(docteurDAO);
        this.departementService = new DepartementServiceImpl(departementDAO);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        try {
            if (action == null) {
                listDocteurs(request, response);
            } else {
                switch (action) {
                    case "new":
                        showNewForm(request, response);
                        break;
                    case "edit":
                        showEditForm(request, response);
                        break;
                    case "delete":
                        deleteDocteur(request, response);
                        break;
                    case "details":
                        showDocteurDetails(request, response);
                        break;
                    case "planning":
                        showDocteurPlanning(request, response);
                        break;
                    default:
                        listDocteurs(request, response);
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
                addDocteur(request, response);
            } else if ("update".equals(action)) {
                updateDocteur(request, response);
            } else {
                listDocteurs(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        }
    }

    private void listDocteurs(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("📋 Récupération de la liste des docteurs...");

        List<Docteur> docteurs = docteurService.findAll();
        List<Departement> departements = departementService.findAll();

        Map<String, Object> stats = new HashMap<>();
        stats.put("totalDocteurs", docteurs.size());
        stats.put("docteursActifs", docteurs.size());
        stats.put("specialites", docteurs.stream().map(Docteur::getSpecialite).distinct().count());
        stats.put("consultationsTotal", docteurs.stream().mapToInt(d -> d.getPlanning() != null ? d.getPlanning().size() : 0).sum());

        request.setAttribute("docteurs", docteurs);
        request.setAttribute("departements", departements);
        request.setAttribute("stats", stats);

        request.getRequestDispatcher("/views/docteur/docteurs.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Departement> departements = departementService.findAll();
        request.setAttribute("departements", departements);
        request.getRequestDispatcher("/views/docteur/add-docteur.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Docteur docteur = docteurService.findById((long) id);
        List<Departement> departements = departementService.findAll();

        if (docteur != null) {
            request.setAttribute("docteur", docteur);
            request.setAttribute("departements", departements);
            request.getRequestDispatcher("/views/docteur/edit-docteur.jsp").forward(request, response);
        } else {
            response.sendRedirect("docteurs?error=Docteur non trouvé");
        }
    }

    private void addDocteur(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String mdp = request.getParameter("mdp");
        String specialite = request.getParameter("specialite");
        int departementId = Integer.parseInt(request.getParameter("departementId"));

        Docteur existing = docteurService.findByEmail(email);
        if (existing != null) {
            response.sendRedirect("docteurs?action=new&error=Un docteur avec cet email existe déjà");
            return;
        }

        Departement departement = departementService.findById((long) departementId);
        if (departement == null) {
            response.sendRedirect("docteurs?action=new&error=Département non trouvé");
            return;
        }

        Docteur docteur = new Docteur();
        docteur.setNom(nom);
        docteur.setPrenom(prenom);
        docteur.setEmail(email);
        docteur.setMdp(mdp);
        docteur.setSpecialite(specialite);
        docteur.setDepartement(departement);
        docteur.setRole(Role.DOCTEUR);

        docteurService.save(docteur);
        String contextPath = request.getContextPath();
        response.sendRedirect(contextPath + "/docteurs?success=Docteur ajouté avec succès");
    }

    private void updateDocteur(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String specialite = request.getParameter("specialite");
        int departementId = Integer.parseInt(request.getParameter("departementId"));

        Docteur docteur = docteurService.findById((long) id);
        Departement departement = departementService.findById((long) departementId);

        if (docteur != null && departement != null) {
            docteur.setNom(nom);
            docteur.setPrenom(prenom);
            docteur.setEmail(email);
            docteur.setSpecialite(specialite);
            docteur.setDepartement(departement);
            docteur.setRole(Role.DOCTEUR);

            docteurService.update(docteur);
            response.sendRedirect("docteurs?success=Docteur modifié avec succès");
        } else {
            response.sendRedirect("docteurs?error=Docteur ou département non trouvé");
        }
    }

    private void deleteDocteur(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        Docteur docteur = docteurService.findById((long) id);
        if (docteur != null && docteur.getPlanning() != null && !docteur.getPlanning().isEmpty()) {
            response.sendRedirect("docteurs?error=Impossible de supprimer: le docteur a des consultations planifiées");
            return;
        }

        docteurService.delete((long) id);
        response.sendRedirect("docteurs?success=Docteur supprimé avec succès");
    }

    private void showDocteurDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Docteur docteur = docteurService.findById((long) id);

        if (docteur != null) {
            request.setAttribute("docteur", docteur);
            request.getRequestDispatcher("/views/docteur/details-docteur.jsp").forward(request, response);
        } else {
            response.sendRedirect("docteurs?error=Docteur non trouvé");
        }
    }

    private void showDocteurPlanning(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Docteur docteur = docteurService.findById((long) id);

        if (docteur != null) {
            request.setAttribute("docteur", docteur);
            request.setAttribute("planning", docteur.getPlanning());
            request.getRequestDispatcher("/views/docteur/planning-docteur.jsp").forward(request, response);
        } else {
            response.sendRedirect("docteurs?error=Docteur non trouvé");
        }
    }
}