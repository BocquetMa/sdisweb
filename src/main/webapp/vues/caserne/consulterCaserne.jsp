<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Pompier"%>
<%@page import="model.Caserne"%>
<%@page import="model.Vehicule"%>
<%@page import="java.util.ArrayList"%>
<jsp:include page="/vues/commun.jsp" />

<main>
    <div class="page-header">
        <%
            Caserne c = (Caserne)request.getAttribute("cCaserne");
            if (c != null) {
        %>
        <h1>Caserne de <%= c.getNom() %></h1>
        <small><i class="las la-map-marker"></i> <%= c.getRue() %>, <%= c.getCopos() %> <%= c.getVille() %></small>
    </div>
    
    <div class="page-content">
        <!-- Statistiques rapides -->
        <div class="analytics">
            <div class="card">
                <div class="card-head">
                    <h2><%= c.getLesPompiers().size() %></h2>
                    <span class="las la-users"></span>
                </div>
                <div class="card-progress">
                    <small>Pompiers affectés</small>
                </div>
            </div>
            
            <div class="card">
                <div class="card-head">
                    <h2><%= c.getLesVehicules().size() %></h2>
                    <span class="las la-truck"></span>
                </div>
                <div class="card-progress">
                    <small>Véhicules disponibles</small>
                </div>
            </div>
        </div>
        
        <div class="records">
            <div class="record-header">
                <h2>Liste des pompiers</h2>
                <div class="add">
                    <button><a href="../ServletPompier/ajouter"><i class="las la-plus"></i> Ajouter un pompier</a></button>
                </div>
            </div>
            
            <div class="casernes-container">
                <% for (Pompier p : c.getLesPompiers()) { %>
                    <div class="caserne">
                        <div style="display: flex; align-items: center;">
                            <i class="las la-user-circle"></i>
                            <div style="margin-left: 15px;">
                                <h3><%= p.getNom() %> <%= p.getPrenom() %></h3>
                                <% if (p.getUnGrade() != null) { %>
                                    <p><span class="badge"><%= p.getUnGrade().getLibelle() %></span></p>
                                <% } %>
                            </div>
                            <div class="actions">
                                <a href="../ServletPompier/consulter?idPompier=<%= p.getId() %>">
                                    <button><i class="las la-eye"></i> Consulter</button>
                                </a>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        </div>
        
        <div class="records" style="margin-top: 20px;">
            <div class="record-header">
                <h2>Liste des véhicules</h2>
                <div class="add">
                    <button><a href="../ServletVehicule/ajouter"><i class="las la-plus"></i> Ajouter un véhicule</a></button>
                </div>
            </div>
            
            <div class="casernes-container">
                <% for (Vehicule vehicule : c.getLesVehicules()) { %>
                    <div class="caserne">
                        <div style="display: flex; align-items: center;">
                            <i class="las la-truck"></i>
                            <div style="margin-left: 15px;">
                                <h3><%= vehicule.getImmat() %></h3>
                                <% if (vehicule.getTypeVehicule() != null) { %>
                                    <p><span class="badge"><%= vehicule.getTypeVehicule().getNom() %></span></p>
                                <% } %>
                            </div>
                            <div class="actions">
                                <a href="../ServletVehicule/consulter?idVehicule=<%= vehicule.getId() %>">
                                    <button><i class="las la-eye"></i> Consulter</button>
                                </a>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
    <%
        } else {
    %>
    <div class="page-content">
        <div class="alert alert-danger">
            <i class="las la-exclamation-triangle"></i>
            <span>Caserne introuvable. Veuillez vérifier les paramètres de la requête.</span>
        </div>
        <div style="text-align: center; margin-top: 20px;">
            <a href="../ServletCaserne/lister" class="btn btn-primary">
                <i class="las la-arrow-left"></i> Retour à la liste des casernes
            </a>
        </div>
    </div>
    <%
        }
    %>
</main>

<style>
    .analytics {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        grid-gap: 20px;
        margin-bottom: 20px;
    }
    
    .card {
        background: white;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    
    .card-head {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .card-head h2 {
        font-size: 30px;
        color: #333;
    }
    
    .card-head span {
        font-size: 30px;
        color: #DA001B;
    }
    
    .card-progress {
        margin-top: 10px;
    }
    
    .badge {
        background: #f0f0f0;
        padding: 3px 8px;
        border-radius: 3px;
        font-size: 12px;
        color: #666;
    }
    
    .alert {
        padding: 15px;
        margin-bottom: 20px;
        border-radius: 5px;
        display: flex;
        align-items: center;
    }
    
    .alert-danger {
        background-color: #ffebee;
        color: #c62828;
    }
    
    .alert i {
        font-size: 24px;
        margin-right: 10px;
    }
    
    .btn {
        display: inline-block;
        padding: 10px 20px;
        border-radius: 5px;
        text-decoration: none;
        font-weight: bold;
    }
    
    .btn-primary {
        background: #DA001B;
        color: white;
    }
    
    @media only screen and (max-width: 768px) {
        .analytics {
            grid-template-columns: 1fr;
        }
    }
</style>