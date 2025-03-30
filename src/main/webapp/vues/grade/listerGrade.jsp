<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Grade"%>
<%@page import="java.util.ArrayList"%>
<jsp:include page="/vues/commun.jsp" />

<main>
    <div class="page-header">
        <h1>Grades des sapeurs-pompiers</h1>
        <small><i class="las la-medal"></i> Hiérarchie du SDIS Calvados</small>
    </div>
    
    <div class="page-content">
        <div class="action-bar">
            <div class="search-box">
                <i class="las la-search"></i>
                <input type="text" id="searchGrade" placeholder="Rechercher un grade..." oninput="filterGrades()">
            </div>
            <div class="filter-box">
                <label for="filterSurgrade">Filtrer par catégorie:</label>
                <select id="filterSurgrade" onchange="filterGrades()">
                    <option value="">Tous</option>
                    <option value="officier">Officier</option>
                    <option value="sous-officier">Sous-officier</option>
                    <option value="sapeur">Sapeur</option>
                </select>
            </div>
            <div class="add-button">
                <a href="../ServletGrade/ajouter" class="btn-add">
                    <i class="las la-plus"></i> Ajouter un grade
                </a>
            </div>
        </div>
        
        <!-- Visualisation des grades par catégorie -->
        <div id="grades-display">
            <% 
            ArrayList<Grade> lesGrades = (ArrayList<Grade>) request.getAttribute("pLesGrades");
            if (lesGrades != null && !lesGrades.isEmpty()) {
                // Regrouper les grades par surgrade
                java.util.Map<String, java.util.List<Grade>> gradesBySurgrade = new java.util.HashMap<>();
                
                for (Grade g : lesGrades) {
                    String surgradeLibelle = g.getSurgrade().getLibelle();
                    if (!gradesBySurgrade.containsKey(surgradeLibelle)) {
                        gradesBySurgrade.put(surgradeLibelle, new java.util.ArrayList<>());
                    }
                    gradesBySurgrade.get(surgradeLibelle).add(g);
                }
                
                // Afficher les grades par catégorie
                for (String surgradeLibelle : gradesBySurgrade.keySet()) {
            %>
                <div class="surgrade-section" id="surgrade-<%= surgradeLibelle.toLowerCase().replace(" ", "-") %>">
                    <h2 class="surgrade-title">
                        <% 
                        String icon = "las la-medal";
                        if (surgradeLibelle.equalsIgnoreCase("Officier")) {
                            icon = "las la-star";
                        } else if (surgradeLibelle.equalsIgnoreCase("Sous-officier")) {
                            icon = "las la-certificate";
                        } else if (surgradeLibelle.equalsIgnoreCase("Sapeur")) {
                            icon = "las la-shield-alt";
                        }
                        %>
                        <i class="<%= icon %>"></i> <%= surgradeLibelle %>
                    </h2>
                    
                    <div class="grades-grid">
                        <% for (Grade g : gradesBySurgrade.get(surgradeLibelle)) { %>
                            <div class="grade-card" data-name="<%= g.getLibelle().toLowerCase() %>" data-surgrade="<%= g.getSurgrade().getLibelle().toLowerCase() %>">
                                <div class="grade-header">
                                    <div class="grade-icon">
                                        <i class="<%= icon %>"></i>
                                    </div>
                                    <h3><%= g.getLibelle() %></h3>
                                </div>
                                
                                <div class="grade-content">
                                    <% if (g.getDescription() != null && !g.getDescription().isEmpty()) { %>
                                        <p class="grade-description"><%= g.getDescription() %></p>
                                    <% } else { %>
                                        <p class="grade-description">Aucune description disponible.</p>
                                    <% } %>
                                    
                                    <% if (g.getLesPompiers() != null) { %>
                                        <div class="grade-stats">
                                            <div class="stat">
                                                <span class="stat-value"><%= g.getLesPompiers().size() %></span>
                                                <span class="stat-label">Pompiers</span>
                                            </div>
                                        </div>
                                    <% } %>
                                </div>
                                
                                <div class="grade-actions">
                                    <a href="../ServletGrade/consulter?idGrade=<%= g.getId() %>" class="btn-view">
                                        <i class="las la-eye"></i> Consulter
                                    </a>
                                    <a href="../ServletGrade/modifier?idGrade=<%= g.getId() %>" class="btn-edit">
                                        <i class="las la-edit"></i>
                                    </a>
                                </div>
                            </div>
                        <% } %>
                    </div>
                </div>
            <% 
                }
            } else { 
            %>
                <div class="empty-state">
                    <i class="las la-medal"></i>
                    <h3>Aucun grade disponible</h3>
                    <p>Commencez par ajouter un nouveau grade pour organiser la hiérarchie des pompiers.</p>
                    <a href="../ServletGrade/ajouter" class="btn-primary">
                        <i class="las la-plus"></i> Ajouter un grade
                    </a>
                </div>
            <% } %>
        </div>
    </div>
</main>

