// Import Syrup classes
import Syrup.*;

// All CORBA applications need these classes.
import org.omg.CORBA.*;

//for the name service...
import org.omg.CosNaming.*;

// The package containing special exceptions thrown by the name service.
import org.omg.CosNaming.NamingContextPackage.*;

// Needed for the applet.
import java.awt.*;
import java.awt.event.*;

import javax.swing.*;



public class SyrupApplet extends JApplet implements ActionListener
{
  private SyrupManager manager;
  private SyrupClient  client;
  private String        userid  = "default_user";

  private JMenuBar      menuBar;
  private JMenu         fileMenu;
  private JMenuItem     loginMenuItem;
  private JMenuItem     logoutMenuItem;
  private JMenu         helpMenu;
  private JMenuItem     aboutMenuItem;
  private JTextArea     messageArea; 
  private JTextField    userName; 
  private JButton       postMessageButton;
  private JApplet       applet_ref; 



  public void init()
  {
    try{

      // Create and initialize the ORB 
      // The applet 'this' is passed to make parameters from the <APPLET...> tag
      // available to initialize the ORB
      ORB orb = ORB.init(this, null);
      
      // Get the root naming context
      org.omg.CORBA.Object objRef = orb.resolve_initial_references("NameService");
      NamingContext ncRef = NamingContextHelper.narrow(objRef);

      // Resolve the object reference in naming
      NameComponent nc = new NameComponent("SyrupManager", "CORBin_ML");
      NameComponent path[] = {nc};

      manager = SyrupManagerHelper.narrow(ncRef.resolve(path));


      userid = "Corbinator";
      manager.Login(userid);
      
      //build container to put in JApplet's ContentPane
      setContentPane(makeContentPane());

      applet_ref = this;
    
    } catch(Exception e) {
        System.out.println("SyrupApplet exception: " + e);
        e.printStackTrace(System.out);
      }  
  }
 
  public void destroy() {

	//Applet being destroyed ... logout from SYRUP Manager
	manager.Logout(userid);

  }

  public Container makeContentPane() {

     //create user interface components

     menuBar = new JMenuBar();
     fileMenu = new JMenu ("Actions");
     loginMenuItem = new JMenuItem ("Login");
     logoutMenuItem = new JMenuItem ("Logout");
     helpMenu = new JMenu("Help");
     aboutMenuItem = new JMenuItem ("About");
     messageArea = new JTextArea ("", 5, 40); 
     userName = new JTextField (30); 
     postMessageButton = new JButton ("Post Message");
     postMessageButton.setToolTipText("Click this button to post your message!");
     postMessageButton.addActionListener(this); 

     loginMenuItem.addActionListener (new java.awt.event.ActionListener () {
		public void actionPerformed (java.awt.event.ActionEvent e) {
			//connect to SyrupManager
			manager.Login(userid);
		}
	}
     );

     logoutMenuItem.addActionListener (new java.awt.event.ActionListener () {
		public void actionPerformed (java.awt.event.ActionEvent e) {
			//disconnect from SyrupManager
			manager.Logout(userid);
		}
	}
     );

     aboutMenuItem.addActionListener (new java.awt.event.ActionListener () {
		public void actionPerformed (java.awt.event.ActionEvent e) {

			JOptionPane.showMessageDialog(applet_ref, 
				"Programmer: Brian S. Corbin",
				"About S.Y.R.U.P. ",
				JOptionPane.PLAIN_MESSAGE); 

		}
	}
    );

     JPanel pane = new JPanel();

     fileMenu.add(loginMenuItem);
     fileMenu.add(logoutMenuItem);

     menuBar.add(fileMenu);

     helpMenu.add(aboutMenuItem);
 
     menuBar.add(helpMenu);

     pane.add(userName);
     pane.add(messageArea);
 
     pane.add(postMessageButton);

     pane.setBackground(new Color(255, 255, 204));
     pane.setBorder(BorderFactory.createMatteBorder(1,1,2,2,Color.black));

     setJMenuBar (menuBar);

     return pane;

  }

  public void actionPerformed(ActionEvent e) {

     String arg = e.getActionCommand();

     if ("Post Message".equals(arg)) {
		//post message to SYRUP Manager

		manager.PostMessage(userid, messageArea.getText());

     } 


  }


}

