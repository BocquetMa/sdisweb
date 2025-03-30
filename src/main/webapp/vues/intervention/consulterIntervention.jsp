<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Intervention"%>
<%@page import="model.Pompier"%>
<%@page import="model.Vehicule"%>
<jsp:include page="/vues/commun.jsp" />

<main>
    <% 
    Intervention intervention = (Intervention) request.getAttribute("iNom");
    ArrayList<Pompier> lesPompiers = (ArrayList<Pompier>) request.getAttribute("lesPompiers");
    ArrayList<Vehicule> lesVehicules = (ArrayList<Vehicule>) request.getAttribute("lesVehicules");
    %>

    <div class="page-header">
        <h1>
            <% if (intervention != null) { %>
                Intervention à <%= intervention.getLieu() %>
            <% } else { %>
                Détails de l'intervention
            <% } %>
        </h1>
        <small><i class="las la-fire-extinguisher"></i> SDIS Calvados</small>
    </div>
    
    <div class="page-content">
        <% if (intervention != null) { %>
            <!-- Carte d'information de l'intervention -->
            <div class="intervention-card">
                <div class="intervention-header">
                    <i class="las la-bell-on"></i>
                    <div class="intervention-details">
                        <h2><%= intervention.getLieu() %></h2>
                        <div class="intervention-meta">
                            <span><i class="las la-calendar"></i> <%= intervention.getDate() %></span>
                            <span><i class="las la-clock"></i> Appel : <%= intervention.getHeureAppel() %></span>
                            <span><i class="las la-truck-moving"></i> Arrivée : <%= intervention.getHeureArrivee() %></span>
                            <span><i class="las la-hourglass-half"></i> Durée : <%= intervention.getDuree() %></span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Stats résumées -->
            <div class="stats-container">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="las la-users"></i>
                    </div>
                    <div class="stat-content">
                        <div class="stat-value"><%= lesPompiers != null ? lesPompiers.size() : 0 %></div>
                        <div class="stat-label">Pompiers mobilisés</div>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="las la-truck"></i>
                    </div>
                    <div class="stat-content">
                        <div class="stat-value"><%= lesVehicules != null ? lesVehicules.size() : 0 %></div>
                        <div class="stat-label">Véhicules déployés</div>
                    </div>
                </div>
            </div>
            
            <!-- Conteneurs d'équipes -->
            <div class="teams-container">
                <!-- Section des pompiers -->
                <div class="team-section">
                    <div class="section-header">
                        <h2><i class="las la-users"></i> Personnel mobilisé</h2>
                        <div class="section-actions">
                            <a href="../ServletPompier/ajouter" class="btn-add">
                                <i class="las la-user-plus"></i> Ajouter un pompier
                            </a>
                        </div>
                    </div>
                    
                    <div class="team-members">
                        <% if (lesPompiers != null && !lesPompiers.isEmpty()) { %>
                            <% for (Pompier p : lesPompiers) { %>
                                <div class="member-card">
                                    <div class="member-avatar">
                                        <i class="las la-user-circle"></i>
                                    </div>
                                    <div class="member-info">
                                        <h3><%= p.getNom() %> <%= p.getPrenom() %></h3>
                                        <% if (p.getUnGrade() != null) { %>
                                            <p class="member-grade"><%= p.getUnGrade().getLibelle() %></p>
                                        <% } %>
                                        <% if (p.getUneCaserne() != null) { %>
                                            <p class="member-caserne"><i class="las la-building"></i> <%= p.getUneCaserne().getNom() %></p>
                                        <% } %>
                                        <a href="../ServletPompier/consulter?idPompier=<%= p.getId() %>" class="btn-view">
                                            <i class="las la-eye"></i> Voir le profil
                                        </a>
                                    </div>
                                </div>
                            <% } %>
                        <% } else { %>
                            <div class="empty-message">
                                <i class="las la-user-slash"></i>
                                <p>Aucun pompier n'a été mobilisé pour cette intervention.</p>
                            </div>
                        <% } %>
                    </div>
                </div>
                
                <!-- Section des véhicules -->
                <div class="team-section">
                    <div class="section-header">
                        <h2><i class="las la-truck"></i> Véhicules déployés</h2>
                        <div class="section-actions">
                            <a href="../ServletVehicule/ajouter" class="btn-add">
                                <i class="las la-plus"></i> Ajouter un véhicule
                            </a>
                        </div>
                    </div>
                    
                    <div class="team-members">
                        <% if (lesVehicules != null && !lesVehicules.isEmpty()) { %>
                            <% for (Vehicule vehicule : lesVehicules) { %>
                                <div class="member-card vehicle-card">
                                    <div class="member-avatar vehicle-avatar">
                                        <i class="las la-truck"></i>
                                    </div>
                                    <div class="member-info">
                                        <h3><%= vehicule.getImmat() %></h3>
                                        <% if (vehicule.getTypeVehicule() != null) { %>
                                            <p class="member-grade"><%= vehicule.getTypeVehicule().getNom() %></p>
                                        <% } %>
                                        <p class="vehicle-details">
                                            <% if (vehicule.getDateRevision() != null) { %>
                                                <span><i class="las la-tools"></i> Révision: <%= vehicule.getDateRevision() %></span>
                                            <% } %>
                                        </p>
                                        <a href="../ServletVehicule/consulter?idVehicule=<%= vehicule.getId() %>" class="btn-view">
                                            <i class="las la-eye"></i> Consulter
                                        </a>
                                    </div>
                                </div>
                            <% } %>
                        <% } else { %>
                            <div class="empty-message">
                                <i class="las la-truck-loading"></i>
                                <p>Aucun véhicule n'a été déployé pour cette intervention.</p>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        <% } else { %>
            <div class="error-state">
                <i class="las la-exclamation-triangle"></i>
                <h3>Intervention introuvable</h3>
                <p>L'intervention que vous recherchez n'existe pas ou a été supprimée.</p>
                <a href="../ServletIntervention/lister" class="btn-primary">
                    <i class="las la-list"></i> Voir toutes les interventions
                </a>
            </div>
        <% } %>
    </div>
</main>

<style>
    .intervention-card {
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        margin-bottom: 25px;
        overflow: hidden;
    }
    
    .intervention-header {
        padding: 20px;
        display: flex;
        align-items: center;
        gap: 20px;
    }
    
    .intervention-header i {
        font-size: 2.5rem;
        color: #DA001B;
    }
    
    .intervention-details h2 {
        margin: 0 0 10px;
        color: #333;
        font-size: 1.5rem;
    }
    
    .intervention-meta {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
    }
    
    .intervention-meta span {
        display: flex;
        align-items: center;
        color: #666;
        font-size: 0.9rem;
    }
    
    .intervention-meta i {
        font-size: 1rem;
        margin-right: 5px;
        color: #DA001B;
    }
    
    .stats-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin-bottom: 25px;
    }
    
    .stat-card {
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        padding: 20px;
        display: flex;
        align-items: center;
        gap: 15px;
    }
    
    .stat-icon {
        width: 50px;
        height: 50px;
        background: rgba(218, 0, 27, 0.1);
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.8rem;
        color: #DA001B;
    }
    
    .stat-content {
        flex: 1;
    }
    
    .stat-value {
        font-size: 1.8rem;
        font-weight: bold;
        color: #333;
        line-height: 1;
    }
    
    .stat-label {
        font-size: 0.9rem;
        color: #666;
        margin-top: 5px;
    }
    
    .teams-container {
        display: grid;
        grid-template-columns: 1fr;
        gap: 25px;
    }
    
    .team-section {
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        overflow: hidden;
    }
    
    .section-header {
        padding: 15px 20px;
        border-bottom: 1px solid #eee;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .section-header h2 {
        margin: 0;
        font-size: 1.2rem;
        color: #333;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .section-header h2 i {
        color: #DA001B;
    }
    
    .btn-add {
        display: inline-flex;
        align-items: center;
        background: #DA001B;
        color: white;
        padding: 6px 12px;
        border-radius: 5px;
        text-decoration: none;
        font-size: 0.9rem;
        transition: background 0.3s;
    }
    
    .btn-add:hover {
        background: #b80016;
    }
    
    .btn-add i {
        margin-right: 5px;
    }
    
    .team-members {
        padding: 20px;
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 15px;
    }
    
    .member-card {
        display: flex;
        background: #f8f8f8;
        border-radius: 8px;
        overflow: hidden;
        transition: transform 0.3s;
    }
    
    .member-card:hover {
        transform: translateY(-3px);
    }
    
    .member-avatar {
        width: 80px;
        background: linear-gradient(135deg, #DA001B, #ff3c54);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 2rem;
    }
    
    .vehicle-avatar {
        background: linear-gradient(135deg, #2e3192, #1baeec);
    }
    
    .member-info {
        flex: 1;
        padding: 15px;
    }
    
    .member-info h3 {
        margin: 0 0 5px;
        color: #333;
        font-size: 1.1rem;
    }
    
    .member-grade {
        font-size: 0.9rem;
        color: #DA001B;
        margin: 0 0 8px;
        font-weight: 500;
    }
    
    .member-caserne, .vehicle-details {
        font-size: 0.9rem;
        color: #666;
        margin: 0 0 10px;
        display: flex;
        align-items: center;
        gap: 5px;
    }
    
    .btn-view {
        display: inline-flex;
        align-items: center;
        background: white;
        color: #333;
        padding: 5px 10px;
        border-radius: 5px;
        text-decoration: none;
        font-size: 0.85rem;
        transition: background 0.3s;
    }
    
    .btn-view:hover {
        background: #f0f0f0;
    }
    
    .btn-view i {
        margin-right: 5px;
    }
    
    .empty-message {
        grid-column: 1 / -1;
        text-align: center;
        padding: 30px;
        color: #666;
    }
    
    .empty-message i {
        font-size: 3rem;
        color: #ddd;
        margin-bottom: 15px;
    }
    
    .error-state {
        text-align: center;
        padding: 50px 20px;
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
    
    .error-state i {
        font-size: 3rem;
        color: #DA001B;
        margin-bottom: 20px;
    }
    
    .error-state h3 {
        margin: 0 0 10px;
        font-size: 1.5rem;
        color: #333;
    }
    
    .error-state p {
        color: #666;
        margin: 0 0 20px;
    }
    
    .btn-primary {
        display: inline-flex;
        align-items: center;
        background: #DA001B;
        color: white;
        padding: 10px 20px;
        border-radius: 5px;
        text-decoration: none;
        font-weight: 500;
    }
    
    .btn-primary i {
        margin-right: 8px;
    }
    
    @media (max-width: 768px) {
        .intervention-meta {
            flex-direction: column;
            gap: 8px;
        }
        
        .section-header {
            flex-direction: column;
            align-items: flex-start;
            gap: 10px;
        }
        
        .section-actions {
            width: 100%;
        }
        
        .btn-add {
            width: 100%;
            justify-content: center;
        }
        
        .team-members {
            grid-template-columns: 1fr;
        }
    }
</style>