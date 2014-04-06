#include "passlong.h"

#include <stdio.h>

/*** App-specific servant structures ***/
typedef struct
{
   POA_passlong servant;
   PortableServer_POA poa;

}
impl_POA_passlong;

/*** Implementation stub prototypes ***/
static void impl_passlong__destroy(impl_POA_passlong * servant,
				   CORBA_Environment * ev);
static CORBA_long
impl_passlong_foo(impl_POA_passlong * servant,
		  CORBA_long x, CORBA_Environment * ev);

/*** epv structures ***/
static PortableServer_ServantBase__epv impl_passlong_base_epv = {
   NULL,			/* _private data */
   NULL,			/* finalize routine */
   NULL,			/* default_POA routine */
};
static POA_passlong__epv impl_passlong_epv = {
   NULL,			/* _private */
   (gpointer) & impl_passlong_foo,

};

/*** vepv structures ***/
static POA_passlong__vepv impl_passlong_vepv = {
   &impl_passlong_base_epv,
   &impl_passlong_epv,
};

/*** Stub implementations ***/
static passlong
impl_passlong__create(PortableServer_POA poa, CORBA_Environment * ev)
{
   passlong retval;
   impl_POA_passlong *newservant;
   PortableServer_ObjectId *objid;

   newservant = g_new0(impl_POA_passlong, 1);
   newservant->servant.vepv = &impl_passlong_vepv;
   newservant->poa = poa;
   POA_passlong__init((PortableServer_Servant) newservant, ev);
   objid = PortableServer_POA_activate_object(poa, newservant, ev);
   CORBA_free(objid);
   retval = PortableServer_POA_servant_to_reference(poa, newservant, ev);

   return retval;
}

static void
impl_passlong__destroy(impl_POA_passlong * servant, CORBA_Environment * ev)
{
   PortableServer_ObjectId *objid;

   objid = PortableServer_POA_servant_to_id(servant->poa, servant, ev);
   PortableServer_POA_deactivate_object(servant->poa, objid, ev);
   CORBA_free(objid);

   POA_passlong__fini((PortableServer_Servant) servant, ev);
   g_free(servant);
}

static CORBA_long
impl_passlong_foo(impl_POA_passlong * servant,
		  CORBA_long x, CORBA_Environment * ev)
{
	fprintf(stderr, "In passlong's foo operation with: %d\n", x);
     
        return x;
}
