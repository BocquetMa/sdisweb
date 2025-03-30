<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Caserne"%>
<%@page import="java.util.ArrayList"%>
<jsp:include page="/vues/commun.jsp" />

<main>
    <div class="page-header">
        <h1>Casernes du SDIS Calvados</h1>
        <small><i class="las la-map-marker"></i> Réseau départemental des casernes de pompiers</small>
    </div>
    
    <div class="page-content">
        <div class="record-header">
            <div class="search-box">
                <i class="las la-search"></i>
                <input type="text" id="searchCaserne" placeholder="Rechercher une caserne..." oninput="filterCasernes()">
            </div>
            <div class="add">
                <button><a href="../ServletCaserne/ajouter"><i class="las la-plus"></i> Ajouter une caserne</a></button>
            </div>
        </div> 
        
        <div class="caserne-stats">
            <div class="stat-card">
                <div class="stat-icon"><i class="las la-building"></i></div>
                <div class="stat-content">
                    <h3>
                        <% 
                            ArrayList<Caserne> lesCasernes = (ArrayList)request.getAttribute("pLesCasernes");
                            out.print(lesCasernes != null ? lesCasernes.size() : 0);
                        %>
                    </h3>
                    <p>Casernes actives</p>
                </div>
            </div>
        </div>
        
        <div class="casernes-grid">
            <% 
            if(lesCasernes != null && !lesCasernes.isEmpty()) {
                for (Caserne c : lesCasernes) { 
            %>
                <div class="caserne-card" data-name="<%= c.getNom().toLowerCase() %>" data-city="<%= c.getVille().toLowerCase() %>">
                    <div class="caserne-icon">
                        <i class="las la-fire-extinguisher"></i>
                    </div>
                    <div class="caserne-info">
                        <h2><%= c.getNom() %></h2>
                        <p><i class="las la-map-marker"></i> <%= c.getRue() %></p>
                        <p><i class="las la-city"></i> <%= c.getCopos() %> <%= c.getVille() %></p>
                        <% if (c.getLesPompiers() != null) { %>
                        <div class="caserne-stats">
                            <span><i class="las la-users"></i> <%= c.getLesPompiers().size() %> pompiers</span>
                            <% if (c.getLesVehicules() != null) { %>
                            <span><i class="las la-truck"></i> <%= c.getLesVehicules().size() %> véhicules</span>
                            <% } %>
                        </div>
                        <% } %>
                        <a href="../ServletCaserne/consulter?idCaserne=<%= c.getId() %>" class="btn-consult">
                            <i class="las la-eye"></i> Consulter
                        </a>
                    </div>
                </div>
            <% 
                }
            } else {
            %>
                <div class="empty-state">
                    <i class="las la-search"></i>
                    <p>Aucune caserne trouvée</p>
                    <a href="../ServletCaserne/ajouter" class="btn-add">
                        <i class="las la-plus"></i> Ajouter une caserne
                    </a>
                </div>
            <% } %>
        </div>
    </div>
</main>

<style>
    .search-box {
        display: flex;
        align-items: center;
        background: #fff;
        border-radius: 5px;
        padding: 8px 15px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
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
    
    .caserne-stats {
        display: flex;
        gap: 20px;
        margin-bottom: 20px;
    }
    
    .stat-card {
        background: #fff;
        border-radius: 5px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        padding: 20px;
        display: flex;
        align-items: center;
    }
    
    .stat-icon {
        font-size: 2.5rem;
        color: #DA001B;
        margin-right: 20px;
    }
    
    .stat-content h3 {
        font-size: 2rem;
        margin: 0;
        color: #333;
    }
    
    .stat-content p {
        margin: 5px 0 0;
        color: #777;
    }
    
    .casernes-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 20px;
    }
    
    .caserne-card {
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        overflow: hidden;
        transition: transform 0.3s, box-shadow 0.3s;
    }
    
    .caserne-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.15);
    }
    
    .caserne-icon {
        background: #DA001B;
        color: white;
        padding: 20px;
        font-size: 2rem;
        text-align: center;
    }
    
    .caserne-info {
        padding: 20px;
    }
    
    .caserne-info h2 {
        margin: 0 0 15px;
        color: #333;
        font-size: 1.5rem;
    }
    
    .caserne-info p {
        margin: 8px 0;
        color: #666;
    }
    
    .caserne-info i {
        width: 20px;
        text-align: center;
        margin-right: 5px;
        color: #DA001B;
    }
    
    .caserne-stats {
        display: flex;
        justify-content: space-between;
        margin: 15px 0;
        font-size: 0.9rem;
        color: #777;
    }
    
    .btn-consult {
        display: inline-block;
        background: #DA001B;
        color: white;
        padding: 8px 15px;
        border-radius: 5px;
        text-decoration: none;
        margin-top: 10px;
        transition: background 0.3s;
    }
    
    .btn-consult:hover {
        background: #b80016;
    }
    
    .empty-state {
        grid-column: 1 / -1;
        text-align: center;
        padding: 50px 20px;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    .empty-state i {
        font-size: 3rem;
        color: #ddd;
        margin-bottom: 20px;
    }
    
    .empty-state p {
        color: #777;
        margin-bottom: 20px;
    }
    
    .btn-add {
        display: inline-block;
        background: #DA001B;
        color: white;
        padding: 10px 20px;
        border-radius: 5px;
        text-decoration: none;
    }
    
    @media (max-width: 768px) {
        .search-box {
            width: 100%;
        }
        
        .casernes-grid {
            grid-template-columns: 1fr;
        }
    }
</style>

<script>
    function filterCasernes() {
        const searchTerm = document.getElementById('searchCaserne').value.toLowerCase();
        const casernes = document.querySelectorAll('.caserne-card');
        
        casernes.forEach(caserne => {
            const name = caserne.dataset.name;
            const city = caserne.dataset.city;
            
            if (name.includes(searchTerm) || city.includes(searchTerm)) {
                caserne.style.display = 'block';
            } else {
                caserne.style.display = 'none';
            }
        });
    }
</script>