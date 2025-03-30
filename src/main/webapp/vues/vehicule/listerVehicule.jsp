<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Pompier"%>
<%@page import="model.Caserne"%>
<%@page import="model.Vehicule"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<jsp:include page="/vues/commun.jsp" />

<%
    ArrayList<Vehicule> lesVehicules = (ArrayList)request.getAttribute("vLesVehicules");
    
    // Regrouper les véhicules par type pour l'affichage
    HashMap<String, ArrayList<Vehicule>> vehiculesParType = new HashMap<>();
    
    for (Vehicule v : lesVehicules) {
        String typeVehicule = v.getTypeVehicule().getNom();
        if (!vehiculesParType.containsKey(typeVehicule)) {
            vehiculesParType.put(typeVehicule, new ArrayList<Vehicule>());
        }
        vehiculesParType.get(typeVehicule).add(v);
    }
%>

<main>
    <div class="page-header">
        <h1>Liste des véhicules</h1>
        <small>Calvados / Caen</small>
    </div>
    
    <div class="page-content">
        <!-- Barre de recherche et bouton d'ajout -->
        <div class="records">
            <div class="record-header">
                <div class="browse">
                    <div style="position: relative; width: 300px;">
                        <input type="text" id="searchVehicule" placeholder="Rechercher un véhicule..." 
                               style="width: 100%; padding: 10px 15px 10px 40px; border: 1px solid var(--medium-gray); 
                                      border-radius: var(--border-radius);" onkeyup="searchVehicules()">
                        <i class="las la-search" style="position: absolute; left: 15px; top: 12px; color: var(--dark-gray);"></i>
                    </div>
                </div>
                <div class="add">
                    <button><a href="../ServletVehicule/ajouter"><i class="las la-plus"></i> Ajouter un véhicule</a></button>
                </div>
            </div>
        </div>
        
        <!-- Stats -->
        <div style="display: flex; flex-wrap: wrap; margin-bottom: 20px; gap: 15px;">
            <div style="flex: 1; min-width: 200px; background-color: var(--white); border-radius: var(--border-radius); 
                        box-shadow: var(--shadow); padding: 20px; display: flex; align-items: center;">
                <i class="las la-car" style="font-size: 40px; color: var(--primary-color); margin-right: 15px;"></i>
                <div>
                    <h3 style="font-size: 24px; margin-bottom: 5px;"><%= lesVehicules.size() %></h3>
                    <p style="color: var(--dark-gray); margin: 0;">Véhicules</p>
                </div>
            </div>
            <div style="flex: 1; min-width: 200px; background-color: var(--white); border-radius: var(--border-radius); 
                        box-shadow: var(--shadow); padding: 20px; display: flex; align-items: center;">
                <i class="las la-tags" style="font-size: 40px; color: var(--primary-color); margin-right: 15px;"></i>
                <div>
                    <h3 style="font-size: 24px; margin-bottom: 5px;"><%= vehiculesParType.size() %></h3>
                    <p style="color: var(--dark-gray); margin: 0;">Types de véhicules</p>
                </div>
            </div>
        </div>
        
        <!-- Liste des véhicules par type -->
        <% for (Map.Entry<String, ArrayList<Vehicule>> entry : vehiculesParType.entrySet()) { %>
            <div class="vehicule-section records" style="margin-bottom: 20px;" data-type="<%= entry.getKey().toLowerCase() %>">
                <div class="record-header" style="background-color: var(--light-gray);">
                    <h2 style="display: flex; align-items: center; margin: 0; font-size: 18px;">
                        <i class="las la-truck" style="font-size: 24px; margin-right: 10px; color: var(--primary-color);"></i>
                        Type: <%= entry.getKey() %>
                    </h2>
                    <div style="background-color: var(--primary-color); color: var(--white); padding: 5px 10px; 
                                border-radius: 15px; font-size: 14px;">
                        <%= entry.getValue().size() %> véhicules
                    </div>
                </div>
                
                <div class="casernes-container">
                    <% for (Vehicule v : entry.getValue()) { %>
                        <div class="caserne vehicule-card" data-immat="<%= v.getImmat().toLowerCase() %>">
                            <i class="las la-car-side" style="font-size: 48px; margin-right: 20px; color: var(--primary-color);"></i>
                            <div style="flex-grow: 1;">
                                <p style="font-weight: bold; margin-bottom: 5px; margin-top: 0;"><%= v.getImmat() %></p>
                                <p style="color: var(--dark-gray); font-size: 0.9rem; margin: 0;"><%= entry.getKey() %></p>
                            </div>
                            <div class="actions">
                                <a href="../ServletVehicule/consulter?idVehicule=<%= v.getId() %>" style="text-decoration: none;">
                                    <button style="background-color: #333; border: none; color: white; padding: 6px 12px; border-radius: 4px; cursor: pointer;">
                                        Détails
                                    </button>
                                </a>
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
        <% } %>
    </div>
</main>

<script>
    function searchVehicules() {
        const searchTerm = document.getElementById('searchVehicule').value.toLowerCase();
        const vehicules = document.querySelectorAll('.vehicule-card');
        
        vehicules.forEach(vehicule => {
            const immat = vehicule.getAttribute('data-immat');
            if (immat.includes(searchTerm)) {
                vehicule.style.display = '';
            } else {
                vehicule.style.display = 'none';
            }
        });
        
        // Masquer les sections de types vides
        const typeSections = document.querySelectorAll('.vehicule-section');
        typeSections.forEach(section => {
            const visibleVehicules = section.querySelectorAll('.vehicule-card:not([style="display: none"])').length;
            if (visibleVehicules === 0) {
                section.style.display = 'none';
            } else {
                section.style.display = '';
            }
        });
    }
</script>