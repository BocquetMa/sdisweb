<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Pompier"%>
<%@page import="model.Fonction"%>
<%@page import="java.util.ArrayList"%>
<jsp:include page="/vues/commun.jsp" />

<main>
    <div class="page-header">
        <% Fonction fonction = (Fonction)request.getAttribute("fNom"); %>
        <% if (fonction != null) { %>
            <h1>Fonction : <%= fonction.getLibelle() %></h1>
            <% if (fonction.getDescription() != null && !fonction.getDescription().isEmpty()) { %>
                <small><i class="las la-info-circle"></i> <%= fonction.getDescription() %></small>
            <% } else { %>
                <small><i class="las la-tasks"></i> Personnel qualifié pour cette fonction</small>
            <% } %>
        <% } else { %>
            <h1>Détail de la fonction</h1>
            <small><i class="las la-exclamation-circle"></i> Aucune fonction n'a été trouvée</small>
        <% } %>
    </div>
    
    <div class="page-content">
        <% if (fonction != null) { %>
            <!-- Statistiques -->
            <div class="function-stats">
                <div class="stat-card">
                    <div class="stat-value">
                        <% 
                            ArrayList<Pompier> lesPompiers = (ArrayList<Pompier>) request.getAttribute("lesPompiers");
                            out.print(lesPompiers != null ? lesPompiers.size() : 0);
                        %>
                    </div>
                    <div class="stat-label">
                        <i class="las la-user-shield"></i> Pompiers qualifiés
                    </div>
                </div>
            </div>
            
            <!-- Actions -->
            <div class="action-bar">
                <div class="search-box">
                    <i class="las la-search"></i>
                    <input type="text" id="searchPompier" placeholder="Rechercher un pompier..." oninput="filterPompiers()">
                </div>
                <div class="action-buttons">
                    <a href="../ServletFonction/modifier?idFonction=<%= fonction.getId() %>" class="btn btn-secondary">
                        <i class="las la-edit"></i> Modifier
                    </a>
                    <a href="../ServletFonction/ajouter" class="btn btn-primary">
                        <i class="las la-plus"></i> Ajouter une fonction
                    </a>
                </div>
            </div>
            
            <!-- Liste des pompiers -->
            <h2 class="section-title"><i class="las la-users"></i> Pompiers ayant cette fonction</h2>
            
            <% if (lesPompiers != null && !lesPompiers.isEmpty()) { %>
                <div class="pompiers-grid">
                    <% for (Pompier p : lesPompiers) { %>
                        <div class="pompier-card" data-name="<%= p.getNom().toLowerCase() + " " + p.getPrenom().toLowerCase() %>">
                            <div class="pompier-avatar">
                                <i class="las la-user-circle"></i>
                            </div>
                            <div class="pompier-info">
                                <h3><%= p.getNom() %> <%= p.getPrenom() %></h3>
                                <% if (p.getUneCaserne() != null) { %>
                                    <p><i class="las la-building"></i> <%= p.getUneCaserne().getNom() %></p>
                                <% } %>
                                <% if (p.getUnGrade() != null) { %>
                                    <p><i class="las la-medal"></i> <%= p.getUnGrade().getLibelle() %></p>
                                <% } %>
                                <a href="../ServletPompier/consulter?idPompier=<%= p.getId() %>" class="btn-view">
                                    <i class="las la-eye"></i> Voir le profil
                                </a>
                            </div>
                        </div>
                    <% } %>
                </div>
            <% } else { %>
                <div class="empty-state">
                    <i class="las la-user-slash"></i>
                    <p>Aucun pompier n'est assigné à cette fonction</p>
                    <a href="../ServletPompier/ajouter" class="btn btn-primary">
                        <i class="las la-user-plus"></i> Ajouter un pompier
                    </a>
                </div>
            <% } %>
        <% } else { %>
            <div class="error-state">
                <i class="las la-exclamation-triangle"></i>
                <h3>Fonction introuvable</h3>
                <p>La fonction que vous recherchez n'existe pas ou a été supprimée.</p>
                <div class="error-actions">
                    <a href="../ServletFonction/lister" class="btn btn-primary">
                        <i class="las la-list"></i> Voir toutes les fonctions
                    </a>
                </div>
            </div>
        <% } %>
    </div>
