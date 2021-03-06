/*
 * This file was generated by orbit-idl - DO NOT EDIT!
 */

#include <string.h>
#include "factory.h"

void
_ORBIT_skel_factory_newAccount(POA_factory * _ORBIT_servant,
			       GIOPRecvBuffer * _ORBIT_recv_buffer,
			       CORBA_Environment * ev,
			       Account(*_impl_newAccount)
			       (PortableServer_Servant _servant,
				const CORBA_unsigned_long balance,
				CORBA_Environment * ev))
{
   Account _ORBIT_retval;
   CORBA_unsigned_long balance;

   {				/* demarshalling */
      guchar *_ORBIT_curptr;

      _ORBIT_curptr = GIOP_RECV_BUFFER(_ORBIT_recv_buffer)->cur;
      if (giop_msg_conversion_needed(GIOP_MESSAGE_BUFFER(_ORBIT_recv_buffer))) {
	 _ORBIT_curptr = ALIGN_ADDRESS(_ORBIT_curptr, 4);
	 
	    (*((guint32 *) & (balance))) =
	    GUINT32_SWAP_LE_BE(*((guint32 *) _ORBIT_curptr));} else {
	 _ORBIT_curptr = ALIGN_ADDRESS(_ORBIT_curptr, 4);
	 balance = *((CORBA_unsigned_long *) _ORBIT_curptr);
      }
   }
   _ORBIT_retval = _impl_newAccount(_ORBIT_servant, balance, ev);
   {				/* marshalling */
      register GIOPSendBuffer *_ORBIT_send_buffer;

      _ORBIT_send_buffer =
	 giop_send_reply_buffer_use(GIOP_MESSAGE_BUFFER(_ORBIT_recv_buffer)->
				    connection, NULL,
				    _ORBIT_recv_buffer->message.u.request.
				    request_id, ev->_major);
      if (_ORBIT_send_buffer) {
	 if (ev->_major == CORBA_NO_EXCEPTION) {
	    ORBit_marshal_object(_ORBIT_send_buffer, _ORBIT_retval);
	 } else
	    ORBit_send_system_exception(_ORBIT_send_buffer, ev);
	 giop_send_buffer_write(_ORBIT_send_buffer);
	 giop_send_buffer_unuse(_ORBIT_send_buffer);
      }
      if (ev->_major == CORBA_NO_EXCEPTION)
	 CORBA_Object_release(_ORBIT_retval, ev);
   }
}
static ORBitSkeleton
get_skel_factory(POA_factory * servant,
		 GIOPRecvBuffer * _ORBIT_recv_buffer, gpointer * impl)
{
   gchar *opname = _ORBIT_recv_buffer->message.u.request.operation;

   switch (opname[0]) {
     case 'n':
	if (strcmp((opname + 1), "ewAccount"))
	   break;
	*impl = (gpointer) servant->vepv->factory_epv->newAccount;
	return (ORBitSkeleton) _ORBIT_skel_factory_newAccount;
	break;
     default:
	break;
   }
   return NULL;
}

static void
init_local_objref_factory(CORBA_Object obj, POA_factory * servant)
{
   obj->vepv[factory__classid] = servant->vepv->factory_epv;
}

void
POA_factory__init(PortableServer_Servant servant, CORBA_Environment * env)
{
   static const PortableServer_ClassInfo class_info =
      { (ORBit_impl_finder) & get_skel_factory, "IDL:factory:1.0",
	 (ORBit_local_objref_init) & init_local_objref_factory };

   PortableServer_ServantBase__init(((PortableServer_ServantBase *) servant),
				    env);
   ORBIT_OBJECT_KEY(((PortableServer_ServantBase *) servant)->_private)->
      class_info = (PortableServer_ClassInfo *) & class_info;
   if (!factory__classid)
      factory__classid = ORBit_register_class(&class_info);
}

void
POA_factory__fini(PortableServer_Servant servant, CORBA_Environment * env)
{
   PortableServer_ServantBase__fini(servant, env);
}
