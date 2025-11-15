package controle.connection;

import java.sql.Connection;
import java.sql.Statement;
import entite.ParametresIP;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

public abstract class ControleConnexionIP {

    static ParametresIP lesParametresIP;
    static boolean etatConnexion;
    static Connection laConnectionStatique;

    static {
        boolean ok = true;
        try {
            lesParametresIP = new ParametresIP();
        } catch (IOException ex) {
            Logger.getLogger(ControleConnexionIP.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            Class.forName(lesParametresIP.getDriverSGBD());
            etatConnexion = true;
        } catch (ClassNotFoundException e) {
            JOptionPane.showMessageDialog(null,
                    "Classe non trouvée"
                    + " pour le chargement "
                    + "du pilote JDBC MySQL",
                    "ALERTE", JOptionPane.ERROR_MESSAGE);
            ok = false;
            etatConnexion = false;
        }
        if (ok == true) {
            try {
                String urlBD = lesParametresIP.getServeurBD();
                String nomUtilisateur = lesParametresIP.getNomUtilisateur();
                String MDP = lesParametresIP.getMotDePasse();
                laConnectionStatique = (Connection) DriverManager.getConnection(urlBD, nomUtilisateur,
                        MDP);
                etatConnexion = true;
            } catch (Exception e) {
                JOptionPane.showMessageDialog(null,
                        "Impossible de se connecter"
                        + " à la base de données",
                        "ALERTE", JOptionPane.ERROR_MESSAGE);
                etatConnexion = false;
            }
        }
    }

    public ControleConnexionIP() {
    }

    public static boolean isEtatConnexion() {
        return etatConnexion;
    }
    public static Connection getLaConnectionStatique() {
        return laConnectionStatique;
    }
    public static ParametresIP getLesParametresIP() {
        return lesParametresIP;
    }

    public static boolean controle(String Nom,
            String MotDePasse) {
        boolean verificationSaisie;
        if (Nom.equals(lesParametresIP.getNomUtilisateur())
                && MotDePasse.equals(lesParametresIP.getMotDePasse())) {
            verificationSaisie = true;
        } else {
            JOptionPane.showMessageDialog(null,
                    "Vérifier votre saisie.",
                    "ERREUR", JOptionPane.ERROR_MESSAGE);
            verificationSaisie = false;
        }
        return verificationSaisie;
    }

    public static void fermetureSession() {
        try {
            laConnectionStatique.close();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null,
                    "Problème rencontré"
                    + "à la fermeture de la connexion",
                    "ERREUR", JOptionPane.ERROR_MESSAGE);
        }
    }

    // méthode provisoire juste pour test
    public static void transfertDonnees() throws SQLException {
        System.out.println("Parcours du jeu d'enregistrements");
        System.out.println("---------------------------------");
        Statement leStatement = null;
        ResultSet jeuEnreg = null;
        String vCode = "";
        String vNom = "";
        String vPrenom = "";
        String chaineSQL = "select * from clients";
        leStatement = 
             (Statement) laConnectionStatique.createStatement();
        jeuEnreg = leStatement.executeQuery(chaineSQL);
        while (jeuEnreg.next()) {
            vCode = jeuEnreg.getString(1);
            vNom = jeuEnreg.getString(2);
            vPrenom = jeuEnreg.getString("prenom");
            System.out.println(vCode + ", " + vNom
                    + ", " + vPrenom);
        }
    }
}
