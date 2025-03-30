/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import model.Caserne;
import model.Fonction;
import model.Grade;
import model.Intervention;
import model.Pompier;

/**
 *
 * @author zakina
 */
public class DaoPompier {
    
    Connection conn;
    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;
    
    public static ArrayList<Pompier> getLesPompiers(Connection conn){
        if (conn == null) {
            System.out.println("Erreur : La connexion est nulle !");
            return new ArrayList<>();  // Retourne une liste vide en cas d'erreur
        }

        ArrayList<Pompier> lesPompiers = new ArrayList<Pompier>();
        try {
            requeteSql = conn.prepareStatement("SELECT pompier.id AS p_id, pompier.nom AS p_nom, pompier.prenom AS p_prenom, caserne.id AS c_id, caserne.nom AS c_nom FROM pompier INNER JOIN caserne ON pompier.caserne_id = caserne.id;");
            resultatRequete = requeteSql.executeQuery();

            while (resultatRequete.next()) {
                Pompier p = new Pompier();
                p.setId(resultatRequete.getInt("p_id"));
                p.setNom(resultatRequete.getString("p_nom"));
                p.setPrenom(resultatRequete.getString("p_prenom"));

                Caserne c = new Caserne();
                c.setId(resultatRequete.getInt("c_id"));
                c.setNom(resultatRequete.getString("c_nom"));

                p.setUneCaserne(c);
                lesPompiers.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLesPompiers a généré une erreur");
        }
        return lesPompiers;
    }

    
    public static ArrayList<Fonction> getLesFonctionsByPompier(Connection conn, int idPompier){
        
        ArrayList<Fonction> lesFonctions = new ArrayList<Fonction>();
        Fonction f = null;
        
        try{
            requeteSql = conn.prepareStatement ("SELECT fonction.id AS f_id, fonction.libelle AS f_libelle FROM fonction INNER JOIN pompier_fonction ON fonction.id = pompier_fonction.fonction_id WHERE pompier_fonction.pompier_id = ?;");
            requeteSql.setInt(1, idPompier);
            resultatRequete = requeteSql.executeQuery();
        
        while (resultatRequete.next()){
            
            f = new Fonction();
            f.setId(resultatRequete.getInt("f_id"));
            f.setLibelle(resultatRequete.getString("f_libelle"));
            
            lesFonctions.add(f);
            }
        }
        
        
        catch (SQLException e){
            e.printStackTrace();
            System.out.println("La requête de getFonctionById  a généré une erreur");
        }
        return lesFonctions;
    }
    
    public static ArrayList<Intervention> getLesInterventionsByPompier(Connection conn, int idPompier){
        
        ArrayList<Intervention> lesInterventions = new ArrayList<Intervention>();
        Intervention i = null;
        
        try{
            requeteSql = conn.prepareStatement ("SELECT intervention.id AS i_id, intervention.lieu AS i_lieu, intervention.date AS i_date, intervention.heureAppel AS i_heureAppel, intervention.heureArrivee AS i_heureArrivee, intervention.duree AS i_duree FROM intervention INNER JOIN pompier_intervention ON intervention.id = pompier_intervention.intervention_id WHERE pompier_intervention.pompier_id = ?;");
            requeteSql.setInt(1, idPompier);
            resultatRequete = requeteSql.executeQuery();
        
        while (resultatRequete.next()){
            
            i = new Intervention();
            i.setId(resultatRequete.getInt("i_id"));
            i.setLieu(resultatRequete.getString("i_lieu"));
            
            Date date = resultatRequete.getDate("i_date");
            i.setDate(date.toLocalDate());
                    
            i.setHeureAppel(resultatRequete.getString("i_heureAppel"));
            i.setHeureArrivee(resultatRequete.getString("i_heureArrivee"));
            i.setDuree(resultatRequete.getString("i_duree"));
            
            lesInterventions.add(i);
            }
        }
        
        
        catch (SQLException e){
            e.printStackTrace();
            System.out.println("La requête de getLesInterventionsByPompier a généré une erreur");
        }
        return lesInterventions;
    }
                
    public static Pompier getPompierById(Connection conn, int idPompier){
        
        Pompier p = null ;
        try{
            requeteSql = conn.prepareStatement("SELECT pompier.id AS p_id, pompier.nom AS p_nom, pompier.sexe AS p_sexe, pompier.telephone AS p_telephone, pompier.prenom AS p_prenom, pompier.dateNaissance AS p_dateNaissance, caserne.id AS c_id, caserne.nom AS c_nom, grade.id AS g_id, grade.libelle AS g_libelle, pompier.numeroBip AS p_numeroBip "
                    + "FROM pompier "
                    + "INNER JOIN caserne ON pompier.caserne_id = caserne.id "
                    + "INNER JOIN grade ON pompier.grade_id = grade.id "
                    + "where pompier.id= ?; ");
            requeteSql.setInt(1, idPompier);
            resultatRequete = requeteSql.executeQuery();
            
            if (resultatRequete.next()){
                
                    p = new Pompier();
                    p.setId(resultatRequete.getInt("p_id"));
                    p.setNom(resultatRequete.getString("p_nom"));
                    p.setPrenom(resultatRequete.getString("p_prenom"));
                    p.setSexe(resultatRequete.getString("p_sexe"));
                    p.setTelephone(resultatRequete.getString("p_telephone"));
                    p.setPrenom(resultatRequete.getString("p_prenom"));
                    p.setBip(resultatRequete.getString("p_numeroBip"));
                    
                    Date dateNaissance = resultatRequete.getDate("p_dateNaissance");
                    p.setDateNaissance(dateNaissance.toLocalDate());
                    
                    
                    Caserne c = new Caserne();
                    c.setId(resultatRequete.getInt("c_id"));
                    c.setNom(resultatRequete.getString("c_nom"));
                    p.setUneCaserne(c);
                    
                    Grade g = new Grade();
                    g.setId(resultatRequete.getInt("g_id"));
                    g.setLibelle(resultatRequete.getString("g_libelle"));
                    p.setUnGrade(g);
                
                    ArrayList<Fonction> lesFonctions = DaoPompier.getLesFonctionsByPompier(conn, idPompier);
                    p.setLesFonctions(lesFonctions);
                    
                   ArrayList<Intervention> lesInterventions = DaoPompier.getLesInterventionsByPompier(conn, idPompier);
                   p.setLesInterventions(lesInterventions);
            }
           
        }
        catch (SQLException e){
            e.printStackTrace();
            System.out.println("La requête de getPompierById  a généré une erreur");
        }
        return p ;
    }
    
    
    
    public static Pompier addPompier(Connection connection, Pompier p){      
        int idGenere = -1;
        try
        {
            //preparation de la requete
            // id (clé primaire de la table client) est en auto_increment,donc on ne renseigne pas cette valeur
            // la paramètre RETURN_GENERATED_KEYS est ajouté à la requête afin de pouvoir récupérer l'id généré par la bdd (voir ci-dessous)
            // supprimer ce paramètre en cas de requête sans auto_increment.
            requeteSql=connection.prepareStatement("INSERT INTO pompier ( nom, sexe, telephone, caserne_id, dateNaissance, prenom, grade_id, numeroBip)\n" +
                    " VALUES (?,?,?,?,?,?,?,?)", requeteSql.RETURN_GENERATED_KEYS );
            requeteSql.setString(1, p.getNom());
            requeteSql.setString(2, p.getSexe());
            requeteSql.setString(3, p.getTelephone());
            requeteSql.setInt(4, p.getUneCaserne().getId());
            
            LocalDate dateNaiss = p.getDateNaissance();
            Date DateNaissance = Date.valueOf(dateNaiss);
            
            requeteSql.setDate(5, DateNaissance);
            requeteSql.setString(6, p.getPrenom());
            requeteSql.setInt(7, p.getUnGrade().getId());
            requeteSql.setString(8, p.getBip());
            

           /* Exécution de la requête */
            requeteSql.executeUpdate();
            
             // Récupération de id auto-généré par la bdd dans la table client
            resultatRequete = requeteSql.getGeneratedKeys();
            while ( resultatRequete.next() ) {
                idGenere = resultatRequete.getInt( 1 );
                p.setId(idGenere);
                
                p = DaoPompier.getPompierById(connection, p.getId());
            }
            
         
        }   
        catch (SQLException e) 
        {
            e.printStackTrace();
            //out.println("Erreur lors de l’établissement de la connexion");
        }
        return p ;    
    }
    
}
