/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


/**
 *
 * @author Zakina
 */
public class ConnexionBdd {
    
    public static Connection connection=null;
    public static Statement st=null;
    public static ResultSet rs=null;
       
    public static Connection ouvrirConnexion(){
        try {
                Class.forName("org.mariadb.jdbc.Driver");
                System.out.println("Pilote MARIADB JDBC chargé");
                                
        } catch (ClassNotFoundException e) {
                e.printStackTrace();         
        }     
        try {
            //obtention de la connexion
            connection= DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/sdis","root","");
            // te
            System.out.println("Connexion OK");
           
        } catch (SQLException e) {
            e.printStackTrace();
        }            
        return connection ;
     
    }
   
    public static boolean verifierAuthentification(String email, String motDePasse) {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    boolean authentifie = false;

    try {
        conn = ouvrirConnexion();
        // Utilisation de PreparedStatement pour éviter les injections SQL
        String sql = "SELECT COUNT(*) FROM compte WHERE email = ? AND password = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        stmt.setString(2, motDePasse);
        rs = stmt.executeQuery();

        if (rs.next()) {
            int count = rs.getInt(1);
            authentifie = count == 1;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        fermerConnexion(rs);
        fermerConnexion(stmt);
        fermerConnexion(conn);
    }
    return authentifie;
}
    
    public static String recupererNomPrenomPompier(String email) {
    Connection cnx = null;
    Statement stmt = null;
    ResultSet rs = null;
    String nomPrenomPompier = "";

    try {
        cnx = ouvrirConnexion();
        stmt = cnx.createStatement();
        String sql = "SELECT p.nom, p.prenom " +
                     "FROM compte c " +
                     "JOIN pompier p ON c.id = p.compte_id " +
                     "WHERE c.email = '" + email + "'";
        rs = stmt.executeQuery(sql);

        if (rs.next()) {
            String nom = rs.getString("nom");
            String prenom = rs.getString("prenom");
            nomPrenomPompier = nom + " " + prenom;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        fermerConnexion(rs);
        fermerConnexion(stmt);
        fermerConnexion(cnx);
    }
    return nomPrenomPompier;
}
    
    public static String recupererGradePompier(String email) {
    Connection cnx = null;
    Statement stmt = null;
    ResultSet rs = null;
    String gradePompier = "";

    try {
        cnx = ouvrirConnexion();
        stmt = cnx.createStatement();
        String sql = "SELECT g.libelle FROM grade g INNER JOIN pompier p ON g.id = p.grade_id INNER JOIN compte c ON p.compte_id = c.id WHERE c.email = '" + email + "'";
        rs = stmt.executeQuery(sql);

        if (rs.next()) {
            gradePompier = rs.getString("libelle");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        fermerConnexion(rs);
        fermerConnexion(stmt);
        fermerConnexion(cnx);
    }
    return gradePompier;
}
    
    // Méthode de fermeture du resultset
    public static void fermerConnexion(ResultSet rs)
    {
        if(rs!=null)
        {
            try
            {
                rs.close();
            }
            catch(Exception e)
            {
        	System.out.println("Erreur lors de la fermeture d’une connexion dans fermerConnexion(ResultSet)");
            }
        }
    }

    // Méthode de fermeture du statement
    public static void fermerConnexion(Statement stmt)
    {
        if(stmt!=null)
        {
            try
            {
                stmt.close();
            }
            catch(Exception e)
            {
                System.out.println("Erreur lors de la fermeture d’une connexion dans fermerConnexion(Statement)");
            }
        }
    }

    /// Méthode de fermeture de la connexion
    public static void fermerConnexion(Connection con)
    {
        if(con!=null)
        {
            try
            {
                con.close();
                System.out.println("Fermeture Connexion OK");
            }
            catch(Exception e)
            {
                System.out.println("Erreur lors de la fermeture d’une connexion dans fermerConnexion(Connection)");
            }
        }
    }  
}
