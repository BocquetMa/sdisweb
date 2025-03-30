<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Pompier"%>
<%@page import="model.Fonction"%>
<%@page import="model.Caserne"%>
<%@page import="model.Grade"%>
<%@page import="form.FormPompier"%>
<%@page import="model.Intervention"%>
<%@page import="java.util.ArrayList"%>
<jsp:include page="/vues/commun.jsp" />

<% 
    FormPompier form = (FormPompier)request.getAttribute("form");
    ArrayList<Caserne> lesCasernes = (ArrayList)request.getAttribute("pLesCasernes");
    ArrayList<Grade> lesGrades = (ArrayList)request.getAttribute("pLesGrades");
%>

<main>
    <div class="page-header">
        <h1>Ajouter un pompier</h1>
        <small>Calvados / Caen</small>
    </div>
    
    <div class="page-content">
        <div class="records">
            <div class="record-header">
                <div style="display: flex; align-items: center;">
                    <i class="las la-user-plus" style="font-size: 24px; margin-right: 10px; color: var(--primary-color);"></i>
                    <h2 style="margin: 0; font-size: 18px;">Informations du pompier</h2>
                </div>
                <div>
                    <a href="../ServletPompier/lister" style="text-decoration: none;">
                        <button style="background-color: #333; border: none; color: white; padding: 8px 15px; border-radius: 4px; cursor: pointer; display: flex; align-items: center;">
                            <i class="las la-list" style="margin-right: 5px;"></i> Liste des pompiers
                        </button>
                    </a>
                </div>
            </div>
            
            <div style="padding: 25px;">
                <form action="ajouter" method="POST" id="formPompier">
                    <div style="display: flex; flex-wrap: wrap; margin-bottom: 30px; gap: 20px;">
                        <div style="flex: 1; min-width: 300px; display: flex; flex-direction: column; align-items: center; justify-content: center; padding: 20px; background-color: var(--light-gray); border-radius: 10px;">
                            <div style="width: 150px; height: 150px; border-radius: 50%; background-color: var(--primary-color); display: flex; align-items: center; justify-content: center; margin-bottom: 20px;">
                                <i class="las la-user" style="font-size: 80px; color: white;"></i>
                            </div>
                            <p style="text-align: center; color: var(--dark-gray); margin-top: 10px;">
                                Ajout d'un nouveau membre<br>à l'équipe des pompiers
                            </p>
                        </div>
                        
                        <div style="flex: 2; min-width: 400px;">
                            <div style="display: flex; flex-wrap: wrap; gap: 20px;">
                                <!-- Colonne gauche -->
                                <div style="flex: 1; min-width: 250px;">
                                    <div class="field-group">
                                        <label for="nom">
                                            <i class="las la-user-tag" style="margin-right: 5px;"></i>Nom
                                        </label>
                                        <input type="text" id="nom" name="nom" placeholder="Nom du pompier" class="form-input" required>
                                    </div>
                                    
                                    <div class="field-group">
                                        <label for="prenom">
                                            <i class="las la-user-tag" style="margin-right: 5px;"></i>Prénom
                                        </label>
                                        <input type="text" id="prenom" name="prenom" placeholder="Prénom du pompier" class="form-input" required>
                                    </div>
                                    
                                    <div class="field-group">
                                        <label for="sexe">
                                            <i class="las la-venus-mars" style="margin-right: 5px;"></i>Sexe
                                        </label>
                                        <select id="sexe" name="sexe" class="form-input" required>
                                            <option value="" disabled selected>Sélectionner</option>
                                            <option value="H">Homme</option>
                                            <option value="F">Femme</option>
                                        </select>
                                    </div>
                                    
                                    <div class="field-group">
                                        <label for="dateNaissance">
                                            <i class="las la-calendar" style="margin-right: 5px;"></i>Date de naissance
                                        </label>
                                        <input type="date" id="dateNaissance" name="dateNaissance" class="form-input" required>
                                    </div>
                                </div>
                                
                                <!-- Colonne droite -->
                                <div style="flex: 1; min-width: 250px;">
                                    <div class="field-group">
                                        <label for="telephone">
                                            <i class="las la-phone" style="margin-right: 5px;"></i>Téléphone
                                        </label>
                                        <input type="tel" id="telephone" name="telephone" placeholder="Ex: 06 XX XX XX XX" class="form-input" required>
                                    </div>
                                    
                                    <div class="field-group">
                                        <label for="numBip">
                                            <i class="las la-broadcast-tower" style="margin-right: 5px;"></i>Numéro Bip
                                        </label>
                                        <input type="text" id="numBip" name="numBip" placeholder="Numéro de bip" class="form-input" required>
                                    </div>
                                    
                                    <div class="field-group">
                                        <label for="idGrade">
                                            <i class="las la-medal" style="margin-right: 5px;"></i>Grade
                                        </label>
                                        <select id="idGrade" name="idGrade" class="form-input" required>
                                            <option value="" disabled selected>Sélectionner</option>
                                            <% for (Grade g : lesGrades) { %>
                                                <option value="<%= g.getId() %>"><%= g.getLibelle() %></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    
                                    <div class="field-group">
                                        <label for="idCaserne">
                                            <i class="las la-building" style="margin-right: 5px;"></i>Caserne
                                        </label>
                                        <select id="idCaserne" name="idCaserne" class="form-input" required>
                                            <option value="" disabled selected>Sélectionner</option>
                                            <% for (Caserne c : lesCasernes) { %>
                                                <option value="<%= c.getId() %>"><%= c.getNom() %></option>
                                            <% } %>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div style="display: flex; justify-content: flex-end; gap: 15px; margin-top: 20px;">
                        <button type="button" onclick="location.href='../ServletPompier/lister'" style="background-color: #999; border: none; color: white; padding: 12px 20px; border-radius: 4px; cursor: pointer;">
                            Annuler
                        </button>
                        <button type="submit" name="valider" id="valider" style="background-color: var(--primary-color); border: none; color: white; padding: 12px 20px; border-radius: 4px; cursor: pointer; display: flex; align-items: center;">
                            <i class="las la-save" style="margin-right: 8px;"></i> Enregistrer
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>

<style>
    .field-group {
        margin-bottom: 20px;
    }
    
    .field-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 500;
        color: var(--secondary-color);
    }
    
    .form-input {
        width: 100%;
        padding: 12px 15px;
        border: 1px solid var(--medium-gray);
        border-radius: var(--border-radius);
        font-size: 14px;
        transition: var(--transition);
    }
    
    .form-input:focus {
        border-color: var(--primary-color);
        box-shadow: 0 0 0 2px rgba(218, 0, 27, 0.2);
        outline: none;
    }
    
    .form-input::placeholder {
        color: #aaa;
    }

    select.form-input {
        appearance: none;
        background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%23999' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
        background-repeat: no-repeat;
        background-position: right 15px center;
        background-size: 15px;
        padding-right: 40px;
    }
    
    /* Animation de transition pour les boutons */
    button {
        transition: transform 0.2s, box-shadow 0.2s;
    }
    
    button:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    
    /* Validation de formulaire styles */
    .form-input:valid {
        border-color: #2ecc71;
    }
    
    .form-input:invalid:not(:placeholder-shown) {
        border-color: #e74c3c;
    }
</style>

<script>
    // Validation des champs téléphone
    document.getElementById('telephone').addEventListener('input', function(e) {
        let value = e.target.value.replace(/\D/g, '');
        
        // Format téléphone: XX XX XX XX XX
        if (value.length > 0) {
            value = value.match(new RegExp('.{1,2}', 'g')).join(' ');
        }
        
        e.target.value = value;
    });
    
    // Animation des champs au focus
    const inputs = document.querySelectorAll('.form-input');
    
    inputs.forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.style.transform = 'translateY(-5px)';
            this.parentElement.style.transition = 'transform 0.3s';
        });
        
        input.addEventListener('blur', function() {
            this.parentElement.style.transform = 'translateY(0)';
        });
    });
</script>