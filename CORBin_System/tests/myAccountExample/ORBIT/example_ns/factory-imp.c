#include "factory-server.h"

/*** App-specific servant structures ***/
typedef struct {
   POA_factory servant;
   PortableServer_POA poa;

} impl_POA_factory;

/*** Implementation stub prototypes ***/
static void impl_factory__destroy(impl_POA_factory * servant,
				  CORBA_Environment * ev);

Account
impl_factory_newAccount(impl_POA_factory * servant,
			CORBA_unsigned_long balance,
			CORBA_Environment * ev);

/*** epv structures ***/
static PortableServer_ServantBase__epv impl_factory_base_epv =
{
   NULL,			/* _private data */
   (gpointer) & impl_factory__destroy,	/* finalize routine */
   NULL,			/* default_POA routine */
};
static POA_factory__epv impl_factory_epv =
{
   NULL,			/* _private */
   (gpointer) & impl_factory_newAccount,

};

/*** vepv structures ***/
static POA_factory__vepv impl_factory_vepv =
{
   &impl_factory_base_epv,
   &impl_factory_epv,
};

/*** Stub implementations ***/
factory 
impl_factory__create(PortableServer_POA poa, CORBA_Environment * ev)
{
   factory retval;
   impl_POA_factory *newservant;
   PortableServer_ObjectId *objid;

   newservant = g_new0(impl_POA_factory, 1);
   newservant->servant.vepv = &impl_factory_vepv;
   newservant->poa = poa;
   POA_factory__init((PortableServer_Servant) newservant, ev);
   objid = PortableServer_POA_activate_object(poa, newservant, ev);
   CORBA_free(objid);
   retval = PortableServer_POA_servant_to_reference(poa, newservant, ev);

   return retval;
}

/* You shouldn't call this routine directly without first deactivating the servant... */
static void
impl_factory__destroy(impl_POA_factory * servant, CORBA_Environment * ev)
{

   POA_factory__fini((PortableServer_Servant) servant, ev);
   g_free(servant);
}

Account
impl_factory_newAccount(impl_POA_factory * servant,
			CORBA_unsigned_long balance,
			CORBA_Environment * ev)
{
   Account retval;
   retval = impl_Account__create(servant->poa, ev);
   Account_deposit(retval, balance, ev);
   return retval;
}
