<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Pompier"%>
<%@page import="model.Grade"%>
<%@page import="model.Surgrade"%>
<%@page import="java.util.ArrayList"%>
<jsp:include page="/vues/commun.jsp" />

<main>
    <%
        Grade g = (Grade)request.getAttribute("pGrade");
        if (g != null) {
    %>
    <div class="page-header">
        <h1>Grade : <%= g.getLibelle() %></h1>
        <% if (g.getSurgrade() != null) { %>
            <small>
                <i class="las la-medal"></i> 
                Catégorie : <%= g.getSurgrade().getLibelle() %> | 
                <i class="las la-map-marker"></i> SDIS Calvados
            </small>
        <% } else { %>
            <small><i class="las la-map-marker"></i> SDIS Calvados</small>
        <% } %>
    </div>
    
    <div class="page-content">
        <!-- Carte d'information du grade -->
        <div class="grade-info-card">
            <div class="grade-header">
                <div class="grade-icon">
                    <i class="las la-medal"></i>
                </div>
                <div class="grade-details">
                    <h2><%= g.getLibelle() %></h2>
                    <% if (g.getDescription() != null && !g.getDescription().isEmpty()) { %>
                        <p><%= g.getDescription() %></p>
                    <% } %>
                </div>
            </div>
            
            <div class="grade-stats">
                <div class="stat-item">
                    <div class="stat-value"><%= g.getLesPompiers().size() %></div>
                    <div class="stat-label">Pompiers</div>
                </div>
                <% if (g.getSurgrade() != null) { %>
                <div class="stat-item">
                    <div class="stat-value"><%= g.getSurgrade().getLibelle() %></div>
                    <div class="stat-label">Catégorie</div>
                </div>
                <% } %>
            </div>
        </div>
        
        <!-- Liste des pompiers -->
        <div class="section-header">
            <h2><i class="las la-users"></i> Pompiers avec ce grade</h2>
            <div class="action-buttons">
                <div class="search-box">
                    <i class="las la-search"></i>
                    <input type="text" id="searchPompier" placeholder="Rechercher un pompier..." oninput="filterPompiers()">
                </div>
                <div class="add">
                    <a href="../ServletPompier/ajouter" class="btn-add">
                        <i class="las la-user-plus"></i> Ajouter un pompier
                    </a>
                </div>
            </div>
        </div>
        
        <% if (g.getLesPompiers() != null && !g.getLesPompiers().isEmpty()) { %>
            <div class="pompiers-grid">
                <% for (Pompier p : g.getLesPompiers()) { %>
                    <div class="pompier-card" data-name="<%= (p.getNom() + " " + p.getPrenom()).toLowerCase() %>">
                        <div class="pompier-avatar">
                            <i class="las la-user"></i>
                        </div>
                        <div class="pompier-info">
                            <h3><%= p.getNom() %> <%= p.getPrenom() %></h3>
                            <% if (p.getUneCaserne() != null) { %>
                                <p><i class="las la-building"></i> <%= p.getUneCaserne().getNom() %></p>
                            <% } %>
                            <% if (p.getBip() != null && !p.getBip().isEmpty()) { %>
                                <p><i class="las la-broadcast-tower"></i> BIP: <%= p.getBip() %></p>
                            <% } %>
                            <div class="pompier-actions">
                                <a href="../ServletPompier/consulter?idPompier=<%= p.getId() %>" class="btn-view">
                                    <i class="las la-eye"></i> Profil complet
                                </a>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } else { %>
            <div class="empty-state">
                <i class="las la-user-slash"></i>
                <h3>Aucun pompier n'a ce grade</h3>
                <p>Il n'y a actuellement aucun pompier possédant le grade <%= g.getLibelle() %>.</p>
                <a href="../ServletPompier/ajouter" class="btn-primary">
                    <i class="las la-user-plus"></i> Ajouter un pompier
                </a>
            </div>
        <% } %>
    </div>
    <% } else { %>
    <div class="page-header">
        <h1>Détail du grade</h1>
        <small><i class="las la-exclamation-circle"></i> Aucune information disponible</small>
    </div>
    <div class="page-content">
        <div class="error-state">
            <i class="las la-exclamation-triangle"></i>
            <h3>Grade introuvable</h3>
            <p>Le grade que vous recherchez n'existe pas ou a été supprimé.</p>
            <div class="error-actions">
                <a href="../ServletGrade/lister" class="btn-primary">
                    <i class="las la-list"></i> Voir tous les grades
                </a>
            </div>
        </div>
    </div>
    <% } %>
</main>

<style>
    .grade-info-card {
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        margin-bottom: 30px;
        overflow: hidden;
    }
    
    .grade-header {
        display: flex;
        padding: 20px;
        border-bottom: 1px solid #eee;
    }
    
    .grade-icon {
        font-size: 2.5rem;
        color: #DA001B;
        margin-right: 20px;
        display: flex;
        align-items: center;
    }
    
    .grade-details h2 {
        margin: 0 0 10px;
        color: #333;
    }
    
    .grade-details p {
        margin: 0;
        color: #666;
    }
    
    .grade-stats {
        display: flex;
        padding: 15px;
        background: #f9f9f9;
    }
    
    .stat-item {
        flex: 1;
        text-align: center;
        padding: 10px;
    }
    
    .stat-value {
        font-size: 1.8rem;
        font-weight: bold;
        color: #333;
    }
    
    .stat-label {
        font-size: 0.9rem;
        color: #666;
    }
    
    .section-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        flex-wrap: wrap;
        gap: 15px;
    }
    
    .section-header h2 {
        margin: 0;
        display: flex;
        align-items: center;
        font-size: 1.3rem;
        color: #333;
    }
    
    .section-header h2 i {
        margin-right: 10px;
        color: #DA001B;
    }
    
    .action-buttons {
        display: flex;
        gap: 15px;
        align-items: center;
    }
    
    .search-box {
        display: flex;
        align-items: center;
        background: white;
        border-radius: 5px;
        padding: 8px 15px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        width: 250px;
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
    
    .btn-add {
        display: inline-flex;
        align-items: center;
        background: #DA001B;
        color: white;
        padding: 8px 15px;
        border-radius: 5px;
        text-decoration: none;
        font-weight: 500;
        transition: background 0.3s;
    }
    
    .btn-add:hover {
        background: #b80016;
    }
    
    .btn-add i {
        margin-right: 8px;
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
        width: 80px;
        display: flex;
        align-items: center;
        justify-content: center;
        background: linear-gradient(135deg, #DA001B, #ff3c54);
        color: white;
        font-size: 2rem;
    }
    
    .pompier-info {
        flex: 1;
        padding: 15px;
    }
    
    .pompier-info h3 {
        margin: 0 0 10px;
        color: #333;
    }
    
    .pompier-info p {
        margin: 5px 0;
        color: #666;
        display: flex;
        align-items: center;
    }
    
    .pompier-info p i {
        margin-right: 8px;
        color: #DA001B;
        width: 16px;
        text-align: center;
    }
    
    .pompier-actions {
        margin-top: 15px;
    }
    
    .btn-view {
        display: inline-flex;
        align-items: center;
        padding: 6px 12px;
        background: #f0f0f0;
        color: #333;
        border-radius: 5px;
        text-decoration: none;
        transition: background 0.3s;
        font-size: 0.9rem;
    }
    
    .btn-view:hover {
        background: #e0e0e0;
    }
    
    .btn-view i {
        margin-right: 6px;
    }
    
    .empty-state, .error-state {
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        padding: 50px 20px;
        text-align: center;
    }
    
    .empty-state i, .error-state i {
        font-size: 3rem;
        color: #DA001B;
        margin-bottom: 20px;
    }
    
    .empty-state h3, .error-state h3 {
        margin: 0 0 10px;
        font-size: 1.5rem;
        color: #333;
    }
    
    .empty-state p, .error-state p {
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
        .section-header {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .action-buttons {
            width: 100%;
            flex-direction: column;
        }
        
        .search-box {
            width: 100%;
        }
        
        .btn-add {
            width: 100%;
            justify-content: center;
        }
    }
</style>

<script>
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