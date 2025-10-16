package org.clinic.digitclinic.servlets;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.clinic.digitclinic.dao.SalleDAOImpl;
import org.clinic.digitclinic.dao.interfaces.SalleDAO;
import org.clinic.digitclinic.entity.Salle;
import org.clinic.digitclinic.service.SalleServiceImpl;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/salles")
public class SalleServlet extends HelloServlet {
    private SalleServiceImpl salleService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        SalleDAO salleDAO = new SalleDAOImpl();
        this.salleService = new SalleServiceImpl(salleDAO);
        System.out.println("✅ Service salle initialisé avec succès !");
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if (action == null) {
                listSalles(request, response);
            } else {
                switch (action) {
                    case "new":
                        showNewForm(request, response);
                        break;
                    case "edit":
                        showEditForm(request, response);
                        break;
                    case "delete":
                        deleteSalle(request, response);
                        break;
                    case "details":
                        showSalleDetails(request, response);
                        break;
                    default:
                        listSalles(request, response);
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
                addSalle(request, response);
            } else if ("update".equals(action)) {
                updateSalle(request, response);
            } else {
                listSalles(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        }
    }

    private void listSalles(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("📋 Récupération de la liste des salles...");

        List<Salle> salles = salleService.findAll();

        Map<String, Object> stats = new HashMap<>();
        stats.put("totalSalles", salles.size());
        stats.put("sallesDisponibles", salles.stream().filter(s -> s.getCreneaux() == null).count());
        stats.put("capaciteTotale", salles.stream().mapToInt(Salle::getCapacite).sum());
        stats.put("sallesOccupees", salles.stream().filter(s -> s.getCreneaux() != null).count());

        request.setAttribute("salles", salles);
        request.setAttribute("stats", stats);

        request.getRequestDispatcher("/views/salle/salles.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/salle/add-salle.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Salle salle = salleService.findById((long) id);

        if (salle != null) {
            request.setAttribute("salle", salle);
            request.getRequestDispatcher("/views/salle/edit-salle.jsp").forward(request, response);
        } else {
            response.sendRedirect("salles?error=Salle non trouvée");
        }
    }

    private void addSalle(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String nomSalle = request.getParameter("nomSalle");
        int capacite = Integer.parseInt(request.getParameter("capacite"));
        String creneauStr = request.getParameter("creneau");

        Salle salle = new Salle();
        salle.setNomSalle(nomSalle);
        salle.setCapacite(capacite);

        if (creneauStr != null && !creneauStr.isEmpty()) {
            LocalDate creneau = LocalDate.parse(creneauStr);
            salle.addCreneau(creneau);
        }

        salleService.save(salle);
        String contextPath = request.getContextPath();
        response.sendRedirect(contextPath + "/salles?success=Salle ajoutée avec succès");
    }

    private void updateSalle(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nomSalle = request.getParameter("nomSalle");
        int capacite = Integer.parseInt(request.getParameter("capacite"));
        String creneauStr = request.getParameter("creneau");

        Salle salle = salleService.findById((long) id);

        if (salle != null) {
            salle.setNomSalle(nomSalle);
            salle.setCapacite(capacite);

            if (creneauStr != null && !creneauStr.isEmpty()) {
                LocalDate creneau = LocalDate.parse(creneauStr);
                salle.addCreneau(creneau);
            } else {
                salle.addCreneau(null);
            }

            salleService.update(salle);
            response.sendRedirect("salles?success=Salle modifiée avec succès");
        } else {
            response.sendRedirect("salles?error=Salle non trouvée");
        }
    }

    private void deleteSalle(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        // Vérifier si la salle est utilisée dans des consultations
        // (à implémenter selon votre modèle de données)

        salleService.delete((long) id);
        response.sendRedirect("salles?success=Salle supprimée avec succès");
    }

    private void showSalleDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Salle salle = salleService.findById((long) id);

        if (salle != null) {
            request.setAttribute("salle", salle);
            request.getRequestDispatcher("/views/salle/details-salle.jsp").forward(request, response);
        } else {
            response.sendRedirect("salles?error=Salle non trouvée");
        }
    }
}