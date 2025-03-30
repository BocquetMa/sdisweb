<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Pompier"%>
<%@page import="model.Fonction"%>
<%@page import="model.Intervention"%>
<%@page import="java.util.ArrayList"%>
<jsp:include page="/vues/commun.jsp" />

<% Pompier p = (Pompier)request.getAttribute("pPompier"); %>

<main>
    <div class="page-header">
        <h1>Fiche de renseignement</h1>
        <small>Pompier ID: <%= p.getId() %> | Caserne: <%= p.getUneCaserne().getNom() %></small>
    </div>
    
    <div class="page-content">
        <!-- Actions -->
        <div style="display: flex; justify-content: flex-end; margin-bottom: 20px; gap: 10px;">
            <a href="../ServletPompier/modifier?idPompier=<%= p.getId() %>" style="text-decoration: none;">
                <button style="background-color: #f39c12; border: none; color: white; padding: 8px 15px; border-radius: 4px; cursor: pointer; display: flex; align-items: center;">
                    <i class="las la-edit" style="margin-right: 5px;"></i> Modifier
                </button>
            </a>
            <a href="../ServletPompier/lister" style="text-decoration: none;">
                <button style="background-color: #333; border: none; color: white; padding: 8px 15px; border-radius: 4px; cursor: pointer; display: flex; align-items: center;">
                    <i class="las la-list" style="margin-right: 5px;"></i> Liste des pompiers
                </button>
            </a>
        </div>

        <div class="records">
            <!-- Entête avec photo et infos principales -->
            <div style="background: linear-gradient(135deg, var(--primary-color), #b80016); padding: 30px; border-radius: 10px 10px 0 0; color: white; display: flex; align-items: center;">
                <div style="width: 120px; height: 120px; border-radius: 50%; background-color: white; display: flex; align-items: center; justify-content: center; margin-right: 30px; box-shadow: 0 0 15px rgba(0,0,0,0.2);">
                    <i class="las la-user" style="font-size: 80px; color: var(--primary-color);"></i>
                </div>
                <div>
                    <h1 style="margin: 0; font-size: 30px; font-weight: 600;"><%= p.getNom() %> <%= p.getPrenom() %></h1>
                    <div style="display: flex; align-items: center; margin-top: 10px;">
                        <span style="background-color: rgba(255,255,255,0.2); padding: 5px 10px; border-radius: 20px; margin-right: 10px; display: flex; align-items: center;">
                            <i class="las la-medal" style="margin-right: 5px;"></i> <%= p.getUnGrade().getLibelle() %>
                        </span>
                     
                    </div>
                </div>
            </div>
            
            <!-- Contenu de la fiche -->
            <div style="padding: 30px; background-color: white; border-radius: 0 0 10px 10px;">
                <!-- Informations personnelles et professionnelles -->
                <div style="display: flex; flex-wrap: wrap; margin-bottom: 30px; gap: 30px;">
                    <!-- Colonne gauche: Informations personnelles -->
                    <div style="flex: 1; min-width: 300px;">
                        <h3 style="color: var(--primary-color); border-bottom: 2px solid var(--primary-color); padding-bottom: 10px; margin-bottom: 20px; display: flex; align-items: center;">
                            <i class="las la-user-circle" style="margin-right: 10px; font-size: 24px;"></i> Informations personnelles
                        </h3>
                        
                        <div class="info-grid">
                            <div class="info-item">
                                <div class="info-label">
                                    <i class="las la-id-card"></i> Nom
                                </div>
                                <div class="info-value"><%= p.getNom() %></div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-label">
                                    <i class="las la-user"></i> Prénom
                                </div>
                                <div class="info-value"><%= p.getPrenom() %></div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-label">
                                    <i class="las la-birthday-cake"></i> Date de naissance
                                </div>
                                <div class="info-value"><%= p.getDateNaissance() %></div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-label">
                                    <i class="las la-phone"></i> Téléphone
                                </div>
                                <div class="info-value"><%= p.getTelephone() %></div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Colonne droite: Informations professionnelles -->
                    <div style="flex: 1; min-width: 300px;">
                        <h3 style="color: var(--primary-color); border-bottom: 2px solid var(--primary-color); padding-bottom: 10px; margin-bottom: 20px; display: flex; align-items: center;">
                            <i class="las la-briefcase" style="margin-right: 10px; font-size: 24px;"></i> Informations professionnelles
                        </h3>
                        
                        <div class="info-grid">
                            <div class="info-item">
                                <div class="info-label">
                                    <i class="las la-broadcast-tower"></i> Numéro de bip
                                </div>
                                <div class="info-value"><%= p.getBip() %></div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-label">
                                    <i class="las la-building"></i> Caserne
                                </div>
                                <div class="info-value"><%= p.getUneCaserne().getNom() %></div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-label">
                                    <i class="las la-medal"></i> Grade
                                </div>
                                <div class="info-value"><%= p.getUnGrade().getLibelle() %></div>
                            </div>
                            
                            <div class="info-item" style="grid-column: span 2;">
                                <div class="info-label">
                                    <i class="las la-tasks"></i> Fonctions
                                </div>
                                <div class="info-value">
                                    <% if(p.getLesFonctions().isEmpty()) { %>
                                        <span class="badge" style="background-color: #f0f0f0; color: #777;">Aucune fonction</span>
                                    <% } else { %>
                                        <% for(Fonction fonction : p.getLesFonctions()) { %>
                                            <span class="badge" style="background-color: #e0f7fa; color: #006064; margin-right: 5px; margin-bottom: 5px;">
                                                <%= fonction.getLibelle() %>
                                            </span>
                                        <% } %>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Tableau des interventions -->
                <h3 style="color: var(--primary-color); border-bottom: 2px solid var(--primary-color); padding-bottom: 10px; margin-bottom: 20px; display: flex; align-items: center;">
                    <i class="las la-fire-extinguisher" style="margin-right: 10px; font-size: 24px;"></i> Interventions
                </h3>
                
                <% if(p.getLesInterventions().isEmpty()) { %>
                    <div style="background-color: #f8f9fa; border-radius: 10px; padding: 30px; text-align: center; color: #777;">
                        <i class="las la-info-circle" style="font-size: 40px; margin-bottom: 15px; color: #aaa;"></i>
                        <p>Aucune intervention enregistrée pour ce pompier.</p>
                    </div>
                <% } else { %>
                    <div class="table-responsive" style="overflow-x: auto;">
                        <table style="width: 100%; border-collapse: collapse; margin-top: 10px;">
                            <thead>
                                <tr style="background-color: #f0f0f0;">
                                    <th style="padding: 12px 15px; text-align: left; border-bottom: 1px solid #ddd;">Lieu</th>
                                    <th style="padding: 12px 15px; text-align: left; border-bottom: 1px solid #ddd;">Date</th>
                                    <th style="padding: 12px 15px; text-align: left; border-bottom: 1px solid #ddd;">Heure d'appel</th>
                                    <th style="padding: 12px 15px; text-align: left; border-bottom: 1px solid #ddd;">Heure d'arrivée</th>
                                    <th style="padding: 12px 15px; text-align: left; border-bottom: 1px solid #ddd;">Durée</th>
                                    <th style="padding: 12px 15px; text-align: center; border-bottom: 1px solid #ddd;">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for(Intervention intervention : p.getLesInterventions()) { %>
                                    <tr class="intervention-row" onmouseover="this.style.backgroundColor='#f9f9f9'" onmouseout="this.style.backgroundColor=''">
                                        <td style="padding: 12px 15px; border-bottom: 1px solid #eee;"><%= intervention.getLieu() %></td>
                                        <td style="padding: 12px 15px; border-bottom: 1px solid #eee;"><%= intervention.getDate() %></td>
                                        <td style="padding: 12px 15px; border-bottom: 1px solid #eee;"><%= intervention.getHeureAppel() %></td>
                                        <td style="padding: 12px 15px; border-bottom: 1px solid #eee;"><%= intervention.getHeureArrivee() %></td>
                                        <td style="padding: 12px 15px; border-bottom: 1px solid #eee;"><%= intervention.getDuree() %></td>
                                        <td style="padding: 12px 15px; border-bottom: 1px solid #eee; text-align: center;">
                                            <a href="../ServletIntervention/consulter?idIntervention=<%= intervention.getId() %>" title="Voir l'intervention">
                                                <i class="las la-eye" style="font-size: 20px; color: #3498db; cursor: pointer;"></i>
                                            </a>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</main>

<style>
    .info-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 20px;
    }
    
    .info-item {
        display: flex;
        flex-direction: column;
        margin-bottom: 5px;
    }
    
    .info-label {
        font-size: 14px;
        color: #777;
        margin-bottom: 5px;
        display: flex;
        align-items: center;
    }
    
    .info-label i {
        margin-right: 5px;
        color: var(--primary-color);
    }
    
    .info-value {
        background-color: #f8f9fa;
        padding: 10px 15px;
        border-radius: 5px;
        border: 1px solid #eee;
        font-weight: 500;
    }
    
    .badge {
        display: inline-block;
        padding: 5px 10px;
        border-radius: 15px;
        font-size: 13px;
    }
    
    .intervention-row {
        transition: background-color 0.2s;
    }
    
    @media (max-width: 768px) {
        .info-grid {
            grid-template-columns: 1fr;
        }
    }
</style>