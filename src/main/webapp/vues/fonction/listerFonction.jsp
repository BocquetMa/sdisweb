<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Fonction"%>
<%@page import="java.util.ArrayList"%>
<jsp:include page="/vues/commun.jsp" />

<main>
    <div class="page-header">
        <h1>Fonctions des pompiers</h1>
        <small><i class="las la-tasks"></i> Spécialités et compétences des pompiers du SDIS</small>
    </div>
    
    <div class="page-content">
        <div class="action-bar">
            <div class="search-wrapper">
                <div class="search-box">
                    <i class="las la-search"></i>
                    <input type="text" id="searchFunction" placeholder="Rechercher une fonction..." oninput="filterFunctions()">
                </div>
            </div>
            <div class="action-buttons">
                <a href="../ServletFonction/ajouter" class="btn-add">
                    <i class="las la-plus"></i> Ajouter une fonction
                </a>
            </div>
        </div>
        
        <div class="functions-grid">
            <% 
            ArrayList<Fonction> lesFonctions = (ArrayList)request.getAttribute("pLesFonctions");
            if(lesFonctions != null && !lesFonctions.isEmpty()) {
                for (Fonction f : lesFonctions) { 
            %>
                <div class="function-card" data-name="<%= f.getLibelle().toLowerCase() %>">
                    <div class="function-icon">
                        <% 
                        // Choisir une icône en fonction du libellé de la fonction
                        String icon = "las la-tasks";
                        String libelle = f.getLibelle().toLowerCase();
                        
                        if (libelle.contains("secour")) {
                            icon = "las la-first-aid";
                        } else if (libelle.contains("conduc") || libelle.contains("chauffeur")) {
                            icon = "las la-truck";
                        } else if (libelle.contains("plongeur") || libelle.contains("aqua")) {
                            icon = "las la-water";
                        } else if (libelle.contains("form")) {
                            icon = "las la-chalkboard-teacher";
                        } else if (libelle.contains("command") || libelle.contains("chef")) {
                            icon = "las la-user-tie";
                        } else if (libelle.contains("incendie") || libelle.contains("feu")) {
                            icon = "las la-fire-extinguisher";
                        } else if (libelle.contains("sauvetage") || libelle.contains("hauteur")) {
                            icon = "las la-mountain";
                        }
                        %>
                        <i class="<%= icon %>"></i>
                    </div>
                    <div class="function-content">
                        <h2><%= f.getLibelle() %></h2>
                        <% if (f.getDescription() != null && !f.getDescription().trim().isEmpty()) { %>
                            <p class="description"><%= f.getDescription() %></p>
                        <% } else { %>
                            <p class="description">Aucune description disponible</p>
                        <% } %>
                        
                        <div class="function-footer">
                            <a href="../ServletFonction/consulter?idFonction=<%= f.getId() %>" class="btn-view">
                                <i class="las la-eye"></i> Consulter
                            </a>
                            <a href="../ServletFonction/modifier?idFonction=<%= f.getId() %>" class="btn-edit">
                                <i class="las la-edit"></i>
                            </a>
                        </div>
                    </div>
                </div>
            <% 
                }
            } else { 
            %>
                <div class="empty-state">
                    <i class="las la-clipboard-list"></i>
                    <h3>Aucune fonction disponible</h3>
                    <p>Commencez par ajouter une nouvelle fonction pour les pompiers.</p>
                    <a href="../ServletFonction/ajouter" class="btn-primary">
                        <i class="las la-plus"></i> Ajouter une fonction
                    </a>
                </div>
            <% } %>
        </div>
    </div>
</main>

<style>
    .action-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    
    .search-box {
        display: flex;
        align-items: center;
        background: white;
        border-radius: 5px;
        padding: 10px 15px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        width: 300px;
    }
    
    .search-box i {
        color: #777;
        margin-right: 10px;
        font-size: 1.2rem;
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
        padding: 10px 15px;
        border-radius: 5px;
        text-decoration: none;
        font-weight: 500;
        transition: background-color 0.3s;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    
    .btn-add:hover {
        background: #b80016;
    }
    
    .btn-add i {
        margin-right: 8px;
    }
    
    .functions-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 20px;
    }
    
    .function-card {
        background: white;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        transition: transform 0.3s, box-shadow 0.3s;
        height: 100%;
        display: flex;
        flex-direction: column;
    }
    
    .function-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.15);
    }
    
    .function-icon {
        background: linear-gradient(135deg, #DA001B, #ff3c54);
        color: white;
        height: 100px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 3rem;
    }
    
    .function-content {
        padding: 20px;
        flex-grow: 1;
        display: flex;
        flex-direction: column;
    }
    
    .function-content h2 {
        margin: 0 0 15px 0;
        color: #333;
        font-size: 1.3rem;
    }
    
    .description {
        color: #666;
        font-size: 0.9rem;
        margin-bottom: 20px;
        flex-grow: 1;
        font-style: italic;
    }
    
    .function-footer {
        margin-top: auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .btn-view {
        display: inline-flex;
        align-items: center;
        background: #f0f0f0;
        color: #333;
        padding: 8px 15px;
        border-radius: 5px;
        text-decoration: none;
        transition: background-color 0.3s;
    }
    
    .btn-view:hover {
        background: #e0e0e0;
    }
    
    .btn-view i {
        margin-right: 8px;
    }
    
    .btn-edit {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        background: #f0f0f0;
        color: #666;
        width: 36px;
        height: 36px;
        border-radius: 5px;
        text-decoration: none;
        transition: background-color 0.3s, color 0.3s;
    }
    
    .btn-edit:hover {
        background: #e0e0e0;
        color: #333;
    }
    
    .empty-state {
        grid-column: 1 / -1;
        text-align: center;
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        padding: 50px 20px;
    }
    
    .empty-state i {
        font-size: 4rem;
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
            gap: 15px;
        }
        
        .search-box {
            width: 100%;
        }
    }
</style>

<script>
    function filterFunctions() {
        const searchTerm = document.getElementById('searchFunction').value.toLowerCase();
        const functions = document.querySelectorAll('.function-card');
        
        functions.forEach(functionCard => {
            const name = functionCard.dataset.name;
            
            if (name.includes(searchTerm)) {
                functionCard.style.display = 'flex';
            } else {
                functionCard.style.display = 'none';
            }
        });
    }
</script>