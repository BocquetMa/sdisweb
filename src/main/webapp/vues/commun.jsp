<%-- 
    Document   : commun
    Created on : 6 avr. 2024, 00:12:41
    Author     : mathe
    Modified on: 30 mar. 2025
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="database.ConnexionBdd" %>
<jsp:include page="/vues/style.jsp" />
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
    <title>SDIS WEB - Gestion SDIS Calvados</title>
    <!-- Favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon">
    <!-- Line Awesome Icons -->
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
</head>
<body>
    <input type="checkbox" id="menu-toggle">
    <div class="sidebar">
        <div class="side-header">
            <h3><span>SDIS Web</span></h3>
        </div>
        <div class="side-content">
            <div class="profile">
                <div class="profile-img bg-img" style="background-image: url('${pageContext.request.contextPath}/img/avatar.png')"></div>
                <% 
                    // Récupérer le nom et le prénom du pompier connecté à partir de la session
                    String email = (String) session.getAttribute("utilisateurConnecte");
                    if (email != null) {
                        String nomPrenomPompier = ConnexionBdd.recupererNomPrenomPompier(email);
                        String gradePompier = ConnexionBdd.recupererGradePompier(email);
                %>
                <h4><%= nomPrenomPompier %></h4>
                <small><%= gradePompier %></small>
                <% } else { %>
                <h4>Utilisateur</h4>
                <small>Non connecté</small>
                <% } %>
            </div>

            <div class="side-menu">
                <ul>
                    <li>
                        <a href="${pageContext.request.contextPath}/ServletPompier/lister" class="<%= request.getRequestURI().contains("ServletPompier") ? "active" : "" %>">
                            <span class="las la-users"></span>
                            <small>Pompiers</small>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/ServletCaserne/lister" class="<%= request.getRequestURI().contains("ServletCaserne") ? "active" : "" %>">
                            <span class="las la-building"></span>
                            <small>Casernes</small>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/ServletFonction/lister" class="<%= request.getRequestURI().contains("ServletFonction") ? "active" : "" %>">
                            <span class="las la-tasks"></span>
                            <small>Fonctions</small>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/ServletVehicule/lister" class="<%= request.getRequestURI().contains("ServletVehicule") ? "active" : "" %>">
                            <span class="las la-truck"></span>
                            <small>Véhicules</small>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/ServletGrade/lister" class="<%= request.getRequestURI().contains("ServletGrade") ? "active" : "" %>">
                            <span class="las la-medal"></span>
                            <small>Grades</small>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/ServletIntervention/lister" class="<%= request.getRequestURI().contains("ServletIntervention") ? "active" : "" %>">
                            <span class="las la-ambulance"></span>
                            <small>Interventions</small>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/ServletSituation/lister" class="<%= request.getRequestURI().contains("ServletSituation") ? "active" : "" %>">
                            <span class="las la-fire"></span>
                            <small>Situations</small>
                        </a>
                    </li>
                    <li class="separator"></li>
                    <li>
                        <a href="${pageContext.request.contextPath}/logout" class="logout">
                            <span class="las la-power-off"></span>
                            <small>Déconnexion</small>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <div class="main-content">
        <header>
            <div class="header-content">
                <label for="menu-toggle">
                    <span class="las la-bars"></span>
                </label>

                <div class="header-menu">
                    <div class="date">
                        <span id="currentDate"></span>
                    </div>
                    <div class="user">
                        <div class="bg-img" style="background-image: url('${pageContext.request.contextPath}/img/avatar.png')"></div>
                        <% if (email != null) { %>
                        <span><%= ConnexionBdd.recupererNomPrenomPompier(email) %></span>
                        <% } else { %>
                        <span>Utilisateur</span>
                        <% } %>
                    </div>
                </div>
            </div>
        </header>

        <!-- Script pour afficher la date -->
        <script>
            // Affichage de la date courante
            const date = new Date();
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            document.getElementById('currentDate').textContent = date.toLocaleDateString('fr-FR', options);
            
            // Mettre en évidence le menu actif
            document.addEventListener('DOMContentLoaded', function() {
                const currentLocation = window.location.href;
                const menuItems = document.querySelectorAll('.side-menu a');
                
                menuItems.forEach(item => {
                    if (currentLocation.includes(item.getAttribute('href'))) {
                        item.classList.add('active');
                    }
                });
            });
        </script>
</body>
</html>