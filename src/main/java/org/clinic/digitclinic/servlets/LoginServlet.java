package org.clinic.digitclinic.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.clinic.digitclinic.entity.Personne;
import org.clinic.digitclinic.service.AuthServiceImpl;
import org.clinic.digitclinic.service.interfaces.AuthService;

import java.io.IOException;

@WebServlet(name = "login",value = "/login")
public class LoginServlet extends HttpServlet {

    private final AuthService authService = new AuthServiceImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("views/login.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");

        try {
            Personne user = authService.login(email, motDePasse);

            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("role", user.getRole().toString());

            // Redirection selon rôle
            switch (user.getRole()) {
                case ADMIN -> response.sendRedirect("views/admin/dashboard.jsp");
                case DOCTEUR -> response.sendRedirect("views/login.jsp");
                case PATIENT -> response.sendRedirect("views/patient/home.jsp");
                default -> response.sendRedirect("index.jsp");
            }

        } catch (RuntimeException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}
