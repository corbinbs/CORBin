#include "account-skelimpl.c"
#include <stdio.h>
#include "CosNaming.h"               /*Added for Name Service Capability*/
#include "name.h"                    /* "                             " */
#include <orb/orbit.h>

int main (int argc, char *argv[]) {
  CORBA_ORB                 orb=NULL;
  CORBA_Environment         ev;
  PortableServer_ObjectId*  oid;
  Account                   account;
  PortableServer_POA        root_poa;
  PortableServer_POAManager pm;

  CosNaming_NamingContext name_srv;  /*Added for name server reference*/
  CosNaming_Name *acct_name;          /*name of our server*/

  CORBA_exception_init(&ev);
  
  /* Initialize the orb. The initialization routine checks the command
   * line parameters for directives that affect the orb */

  orb = CORBA_ORB_init(&argc, argv, "orbit-local-orb", &ev);

  root_poa = (PortableServer_POA)
    CORBA_ORB_resolve_initial_references(orb, "RootPOA", &ev);
  PortableServer_POAManager_activate(
         PortableServer_POA__get_the_POAManager(root_poa, &ev), &ev);


  /* ask for instanciation of one object account */
  account = impl_Account__create(root_poa, &ev);

 /* Here we get the name server from the ORB and publish the server */
  name_srv =
    CORBA_ORB_resolve_initial_references(orb, "NameService", &ev);
  g_assert(ev._major != CORBA_SYSTEM_EXCEPTION);

  acct_name = create_name("CorbinAccountServer");
  
  CosNaming_NamingContext_bind(name_srv,acct_name, account, &ev);
  
  printf("Ready to service requests...\n");

  g_message("Before ORB_run...");

  CORBA_ORB_run(orb, &ev);

 /* We're done running, clean up */
  CORBA_Object_release(account, &ev);
  CORBA_ORB_shutdown(orb, CORBA_FALSE, &ev);

  g_message("Account Server is OUT!");

  return (0);
}


