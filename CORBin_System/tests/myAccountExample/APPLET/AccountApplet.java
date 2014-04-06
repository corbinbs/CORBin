
// The package containing our stubs.
//import AccountApp.*;

// AccountApplet will use the naming service.
import org.omg.CosNaming.*;

// The package containing special exceptions thrown by the name service.
import org.omg.CosNaming.NamingContextPackage.*;

// All CORBA applications need these classes.
import org.omg.CORBA.*;

// Needed for the applet.
import java.awt.Graphics;


public class AccountApplet extends java.applet.Applet
{
  public void init()
  {
    try{

      // Create and initialize the ORB
      ORB orb = ORB.init(this, null);
      
      // Get the root naming context
      org.omg.CORBA.Object objRef = orb.resolve_initial_references("NameService");
      NamingContext ncRef = NamingContextHelper.narrow(objRef);

      // Resolve the object reference in naming
      NameComponent nc = new NameComponent("CorbinAccountServer", "CORBin");
      NameComponent path[] = {nc};
      Account accountRef = AccountHelper.narrow(ncRef.resolve(path));
      
      // Call the Account server object and print the results
      accountRef.deposit(1001)

    
    } catch(Exception e) {
        System.out.println("AccountApplet exception: " + e);
        e.printStackTrace(System.out);
      }  
  }
  String message = "Hello Account!";

  public void paint(Graphics g)
  {
    g.drawString(message, 25, 50);
  }

}

