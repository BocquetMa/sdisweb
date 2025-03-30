<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="form.FormFonction"%>
<jsp:include page="/vues/commun.jsp" />

<main>
    <div class="page-header">
        <h1>Ajouter une nouvelle fonction</h1>
        <small><i class="las la-tasks"></i> Création d'une fonction pour les pompiers</small>
    </div>
    
    <div class="page-content">
        <div class="form-container">
            <%
                FormFonction form = (FormFonction)request.getAttribute("form");
                String errorMessage = "";
                if (form != null && !form.getErreurs().isEmpty()) {
                    errorMessage = form.getErreurs().get("libelle");
                }
            %>
            
            <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
            <div class="alert alert-danger">
                <i class="las la-exclamation-circle"></i>
                <%= errorMessage %>
            </div>
            <% } %>
            
            <form class="form-card" action="ajouter" method="POST">
                <div class="form-group">
                    <label for="libelle">Libellé de la fonction</label>
                    <input id="libelle" type="text" name="libelle" required placeholder="Ex: Secouriste, Conducteur, Plongeur...">
                    <small>Le libellé doit contenir au moins 3 caractères</small>
                </div>
                
                <div class="form-group">
                    <label for="description">Description (optionnelle)</label>
                    <textarea id="description" name="description" rows="4" placeholder="Décrivez les responsabilités et compétences liées à cette fonction..."></textarea>
                </div>
                
                <div class="form-actions">
                    <a href="../ServletFonction/lister" class="btn-secondary">
                        <i class="las la-times"></i> Annuler
                    </a>
                    <button type="submit" name="valider" id="valider" class="btn-primary">
                        <i class="las la-save"></i> Enregistrer
                    </button>
                </div>
            </form>
        </div>
    </div>
</main>

<style>
    .form-container {
        max-width: 800px;
        margin: 0 auto;
    }
    
    .form-card {
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        padding: 30px;
    }
    
    .form-group {
        margin-bottom: 25px;
    }
    
    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
        color: #333;
    }
    
    .form-group input, 
    .form-group textarea, 
    .form-group select {
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 16px;
        transition: border-color 0.3s;
    }
    
    .form-group input:focus, 
    .form-group textarea:focus, 
    .form-group select:focus {
        border-color: #DA001B;
        outline: none;
        box-shadow: 0 0 0 2px rgba(218, 0, 27, 0.2);
    }
    
    .form-group small {
        display: block;
        margin-top: 5px;
        color: #666;
        font-size: 12px;
    }
    
    .form-actions {
        display: flex;
        justify-content: flex-end;
        margin-top: 30px;
        gap: 15px;
    }
    
    .btn-primary, 
    .btn-secondary {
        padding: 12px 20px;
        border-radius: 5px;
        font-weight: bold;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        text-decoration: none;
        transition: all 0.3s;
    }
    
    .btn-primary {
        background-color: #DA001B;
        color: white;
        border: none;
    }
    
    .btn-primary:hover {
        background-color: #b80016;
    }
    
    .btn-secondary {
        background-color: #f5f5f5;
        color: #333;
        border: 1px solid #ddd;
    }
    
    .btn-secondary:hover {
        background-color: #e5e5e5;
    }
    
    .btn-primary i, 
    .btn-secondary i {
        margin-right: 8px;
        font-size: 18px;
    }
    
    .alert {
        padding: 15px;
        border-radius: 5px;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
    }
    
    .alert i {
        font-size: 20px;
        margin-right: 10px;
    }
    
    .alert-danger {
        background-color: #ffebee;
        color: #c62828;
        border-left: 4px solid #c62828;
    }
    
    @media (max-width: 768px) {
        .form-card {
            padding: 20px;
        }
        
        .form-actions {
            flex-direction: column;
        }
        
        .btn-primary, 
        .btn-secondary {
            width: 100%;
            justify-content: center;
        }
    }
</style>