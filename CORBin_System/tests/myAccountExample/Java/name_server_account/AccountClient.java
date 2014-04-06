
import org.omg.CosNaming.*;
import org.omg.CosNaming.NamingContextPackage.*;
import org.omg.CORBA.*;

public class AccountClient {

   public static void main(String args[]) {

	try {
	      //create and init ORB
	      ORB orb = ORB.init(args,null);

	      //get the root naming context
	      org.omg.CORBA.Object objRef =
		orb.resolve_initial_references("NameService");
	      NamingContext ncRef = NamingContextHelper.narrow(objRef);
	 
	      //resolve the object reference in Naming Service
	      NameComponent nc = 
			new NameComponent("CorbinAccountServer", "CORBin_ML");
	      NameComponent path[] = {nc};
	      Account acc_server = 
			AccountHelper.narrow(ncRef.resolve(path));

	      acc_server.deposit(100);
	      acc_server.withdraw(11);

	 } catch (Exception e) {

		System.err.println("ERROR: " + e);
		e.printStackTrace(System.out);

	 }	
	      
   }

}


