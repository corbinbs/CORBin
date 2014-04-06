
#include <stdio.h>
#include <orb/orbit.h>
#include "account.h" 
 
int main (int argc, char *argv[]) {

  Account acc_client;         /* The client-side Account object */
  CORBA_long val;             /* client stores the balance here */
  PortableServer_POA poa;
  CORBA_ORB orb=NULL;         /* This is our ORB */
  char *ior;                  /* an IOR is one way a client can locate a server */
  CORBA_Environment ev;       /* CORBA exception information */

  CORBA_exception_init(&ev);

  /* Initialize the orb. The initialization routine checks the command
   * line parameters for directives that affect the orb */
  orb = CORBA_ORB_init(&argc, argv, "orbit-local-orb", &ev);
 
  /* Bind  our client Account to the account on the server using the
   * IOR to look it up (the ior was passed as an argument) */

  acc_client = CORBA_ORB_string_to_object(orb, argv[1], &ev);
  if (!acc_client) {
    printf("Cannot bind to %s\n (pass the IOR as arg 1)\n", argv[1]);
    exit(1);
  }
  val = Account__get_balance(acc_client, &ev);
  printf ("Initial balance is %d.\n",val);

  printf("Make a deposit, how :");
  scanf("%d",&val); 
  Account_deposit(acc_client, (CORBA_unsigned_long) val, &ev);
  val = Account__get_balance(acc_client, &ev);
  printf ("Balance is %d.\n",val);

  Account_withdraw(acc_client, (CORBA_unsigned_long) 5, &ev);
  val = Account__get_balance(acc_client, &ev);
  printf ("Balance is %d.\n",val);

  /* We're done now. Do some cleanup */
  CORBA_Object_release(acc_client, &ev);
  exit (0);
}


