
#include <stdio.h>
#include <orb/orbit.h>
#include "passlong.h" 
 
int main (int argc, char *argv[]) {

  passlong  client;      
  CORBA_long val;          
  CORBA_ORB orb=NULL;         /* This is our ORB */
  char *ior;                  /* an IOR is one way a client can locate a server */
  CORBA_Environment ev;       /* CORBA exception information */

  CORBA_exception_init(&ev);

  /* Initialize the orb. The initialization routine checks the command
   * line parameters for directives that affect the orb */
  orb = CORBA_ORB_init(&argc, argv, "orbit-local-orb", &ev);
 
  /* Bind  our client Account to the account on the server using the
   * IOR to look it up (the ior was passed as an argument) */

  client = CORBA_ORB_string_to_object(orb, argv[1], &ev);
  if (!client) {
    printf("Cannot bind to %s\n (pass the IOR as arg 1)\n", argv[1]);
    exit(1);
  }
  val = passlong_foo(client, 187 , &ev);
  printf ("%d was returned from foo.\n",val);

  /* We're done now. Do some cleanup */
  CORBA_Object_release(client, &ev);
  exit (0);
}


