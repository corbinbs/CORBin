
#include <stdio.h>
#include <orb/orbit.h>
#include "account.h" 
#include "CosNaming.h"               /*To use the name Server*/
#include "name.h"
 
int main (int argc, char *argv[]) {

  Account acc_client;         /* The client-side Account object */
  CORBA_long val;             /* client stores the balance here */
  PortableServer_POA poa;
  CORBA_ORB orb=NULL;         /* This is our ORB */

  CosNaming_NamingContext name_srv;       /*The Name Server*/
  CosNaming_Name * acct_name;             /*holds the name of our server*/

  CORBA_Environment ev;       /* CORBA exception information */

  CORBA_exception_init(&ev);

  /* Initialize the orb. The initialization routine checks the command
   * line parameters for directives that affect the orb */
  orb = CORBA_ORB_init(&argc, argv, "orbit-local-orb", &ev);
  g_message("After ORB Initialization...");

  name_srv =
      CORBA_ORB_resolve_initial_references(orb, "NameService", &ev);
  g_assert(ev._major != CORBA_SYSTEM_EXCEPTION);

  acct_name = create_name("CorbinAccountServer");

  acc_client = CosNaming_NamingContext_resolve(name_srv, acct_name, &ev); 
  g_assert(ev._major != CORBA_SYSTEM_EXCEPTION);
 
/***  val = Account__get_balance(acc_client, &ev);
  printf ("Initial balance is %d.\n",val);   ****/


  printf("How much do you wish to deposit: ");
  scanf("%d",&val); 
  Account_deposit(acc_client, (CORBA_unsigned_long) val, &ev);

  Account_withdraw(acc_client, (CORBA_unsigned_long) 1, &ev);

  /* We're done now. Do some cleanup */
  CORBA_Object_release(acc_client, &ev);
  exit (0);
}


