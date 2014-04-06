#include "account-skelimpl.c"
#include <stdio.h>
#include <orb/orbit.h>

int main (int argc, char *argv[]) {
  CORBA_ORB                 orb;
  CORBA_Environment*        ev;
  PortableServer_ObjectId*  oid;
  Account                   account;
  PortableServer_POA        root_poa;
  PortableServer_POAManager pm;
  CORBA_char*               ior;

  ev = g_new0(CORBA_Environment,1);
  CORBA_exception_init(ev);
  
  /* Initialize the orb. The initialization routine checks the command
   * line parameters for directives that affect the orb */

  orb = CORBA_ORB_init(&argc, argv, "orbit-local-orb", ev);

  root_poa = (PortableServer_POA)
    CORBA_ORB_resolve_initial_references(orb, "RootPOA", ev);

  /* ask for instanciation of one object account */
  account = impl_Account__create(root_poa, ev);

  /* Here we get the IOR for the acc object.  Our "client" will use
   * the IOR to  find the server to connect to */
  ior = CORBA_ORB_object_to_string(orb, account, ev);

  /* print out the IOR, just so you can see what it looks like */
  printf ("%s\n", ior);
  fflush(stdout);

  pm = PortableServer_POA__get_the_POAManager(root_poa, ev);
  PortableServer_POAManager_activate(pm,ev);

  CORBA_ORB_run(orb, ev);
  return (0);
}


