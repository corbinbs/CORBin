
import org.omg.CosNaming.*;  // AccountClient will use the naming service.
import org.omg.CORBA.*;      // All CORBA applications need these classes.


public class AccountClient
{
  public static void main(String args[])
  {
    try{
      
      // Create and initialize the ORB
      ORB orb = ORB.init(args, null);
      
      // Get the root naming context
      org.omg.CORBA.Object objRef = orb.resolve_initial_references("NameService");
      NamingContext ncRef = NamingContextHelper.narrow(objRef);
      
      // Resolve the object reference in naming
      NameComponent nc = new NameComponent("CorbinAccountServer", "CORBin");
      NameComponent path[] = {nc};
      Account accountRef = AccountHelper.narrow(ncRef.resolve(path));
      
      accountRef.deposit(100);
      accountRef.withdraw(1);
          
    } catch(Exception e) {
        System.out.println("ERROR : " + e);
        e.printStackTrace(System.out);
      }  
  }
}