</main>

<style>
    .function-stats {
        display: flex;
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .stat-card {
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        padding: 20px;
        min-width: 200px;
        text-align: center;
    }
    
    .stat-value {
        font-size: 2.5rem;
        font-weight: bold;
        color: #DA001B;
    }
    
    .stat-label {
        margin-top: 10px;
        color: #555;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 5px;
    }
    
    .action-bar {
        display: flex;
        justify-content: space-between;
        margin-bottom: 20px;
        align-items: center;
    }
    
    .search-box {
        display: flex;
        align-items: center;
        background: white;
        border-radius: 5px;
        padding: 8px 15px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        width: 300px;
    }
    
    .search-box i {
        color: #777;
        margin-right: 10px;
    }
    
    .search-box input {
        border: none;
        outline: none;
        width: 100%;
        color: #333;
    }
    
    .action-buttons {
        display: flex;
        gap: 10px;
    }
    
    .btn {
        padding: 8px 15px;
        border-radius: 5px;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 5px;
        font-weight: 500;
    }
    
    .btn-primary {
        background: #DA001B;
        color: white;
    }
    
    .btn-secondary {
        background: #f0f0f0;
        color: #333;
    }
    
    .section-title {
        font-size: 1.2rem;
        margin: 20px 0;
        color: #333;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .section-title i {
        color: #DA001B;
    }
    
    .pompiers-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 20px;
    }
    
    .pompier-card {
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        display: flex;
        overflow: hidden;
        transition: transform 0.3s;
    }
    
    .pompier-card:hover {
        transform: translateY(-5px);
    }
    
    .pompier-avatar {
        background: linear-gradient(135deg, #DA001B, #ff3c54);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 2.5rem;
        width: 80px;
    }
    
    .pompier-info {
        padding: 15px;
        flex: 1;
    }
    
    .pompier-info h3 {
        margin: 0 0 10px;
        font-size: 1.1rem;
        color: #333;
    }
    
    .pompier-info p {
        margin: 5px 0;
        font-size: 0.9rem;
        color: #666;
        display: flex;
        align-items: center;
        gap: 5px;
    }
    
    .pompier-info i {
        color: #DA001B;
    }
    
    .btn-view {
        display: inline-flex;
        align-items: center;
        gap: 5px;
        margin-top: 10px;
        padding: 5px 10px;
        background: #f0f0f0;
        color: #333;
        border-radius: 5px;
        text-decoration: none;
        font-size: 0.9rem;
        transition: background 0.3s;
    }
    
    .btn-view:hover {
        background: #e0e0e0;
    }
    
    .empty-state, .error-state {
        text-align: center;
        padding: 50px 20px;
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
    
    .empty-state i, .error-state i {
        font-size: 3rem;
        color: #DA001B;
        margin-bottom: 20px;
    }
    
    .empty-state p, .error-state p {
        color: #666;
        margin-bottom: 20px;
    }
    
    .error-state h3 {
        font-size: 1.5rem;
        color: #333;
        margin-bottom: 10px;
    }
    
    .error-actions {
        margin-top: 20px;
    }
    
    @media (max-width: 768px) {
        .action-bar {
            flex-direction: column;
            gap: 15px;
            align-items: stretch;
        }
        
        .search-box {
            width: 100%;
        }
        
        .action-buttons {
            justify-content: space-between;
        }
    }
</style>

<script>
    // Fonction pour filtrer les pompiers en fonction de la recherche
    function filterPompiers() {
        const searchTerm = document.getElementById('searchPompier').value.toLowerCase();
        const pompiers = document.querySelectorAll('.pompier-card');
        
        pompiers.forEach(pompier => {
            const name = pompier.dataset.name;
            
            if (name.includes(searchTerm)) {
                pompier.style.display = 'flex';
            } else {
                pompier.style.display = 'none';
            }
        });
    }
</script>