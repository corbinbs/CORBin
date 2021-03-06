//
// Example code for implementing IDL interfaces in file account.idl
//

#include <iostream.h>
#include <account.hh>

//
// Example class implementing IDL interface Account
//
class Account_i: public POA_Account,
                public PortableServer::RefCountServantBase {
private:
  // Make sure all instances are built on the heap by making the
  // destructor non-public
  //virtual ~Account_i();
public:
  // standard constructor
  Account_i();
  virtual ~Account_i();

  // methods corresponding to defined IDL attributes and operations
  void deposit(CORBA::ULong amount);
  void withdraw(CORBA::ULong amount);
  CORBA::Long balance();

private:

  CORBA::Long bal;
  
};

//
// Example implementational code for IDL interface Account
//
Account_i::Account_i(){

	bal = 0;

}
Account_i::~Account_i(){
  // add extra destructor code here
}
//   Methods corresponding to IDL attributes and operations
void Account_i::deposit(CORBA::ULong amount){

	bal += amount;

}

void Account_i::withdraw(CORBA::ULong amount){

	bal -=amount;

}

CORBA::Long Account_i::balance(){

	return bal;

}

// End of example implementational code

int main(int argc, char** argv)
{
  try {
    // Initialise the ORB.
    CORBA::ORB_var orb = CORBA::ORB_init(argc, argv, "omniORB3");

    // Obtain a reference to the root POA.
    CORBA::Object_var obj = orb->resolve_initial_references("RootPOA");
    PortableServer::POA_var poa = PortableServer::POA::_narrow(obj);

    // We allocate the objects on the heap.  Since these are reference
    // counted objects, they will be deleted by the POA when they are no
    // longer needed.
    Account_i* myAccount_i = new Account_i();
    
    // Activate the objects.  This tells the POA that the objects are
    // ready to accept requests.
    PortableServer::ObjectId_var myAccount_iid = poa->activate_object(myAccount_i);
    
    // Obtain a reference to each object and output the stringified
    // IOR to stdout
    {
      // IDL interface: Account
      CORBA::Object_var ref = myAccount_i->_this();
      CORBA::String_var sior(orb->object_to_string(ref));
      cout << "IDL object Account IOR = '" << (char*)sior << "'" << endl;
    }
    
    // Obtain a POAManager, and tell the POA to start accepting
    // requests on its objects.
    PortableServer::POAManager_var pman = poa->the_POAManager();
    pman->activate();

    orb->run();
    orb->destroy();
  }
  catch(CORBA::SystemException&) {
    cerr << "Caught CORBA::SystemException." << endl;
  }
  catch(CORBA::Exception&) {
    cerr << "Caught CORBA::Exception." << endl;
  }
  catch(omniORB::fatalException& fe) {
    cerr << "Caught omniORB::fatalException:" << endl;
    cerr << "  file: " << fe.file() << endl;
    cerr << "  line: " << fe.line() << endl;
    cerr << "  mesg: " << fe.errmsg() << endl;
  }
  catch(...) {
    cerr << "Caught unknown exception." << endl;
  }

  return 0;
}

