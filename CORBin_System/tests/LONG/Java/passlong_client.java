import org.omg.CORBA.*;

public class passlong_client {

   public static void main(String args[]) {

	try {
	      //create and init ORB
	      ORB orb = ORB.init(args,null);

	      System.out.println(args[0]);
	      org.omg.CORBA.Object p = orb.string_to_object(args[0]);

	      passlong pl = passlongHelper.narrow(p);

	      System.out.println("Returned: " + pl.foo(198));

	 } catch (Exception e) {

		System.err.println("ERROR: " + e);
		e.printStackTrace(System.out);

	 }	
	      
   }
}


