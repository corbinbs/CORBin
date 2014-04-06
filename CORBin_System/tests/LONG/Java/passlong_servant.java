
import org.omg.CORBA.*;

public class passlong_servant extends _passlongImplBase {

   public passlong_servant() {

	System.out.println("Awaiting numbers...");

   }

   public int foo(int x) {

	System.out.println("I received a : " + x );

	return x;
	
   }

}
