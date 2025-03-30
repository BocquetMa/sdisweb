<%-- 
    Document   : style
    Created on : 6 avr. 2024, 00:51:08
    Author     : mathe
    Modified on: 30 mar. 2025
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SDIS Web - Styles</title>
        <!-- Ajout de Line Awesome pour les icônes -->
        <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
        <style>
            /* Style commun pour l'application SDIS Web */

            :root {
                --primary-color: #DA001B;
                --secondary-color: #333333;
                --light-gray: #f5f5f5;
                --medium-gray: #e0e0e0;
                --dark-gray: #555555;
                --white: #ffffff;
                --shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                --transition: all 0.3s ease;
                --border-radius: 5px;
                --font-main: 'Arial', sans-serif;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: var(--font-main);
            }

            body {
                background-color: var(--light-gray);
                color: var(--secondary-color);
                line-height: 1.6;
            }

            /* Header et navigation latérale */
            .sidebar {
                position: fixed;
                height: 100%;
                width: 220px;
                left: 0;
                bottom: 0;
                top: 0;
                z-index: 100;
                background: var(--primary-color);
                transition: var(--transition);
                box-shadow: var(--shadow);
            }

            .side-header {
                background: #b80016;
                height: 60px;
                display: flex;
                justify-content: center;
                align-items: center;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            }

            .side-header h3, .side-header span {
                color: var(--white);
                font-weight: 500;
                font-size: 1.2rem;
                letter-spacing: 1px;
            }

            .side-content {
                height: calc(100vh - 60px);
                overflow: auto;
                padding: 10px 0;
            }

            .side-content::-webkit-scrollbar {
                width: 5px;
            }

            .side-content::-webkit-scrollbar-track {
                background: rgba(255, 255, 255, 0.1);
            }

            .side-content::-webkit-scrollbar-thumb {
                background: rgba(255, 255, 255, 0.3);
                border-radius: 10px;
            }

            .side-content::-webkit-scrollbar-thumb:hover {
                background: rgba(255, 255, 255, 0.5);
            }

            .profile {
                text-align: center;
                padding: 2rem 0rem;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                margin-bottom: 1rem;
            }

            .profile-img {
                height: 80px;
                width: 80px;
                display: inline-block;
                margin: 0 auto .5rem auto;
                border: 3px solid var(--white);
                border-radius: 50%;
                background-position: center;
                background-size: cover;
            }

            .profile h4 {
                color: var(--white);
                font-weight: 500;
                font-size: 1.1rem;
                margin-bottom: 0.5rem;
            }

            .profile small {
                color: var(--white);
                opacity: 0.8;
                font-weight: 400;
                font-size: 0.9rem;
            }

            .separator {
                height: 1px;
                background-color: rgba(255, 255, 255, 0.1);
                margin: 5px 15px;
            }

            .side-menu ul {
                padding: 0 15px;
            }

            .side-menu a {
                display: flex;
                align-items: center;
                padding: 12px 15px;
                border-radius: var(--border-radius);
                text-decoration: none;
                transition: var(--transition);
                color: var(--white);
                margin-bottom: 5px;
            }

            .side-menu a:hover {
                background: rgba(255, 255, 255, 0.1);
            }

            .side-menu a.active {
                background: rgba(255, 255, 255, 0.2);
            }

            .side-menu a span:first-child {
                font-size: 1.3rem;
                margin-right: 10px;
                display: inline-block;
                width: 20px;
            }

            .side-menu a small {
                font-size: 0.9rem;
            }

            /* Toggle pour le menu sur mobile */
            #menu-toggle {
                display: none;
            }

            #menu-toggle:checked ~ .sidebar {
                left: -220px;
            }

            #menu-toggle:checked ~ .main-content {
                margin-left: 0;
                width: 100%;
            }

            /* Contenu principal */
            .main-content {
                margin-left: 220px;
                width: calc(100% - 220px);
                transition: var(--transition);
                min-height: 100vh;
            }

            header {
                position: fixed;
                right: 0;
                top: 0;
                left: 220px;
                z-index: 99;
                height: 60px;
                background: var(--white);
                box-shadow: var(--shadow);
                transition: var(--transition);
                display: flex;
                align-items: center;
                padding: 0 20px;
            }

            .header-content {
                display: flex;
                align-items: center;
                justify-content: space-between;
                width: 100%;
            }

            .header-content label {
                cursor: pointer;
                font-size: 1.3rem;
                color: var(--secondary-color);
            }

            .header-menu {
                display: flex;
                align-items: center;
            }

            .user {
                display: flex;
                align-items: center;
                cursor: pointer;
            }

            .user .bg-img {
                height: 40px;
                width: 40px;
                border-radius: 50%;
                background-position: center;
                background-size: cover;
                margin-right: 10px;
            }

            .user span {
                font-size: 0.9rem;
                color: var(--dark-gray);
            }

            /* Contenu de la page */
            main {
                padding-top: 60px;
            }

            .page-header {
                padding: 30px;
                background: var(--white);
                border-bottom: 1px solid var(--medium-gray);
            }

            .page-header h1 {
                font-size: 1.8rem;
                color: var(--secondary-color);
                margin-bottom: 10px;
            }

            .page-header small {
                color: var(--dark-gray);
                font-size: 0.9rem;
            }

            .page-content {
                padding: 30px;
                background: var(--light-gray);
                min-height: calc(100vh - 60px - 91px); /* 100vh - header - page-header */
            }

            /* Tableaux et listes */
            .records {
                background: var(--white);
                border-radius: var(--border-radius);
                box-shadow: var(--shadow);
                margin-bottom: 30px;
            }

            .record-header {
                padding: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 1px solid var(--medium-gray);
            }

            .browse, .add {
                display: flex;
                align-items: center;
            }

            .add button {
                background-color: var(--primary-color);
                color: var(--white);
                border: none;
                padding: 10px 15px;
                border-radius: var(--border-radius);
                font-weight: 500;
                cursor: pointer;
                transition: var(--transition);
            }

            .add button:hover {
                background-color: #b80016;
            }

            .add button a {
                color: var(--white);
                text-decoration: none;
            }

            .table-responsive {
                width: 100%;
                overflow-x: auto;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            table thead tr {
                background: var(--light-gray);
            }

            table th, table td {
                padding: 12px 15px;
                text-align: left;
                border-bottom: 1px solid var(--medium-gray);
            }

            table th {
                font-weight: 600;
                color: var(--secondary-color);
                font-size: 0.9rem;
            }

            table tbody tr:hover {
                background-color: rgba(0, 0, 0, 0.02);
            }

            /* Style pour les cartes */
            .casernes-container, .grade-container {
                display: flex;
                flex-wrap: wrap;
                margin: -10px;
            }

            .caserne, .grade-card {
                flex: 0 0 calc(33.33% - 20px);
                margin: 10px;
                background-color: var(--white);
                border-radius: var(--border-radius);
                box-shadow: var(--shadow);
                padding: 20px;
                position: relative;
                transition: var(--transition);
            }

            .caserne:hover, .grade-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
            }

            .caserne i {
                font-size: 40px;
                color: var(--primary-color);
                margin-right: 15px;
            }

            .actions button, .consult-button {
                background-color: var(--primary-color);
                color: var(--white);
                border: none;
                padding: 8px 12px;
                border-radius: var(--border-radius);
                cursor: pointer;
                font-size: 0.85rem;
                transition: var(--transition);
            }

            .actions button:hover, .consult-button:hover {
                background-color: #b80016;
            }

            /* Style pour les formulaires */
            .pompier-container {
                display: flex;
                flex-wrap: wrap;
                margin: -15px;
            }

            .un, .deux {
                flex: 1;
                padding: 15px;
            }

            .pompierInfo {
                margin-bottom: 20px;
            }

            .pompierInfo strong {
                display: inline-block;
                width: 150px;
                color: var(--secondary-color);
            }

            .pompierInfo .spanConsulter {
                display: inline-block;
                padding: 10px;
                background-color: var(--light-gray);
                border-radius: var(--border-radius);
                border: 1px solid var(--medium-gray);
                min-width: 250px;
            }

            .pompierInfo input, .pompierInfo select {
                width: 100%;
                padding: 10px;
                border: 1px solid var(--medium-gray);
                border-radius: var(--border-radius);
                background-color: var(--white);
            }

            input[type="submit"] {
                background-color: var(--primary-color);
                color: var(--white);
                border: none;
                padding: 12px 20px;
                border-radius: var(--border-radius);
                cursor: pointer;
                font-weight: 500;
                margin-top: 20px;
                transition: var(--transition);
            }

            input[type="submit"]:hover {
                background-color: #b80016;
            }

            /* Responsive */
            @media only screen and (max-width: 1200px) {
                .caserne, .grade-card {
                    flex: 0 0 calc(50% - 20px);
                }
            }

            @media only screen and (max-width: 992px) {
                .sidebar {
                    left: -220px;
                }
                
                .main-content {
                    margin-left: 0;
                    width: 100%;
                }
                
                header {
                    left: 0;
                }
                
                #menu-toggle:checked ~ .sidebar {
                    left: 0;
                }
                
                #menu-toggle:checked ~ .main-content {
                    margin-left: 220px;
                    width: calc(100% - 220px);
                }
                
                #menu-toggle:checked ~ .main-content header {
                    left: 220px;
                    width: calc(100% - 220px);
                }
            }

            @media only screen and (max-width: 768px) {
                .caserne, .grade-card {
                    flex: 0 0 calc(100% - 20px);
                }
                
                .un, .deux {
                    flex: 0 0 100%;
                }
                
                .page-header, .page-content {
                    padding: 15px;
                }
                
                #menu-toggle:checked ~ .main-content {
                    margin-left: 0;
                    width: 100%;
                }
                
                #menu-toggle:checked ~ .main-content header {
                    left: 0;
                    width: 100%;
                }
                
                .sidebar {
                    width: 100%;
                    z-index: 200;
                }
            }
        </style>
    </head>
    <body>
        <!-- Ce fichier ne contient que des styles, pas de contenu HTML visible -->
    </body>
</html>