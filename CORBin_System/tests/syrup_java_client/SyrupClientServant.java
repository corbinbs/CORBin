import Syrup.*;
import org.omg.CosNaming.*;
import org.omg.CosNaming.NamingContextPackage.*;
import org.omg.CORBA.*;

import javax.swing.*;

public class SyrupClientServant extends _SyrupClientImplBase {

    private JTextArea messages;    
    private JComboBox online_users;
    private JApplet   window;

    public SyrupClientServant(JApplet x, JTextArea messagesArea, JComboBox users) {
	messages = messagesArea;
	online_users = users;
	window = x;
    }

    public void Message(String userid, String msg) {

	//Append this message to the user's "Messages from other Syrup
	//users"  TextArea

	messages.append("\n" + userid + " says: \n" +
			 msg + "\n"); 

    }

    public void AddUserToList(String id) {

	  online_users.addItem(id);
	  JOptionPane.showMessageDialog(window, 
		id + " just logged in!",
		id + " is now online",
		JOptionPane.PLAIN_MESSAGE); 

    }

    public void RemoveUserFromList(String id) {

	  online_users.removeItem(id);
	  JOptionPane.showMessageDialog(window, 
		id + " just logged out!",
		id + "is no longer online",
		JOptionPane.PLAIN_MESSAGE); 

    }

}
