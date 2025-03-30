package servlet;

import database.ConnexionBdd;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/connexion")
public class ServletConnexion extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer les paramètres d'authentification (email et mot de passe)
        String email = request.getParameter("mail");
        String password = request.getParameter("pass");

        // Vérification des paramètres non vides
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            // Rediriger vers la page de connexion avec un message d'erreur
            response.sendRedirect(request.getContextPath() + "/?error=empty");
            return;
        }

        // Vérification d'authentification avec la base de données
        boolean authentifie = ConnexionBdd.verifierAuthentification(email, password);

        if (authentifie) {
            // Si l'authentification réussit, établir une session
            HttpSession session = request.getSession();
            session.setAttribute("utilisateurConnecte", email);
            
            // Récupérer le nom, le prénom et le grade du pompier à partir de la base de données
            String nomPrenomPompier = ConnexionBdd.recupererNomPrenomPompier(email);
            String gradePompier = ConnexionBdd.recupererGradePompier(email);
            
            session.setAttribute("nomPrenomPompier", nomPrenomPompier);
            session.setAttribute("gradePompier", gradePompier);

            // Journalisation de la connexion réussie
            System.out.println("Connexion réussie pour l'utilisateur: " + email);
            
            // Redirection vers la servlet de redirection après connexion réussie
            response.sendRedirect(request.getContextPath() + "/ServletPompier/lister");
        } else {
            // Si l'authentification échoue, rediriger vers la page de connexion avec un message d'erreur
            System.out.println("Échec de connexion pour l'utilisateur: " + email);
            response.sendRedirect(request.getContextPath() + "/?error=invalid");
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Si quelqu'un accède directement à l'URL de connexion via GET, rediriger vers la page de connexion
        response.sendRedirect(request.getContextPath() + "/");
    }
}