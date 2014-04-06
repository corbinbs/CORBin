#include <stdio.h>
#include "account.h"

/*** App-specific servant structures ***/
typedef struct
{
   POA_Account servant;
   PortableServer_POA poa;

   CORBA_long attr_balance;

}
impl_POA_Account;

/*** Implementation stub prototypes ***/
static void impl_Account__destroy(impl_POA_Account * servant,
				  CORBA_Environment * ev);
static void
impl_Account_deposit(impl_POA_Account * servant,
		     CORBA_unsigned_long amount, CORBA_Environment * ev);

static void
impl_Account_withdraw(impl_POA_Account * servant,
		      CORBA_unsigned_long amount, CORBA_Environment * ev);

static CORBA_long
impl_Account__get_balance(impl_POA_Account * servant, CORBA_Environment * ev);

/*** epv structures ***/
static PortableServer_ServantBase__epv impl_Account_base_epv = {
   NULL,			/* _private data */
   NULL,			/* finalize routine */
   NULL,			/* default_POA routine */
};
static POA_Account__epv impl_Account_epv = {
   NULL,			/* _private */
   (gpointer) & impl_Account_deposit,

   (gpointer) & impl_Account_withdraw,

   (gpointer) & impl_Account__get_balance,

};

/*** vepv structures ***/
static POA_Account__vepv impl_Account_vepv = {
   &impl_Account_base_epv,
   &impl_Account_epv,
};

/*** Stub implementations ***/
static Account
impl_Account__create(PortableServer_POA poa, CORBA_Environment * ev)
{
   Account retval;
   impl_POA_Account *newservant;
   PortableServer_ObjectId *objid;

/*   fprintf(stderr, "server calls Account__create...\n");  */

   newservant = g_new0(impl_POA_Account, 1);
   newservant->servant.vepv = &impl_Account_vepv;
   newservant->poa = poa;
   POA_Account__init((PortableServer_Servant) newservant, ev);
   objid = PortableServer_POA_activate_object(poa, newservant, ev);
   CORBA_free(objid);
   retval = PortableServer_POA_servant_to_reference(poa, newservant, ev);

   return retval;
}

static void
impl_Account__destroy(impl_POA_Account * servant, CORBA_Environment * ev)
{
   PortableServer_ObjectId *objid;

   objid = PortableServer_POA_servant_to_id(servant->poa, servant, ev);
   PortableServer_POA_deactivate_object(servant->poa, objid, ev);
   CORBA_free(objid);

   POA_Account__fini((PortableServer_Servant) servant, ev);
   g_free(servant);
}

static void
impl_Account_deposit(impl_POA_Account * servant,
		     CORBA_unsigned_long amount, CORBA_Environment * ev)
{
    printf("server calls deposit method...\n");
    fflush(stdout);
    servant->attr_balance += amount;
}

static void
impl_Account_withdraw(impl_POA_Account * servant,
		      CORBA_unsigned_long amount, CORBA_Environment * ev)
{
    printf("server calls withdraw method...\n");
    fflush(stdout);
    servant->attr_balance -= amount;
}

static CORBA_long
impl_Account__get_balance(impl_POA_Account * servant, CORBA_Environment * ev)
{
   CORBA_long retval;

    printf("server calls get_balance method...\n");
    fflush(stdout);
    retval= servant->attr_balance;

   return retval;
}
