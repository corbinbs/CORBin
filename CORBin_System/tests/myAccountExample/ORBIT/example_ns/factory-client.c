/*
 * This is an example client that attaches to an account factory
 * and uses it to create accounts and manipulate the
 */

#include <stdio.h>
#include <orb/orbit.h>
#include "factory.h"
#include "CosNaming.h" /* To use the Naming Service */
#include "name.h"  /* to get create_name helper function */


int main (int argc, char *argv[]) {

  factory fac;		      /* The server-side factory object */
  Account acc1, acc2;	      /* Our victim Accounts */
  long val;

  CORBA_ORB orb=NULL;         /* This is our ORB */

  CORBA_Environment ev;       /* CORBA exception information */

  CosNaming_NamingContext name_srv; /* The name server */
  CosNaming_Name* fac_name;    /* This holds the name of our server */

  CORBA_exception_init(&ev);

  /* Initialize the orb. The initialization routine checks the command
   * line parameters for directives that affect the orb */
  orb = CORBA_ORB_init(&argc, argv, "orbit-local-orb", &ev);

  /* Here we get the name server from the ORB and publish the server */
  name_srv =
    CORBA_ORB_resolve_initial_references(orb, "NameService", &ev);
  g_assert(ev._major != CORBA_SYSTEM_EXCEPTION);

  fac_name = create_name("MyServer");

  fac = CosNaming_NamingContext_resolve(name_srv,fac_name, &ev);
  g_assert(ev._major != CORBA_SYSTEM_EXCEPTION);

  /* Use the factory to create a couple of accounts */
  acc1 = factory_newAccount(fac,0,&ev);
  acc2 = factory_newAccount(fac,40,&ev);

  /* Do stuff with the accounts */
  Account_deposit(acc1, (CORBA_unsigned_long) 12, &ev);
  Account_deposit(acc2, (CORBA_unsigned_long) 12, &ev);

  val = Account__get_balance(acc1, &ev);
  printf ("Balance of account 1 is %d.\n",val);
  val = Account__get_balance(acc2, &ev);
  printf ("Balance of account 2 is %d.\n",val);

  Account_withdraw(acc1, (CORBA_unsigned_long) 5, &ev);
  Account_withdraw(acc2, (CORBA_unsigned_long) 5, &ev);

  val = Account__get_balance(acc1, &ev);
  printf ("Balance of account 1 is %d.\n",val);
  val = Account__get_balance(acc2, &ev);
  printf ("Balance of account 2 is %d.\n",val);
 

  /* We're done running, clean up */
  CORBA_Object_release(fac, &ev);
  CORBA_Object_release(acc1, &ev);
  CORBA_Object_release(acc2, &ev);

  CORBA_ORB_shutdown(orb, CORBA_FALSE, &ev);


}


