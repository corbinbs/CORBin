import org.omg.CORBA.*;
import org.omg.CosNaming.*;
import org.omg.CosNaming.NamingContextPackage.*;


public class passlong_server {

   public static void main(String args[]) {

	try {
	      //create and init ORB
	      ORB orb = ORB.init(args,null);

	      //Create servant and register it with the ORB
	      passlong_servant ref = new passlong_servant();

	      orb.connect(ref);

	      org.omg.CORBA.Object objRef =
		orb.resolve_initial_references("NameService");
	
	      NamingContext ncRef = NamingContextHelper.narrow(objRef);

	      NameComponent nc = new NameComponent("passlong", "");
	      NameComponent path[] = {nc};
	      ncRef.rebind(path, ref); 


	      System.err.println(orb.object_to_string(ref));


	      //wait for invocations from clients
	      java.lang.Object sync = new java.lang.Object();
	      synchronized (sync) {
		sync.wait();
	      }

	 } catch (Exception e) {

		System.err.println("ERROR: " + e);
		e.printStackTrace(System.out);

	 }	
	      
   }
}


