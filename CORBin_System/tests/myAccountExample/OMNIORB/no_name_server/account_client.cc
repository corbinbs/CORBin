
// Account Client in C++
// Using omniORB3
// CORBin


#include <iostream>
#include <account.hh>



int main(int argc, char ** argv) {


    try {

	CORBA::ORB_var orb = CORBA::ORB_init(argc, argv, "omniORB3");
	
	if ( argc != 2 ) {

		cerr << "Usage: " << argv[0] << " <object reference> " << endl; 
		return 1;
	}

	CORBA::Object_var obj = orb->string_to_object(argv[1]);
	Account_var account_ref = Account::_narrow(obj);

	if ( CORBA::is_nil(account_ref) ) {

		cerr << "Can't narrow reference to type Account!" << endl;

	}	

	//Talk to the Account Object

	account_ref->withdraw(10);
	account_ref->deposit(20);
	

	//Clean up
	
	orb->destroy();


    }
    catch (CORBA::COMM_FAILURE & ex) {

	cerr << "Caught CORBA::COMM_FAILURE -- unable to contact the object!"
	     << endl;

    }
    catch (CORBA::SystemException& ex) {

	cerr << "Caught a CORBA::SystemException." << endl;

    }
    catch (CORBA::Exception &ex ) {

	cerr << "Caught CORBA::Exception!" << endl;

    }
    catch (omniORB::fatalException &ex) {

	cerr << "Caught omniORB::fatalException!" << endl;
	cerr << "  file:  " << ex.file() << endl;
	cerr << "  line:  " << ex.line() << endl;
	cerr << "  mesg:  " << ex.errmsg() << endl;

    }
    catch (...) {

	cerr << "Caught unknown exception!" << endl;

    }

    return 0;

}

