package dialogue;

import controle.connection.ControleConnexion;
import controle.etat.JasperMySQL_Parametres;
import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.ResultSet;
import javax.swing.*;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.data.general.DefaultPieDataset;

public class FenStats extends JDialog {
    private JPanel panel;
    private DefaultPieDataset data = new DefaultPieDataset();
    private JButton print;
    private String annee;

    public FenStats(String annee) {
    	this.annee = annee;
    	initialize();
    }
    
    private void initialize() {
    	setBounds(100, 100, 747, 534);
    	getContentPane().setLayout(null);
    	getContentPane().add(getPanel());
    	getContentPane().add(getPrint());
    }
    private JPanel getPanel() {
		if (panel == null) {
		    panel = genereGraphicStats();
		    panel.setBounds(10, 58, 711, 428);
		    panel.setLayout(null);
		}
		return panel;
    }
    @SuppressWarnings("UseSpecificCatch")
    private JPanel genereGraphicStats(){
		JPanel panel;
		JFreeChart chart;
		ChartPanel chartPane = null;
		String [] month = {"Janvier","Février","Mars","Avril","Mai",
                    "Juin","Juillet","Août","Septembre","Octobre","Novembre","Décembre"};
		try{
		    ResultSet rs = ControleConnexion.getLaConnectionStatique()
                            .createStatement()
                            .executeQuery("SELECT MONTH(date) AS mois, COUNT(*) AS nbr " +
			    "FROM factures " +
			    "WHERE YEAR(date) = '"+ annee +"' " +
			    "GROUP BY MONTH(date)");
		    if(!rs.next()){
		    	JOptionPane.showMessageDialog(null, 
                                "Aucune donnée trouvée pour cette année");
		    }
		    rs.beforeFirst();
		    while(rs.next()){
			data.setValue(month[rs.getInt("mois")-1], rs.getInt("nbr"));
		    }
		    chart = ChartFactory.createPieChart("Factures " + annee, data, 
                            true, true, false);	   
		    chartPane = new ChartPanel(chart);
		    chartPane.setBorder(new javax.swing.border
                            .LineBorder(Color.BLACK, 1, true));
		    panel = chartPane;
		}catch(Exception e){
		    panel = new JPanel();
		    JOptionPane.showMessageDialog(null, "Une erreur s'est produite "
                            + "lors de la génération du graphique.", "Erreur", 
                            JOptionPane.ERROR_MESSAGE);
		}
		return panel;
    }
    private JButton getPrint() {
		if (print == null) {
		    print = new JButton("Imprimer le graphique");
		    print.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
			    JasperMySQL_Parametres.imprimer("Stats.jrxml");
			}
		    });
		    print.setIcon(new ImageIcon(FenStats.class
                            .getResource("/images/gestion/imprimer2.png")));
		    print.setBounds(10, 10, 240, 42);
		}
		return print;
    }
}