<style>
    .action-bar {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
        margin-bottom: 25px;
        align-items: center;
    }
    
    .search-box {
        display: flex;
        align-items: center;
        background: white;
        border-radius: 5px;
        padding: 8px 15px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        flex: 1;
        min-width: 200px;
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
    
    .filter-box {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .filter-box label {
        color: #555;
        font-weight: 500;
    }
    
    .filter-box select {
        padding: 8px 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
        background: white;
        color: #333;
        outline: none;
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
        white-space: nowrap;
    }
    
    .btn-add:hover {
        background: #b80016;
    }
    
    .btn-add i {
        margin-right: 8px;
    }
    
    .surgrade-section {
        margin-bottom: 30px;
    }
    
    .surgrade-title {
        font-size: 1.4rem;
        color: #333;
        margin: 0 0 15px;
        padding-bottom: 10px;
        border-bottom: 2px solid #f0f0f0;
        display: flex;
        align-items: center;
    }
    
    .surgrade-title i {
        margin-right: 10px;
        color: #DA001B;
    }
    
    .grades-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 20px;
    }
    
    .grade-card {
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        overflow: hidden;
        display: flex;
        flex-direction: column;
        transition: transform 0.3s;
    }
    
    .grade-card:hover {
        transform: translateY(-5px);
    }
    
    .grade-header {
        padding: 15px;
        background: linear-gradient(to right, #f8f8f8, white);
        display: flex;
        align-items: center;
        border-bottom: 1px solid #eee;
    }
    
    .grade-icon {
        font-size: 1.8rem;
        color: #DA001B;
        margin-right: 15px;
        width: 40px;
        height: 40px;
        background: rgba(218, 0, 27, 0.1);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .grade-header h3 {
        margin: 0;
        color: #333;
        font-size: 1.1rem;
    }
    
    .grade-content {
        padding: 15px;
        flex-grow: 1;
    }
    
    .grade-description {
        color: #666;
        margin: 0 0 15px;
        font-size: 0.9rem;
        line-height: 1.5;
    }
    
    .grade-stats {
        display: flex;
        justify-content: space-around;
        margin-top: 15px;
        padding-top: 15px;
        border-top: 1px solid #eee;
    }
    
    .stat {
        text-align: center;
    }
    
    .stat-value {
        display: block;
        font-size: 1.5rem;
        font-weight: bold;
        color: #333;
    }
    
    .stat-label {
        display: block;
        font-size: 0.8rem;
        color: #777;
    }
    
    .grade-actions {
        display: flex;
        justify-content: space-between;
        padding: 10px 15px;
        background: #f8f8f8;
        border-top: 1px solid #eee;
    }
    
    .btn-view, .btn-edit {
        display: inline-flex;
        align-items: center;
        text-decoration: none;
        border-radius: 4px;
        transition: background 0.3s;
    }
    
    .btn-view {
        background: #f0f0f0;
        color: #333;
        padding: 6px 12px;
    }
    
    .btn-view:hover {
        background: #e0e0e0;
    }
    
    .btn-view i {
        margin-right: 6px;
    }
    
    .btn-edit {
        background: #f0f0f0;
        color: #666;
        width: 32px;
        height: 32px;
        justify-content: center;
    }
    
    .btn-edit:hover {
        background: #e0e0e0;
        color: #333;
    }
    
    .empty-state {
        text-align: center;
        padding: 50px 20px;
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    .empty-state i {
        font-size: 3rem;
        color: #ddd;
        margin-bottom: 20px;
    }
    
    .empty-state h3 {
        font-size: 1.5rem;
        color: #333;
        margin-bottom: 10px;
    }
    
    .empty-state p {
        color: #666;
        margin-bottom: 20px;
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
        .action-bar {
            flex-direction: column;
            align-items: stretch;
        }
        
        .search-box, .filter-box {
            width: 100%;
        }
        
        .filter-box {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .btn-add {
            width: 100%;
            justify-content: center;
        }
    }
</style>

<script>
    function filterGrades() {
        const searchTerm = document.getElementById('searchGrade').value.toLowerCase();
        const surgradeFilter = document.getElementById('filterSurgrade').value.toLowerCase();
        const grades = document.querySelectorAll('.grade-card');
        
        grades.forEach(grade => {
            const gradeName = grade.dataset.name;
            const gradeSurgrade = grade.dataset.surgrade;
            
            const matchesSearch = gradeName.includes(searchTerm);
            const matchesSurgrade = surgradeFilter === '' || gradeSurgrade.includes(surgradeFilter);
            
            if (matchesSearch && matchesSurgrade) {
                grade.style.display = 'flex';
            } else {
                grade.style.display = 'none';
            }
        });
        
        // Masquer les sections sans grades visibles
        document.querySelectorAll('.surgrade-section').forEach(section => {
            const visibleGrades = section.querySelectorAll('.grade-card[style="display: flex"]').length;
            section.style.display = visibleGrades > 0 ? 'block' : 'none';
        });
    }
</script>