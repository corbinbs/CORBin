/*-----------------------------------------------------------------------
 *
 * File Name: factory-server.c
 *
 * Author: Ronald Garcia -- created Wed June 23 1999
 *
 * Revision: $Id$
 *
 *-----------------------------------------------------------------------
 *
 * DESCRIPTION 
 *    This is another example of the factory server, this time 
 *  publishing itself with a nameserver, instead of spitting out ior
 *
 *-----------------------------------------------------------------------
 *
 * REVISION HISTORY
 *
 * $Log$
 *
 *----------------------------------------------------------------------- */

#include <stdio.h>
#include <orb/orbit.h>
#include "factory.h"
#include "factory-server.h" /* Header file to get impl_factory_create */
#include "CosNaming.h" /* To use the Naming Service */
#include "name.h"  /* to get create_name helper function */


int main (int argc, char *argv[]) {

  factory fac;		      /* The server-side factory object */

  PortableServer_POA poa;     /* the root POA */
  CORBA_ORB orb=NULL;         /* This is our ORB */
  CORBA_Environment ev;       /* CORBA exception information */

  CosNaming_NamingContext name_srv; /* The name server */
  CosNaming_Name* fac_name;    /* This holds the name of our server */

  CORBA_exception_init(&ev);

  /* Initialize the orb. The initialization routine checks the command
   * line parameters for directives that affect the orb */
  orb = CORBA_ORB_init(&argc, argv, "orbit-local-orb", &ev);

  poa = (PortableServer_POA)
    CORBA_ORB_resolve_initial_references(orb, "RootPOA", &ev);

  PortableServer_POAManager_activate(
         PortableServer_POA__get_the_POAManager(poa, &ev), &ev);


  /* This call creates a factory object that will act as a server. */

  fac = impl_factory__create(poa,&ev);

  /* Here we get the name server from the ORB and publish the server */
  name_srv =
    CORBA_ORB_resolve_initial_references(orb, "NameService", &ev);
  g_assert(ev._major != CORBA_SYSTEM_EXCEPTION);

  fac_name = create_name("MyServer");
  
  CosNaming_NamingContext_bind(name_srv,fac_name, fac, &ev);
  
  printf("Ready to service requests...\n");
  /* Run the ORB event loop */
  CORBA_ORB_run(orb, &ev);

  /* We're done running, clean up */
  CORBA_Object_release(fac, &ev);
  CORBA_ORB_shutdown(orb, CORBA_FALSE, &ev);

}





