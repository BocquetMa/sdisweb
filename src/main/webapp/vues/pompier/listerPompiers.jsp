<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Pompier"%>
<%@page import="model.Caserne"%>
<%@page import="model.Vehicule"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<jsp:include page="/vues/commun.jsp" />

<%
    ArrayList<Pompier> lesPompiers = (ArrayList)request.getAttribute("pLesPompiers");
    
    // Regrouper les pompiers par caserne pour l'affichage
    HashMap<String, ArrayList<Pompier>> pompiersParCaserne = new HashMap<>();
    
    for (Pompier p : lesPompiers) {
        String nomCaserne = p.getUneCaserne().getNom();
        if (!pompiersParCaserne.containsKey(nomCaserne)) {
            pompiersParCaserne.put(nomCaserne, new ArrayList<Pompier>());
        }
        pompiersParCaserne.get(nomCaserne).add(p);
    }
%>

<main>
    <div class="page-header">
        <h1>Liste des pompiers</h1>
        <small>Calvados / Caen</small>
    </div>
    
    <div class="page-content">
        <!-- Barre de recherche et bouton d'ajout -->
        <div class="records">
            <div class="record-header">
                <div class="browse">
                    <div style="position: relative; width: 300px;">
                        <input type="text" id="searchPompier" placeholder="Rechercher un pompier..." 
                               style="width: 100%; padding: 10px 15px 10px 40px; border: 1px solid var(--medium-gray); 
                                      border-radius: var(--border-radius);" onkeyup="searchPompiers()">
                        <i class="las la-search" style="position: absolute; left: 15px; top: 12px; color: var(--dark-gray);"></i>
                    </div>
                </div>
                <div class="add">
                    <button><a href="../ServletPompier/ajouter"><i class="las la-plus"></i> Ajouter un pompier</a></button>
                </div>
            </div>
        </div>
        
        <!-- Stats -->
        <div style="display: flex; flex-wrap: wrap; margin-bottom: 20px; gap: 15px;">
            <div style="flex: 1; min-width: 200px; background-color: var(--white); border-radius: var(--border-radius); 
                        box-shadow: var(--shadow); padding: 20px; display: flex; align-items: center;">
                <i class="las la-user-friends" style="font-size: 40px; color: var(--primary-color); margin-right: 15px;"></i>
                <div>
                    <h3 style="font-size: 24px; margin-bottom: 5px;"><%= lesPompiers.size() %></h3>
                    <p style="color: var(--dark-gray); margin: 0;">Pompiers</p>
                </div>
            </div>
            <div style="flex: 1; min-width: 200px; background-color: var(--white); border-radius: var(--border-radius); 
                        box-shadow: var(--shadow); padding: 20px; display: flex; align-items: center;">
                <i class="las la-building" style="font-size: 40px; color: var(--primary-color); margin-right: 15px;"></i>
                <div>
                    <h3 style="font-size: 24px; margin-bottom: 5px;"><%= pompiersParCaserne.size() %></h3>
                    <p style="color: var(--dark-gray); margin: 0;">Casernes</p>
                </div>
            </div>
        </div>
        
        <!-- Liste des pompiers par caserne -->
        <% for (Map.Entry<String, ArrayList<Pompier>> entry : pompiersParCaserne.entrySet()) { %>
            <div class="caserne-section records" style="margin-bottom: 20px;" data-caserne="<%= entry.getKey().toLowerCase() %>">
                <div class="record-header" style="background-color: var(--light-gray);">
                    <h2 style="display: flex; align-items: center; margin: 0; font-size: 18px;">
                        <i class="las la-building" style="font-size: 24px; margin-right: 10px; color: var(--primary-color);"></i>
                        Caserne: <%= entry.getKey() %>
                    </h2>
                    <div style="background-color: var(--primary-color); color: var(--white); padding: 5px 10px; 
                                border-radius: 15px; font-size: 14px;">
                        <%= entry.getValue().size() %> pompiers
                    </div>
                </div>
                
                <div class="casernes-container">
                    <% for (Pompier p : entry.getValue()) { %>
                        <div class="caserne pompier-card" data-nom="<%= p.getNom().toLowerCase() %> <%= p.getPrenom().toLowerCase() %>">
                            <i class="las la-user-circle"></i>
                            <div style="flex-grow: 1;">
                                <p style="font-weight: bold; margin-bottom: 5px; margin-top: 0;"><%= p.getNom() %> <%= p.getPrenom() %></p>
                                <p style="color: var(--dark-gray); font-size: 0.9rem; margin: 0;"><%= entry.getKey() %></p>
                            </div>
                            <div class="actions">
                                <a href="../ServletPompier/consulter?idPompier=<%= p.getId() %>" style="text-decoration: none;">
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
    function searchPompiers() {
        const searchTerm = document.getElementById('searchPompier').value.toLowerCase();
        const pompiers = document.querySelectorAll('.pompier-card');
        
        pompiers.forEach(pompier => {
            const nomPrenom = pompier.getAttribute('data-nom');
            if (nomPrenom.includes(searchTerm)) {
                pompier.style.display = '';
            } else {
                pompier.style.display = 'none';
            }
        });
        
        // Masquer les sections de casernes vides
        const caserneSections = document.querySelectorAll('.caserne-section');
        caserneSections.forEach(section => {
            const visiblePompiers = section.querySelectorAll('.pompier-card:not([style="display: none"])').length;
            if (visiblePompiers === 0) {
                section.style.display = 'none';
            } else {
                section.style.display = '';
            }
        });
    }
</script>