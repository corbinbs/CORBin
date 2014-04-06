/*
 * This file was generated by orbit-idl - DO NOT EDIT!
 */

#include <string.h>
#include "passlong.h"

void
_ORBIT_skel_passlong_foo(POA_passlong * _ORBIT_servant,
			 GIOPRecvBuffer * _ORBIT_recv_buffer,
			 CORBA_Environment * ev,
			 CORBA_long(*_impl_foo) (PortableServer_Servant
						 _servant, const CORBA_long x,
						 CORBA_Environment * ev))
{
   CORBA_long _ORBIT_retval;
   CORBA_long x;

   {				/* demarshalling */
      guchar *_ORBIT_curptr;

      _ORBIT_curptr = GIOP_RECV_BUFFER(_ORBIT_recv_buffer)->cur;
      if (giop_msg_conversion_needed(GIOP_MESSAGE_BUFFER(_ORBIT_recv_buffer))) {
	 _ORBIT_curptr = ALIGN_ADDRESS(_ORBIT_curptr, 4);
	 
	    (*((guint32 *) & (x))) =
	    GUINT32_SWAP_LE_BE(*((guint32 *) _ORBIT_curptr));} else {
	 _ORBIT_curptr = ALIGN_ADDRESS(_ORBIT_curptr, 4);
	 x = *((CORBA_long *) _ORBIT_curptr);
      }
   }
   _ORBIT_retval = _impl_foo(_ORBIT_servant, x, ev);
   {				/* marshalling */
      register GIOPSendBuffer *_ORBIT_send_buffer;

      _ORBIT_send_buffer =
	 giop_send_reply_buffer_use(GIOP_MESSAGE_BUFFER(_ORBIT_recv_buffer)->
				    connection, NULL,
				    _ORBIT_recv_buffer->message.u.request.
				    request_id, ev->_major);
      if (_ORBIT_send_buffer) {
	 if (ev->_major == CORBA_NO_EXCEPTION) {
	    giop_message_buffer_do_alignment(GIOP_MESSAGE_BUFFER
					     (_ORBIT_send_buffer), 4);
	    {
	       guchar *_ORBIT_t;

	       _ORBIT_t = alloca(sizeof(_ORBIT_retval));
	       memcpy(_ORBIT_t, &(_ORBIT_retval), sizeof(_ORBIT_retval));
	       giop_message_buffer_append_mem(GIOP_MESSAGE_BUFFER
					      (_ORBIT_send_buffer),
					      (_ORBIT_t),
					      sizeof(_ORBIT_retval));
	    }
	 } else
	    ORBit_send_system_exception(_ORBIT_send_buffer, ev);
	 giop_send_buffer_write(_ORBIT_send_buffer);
	 giop_send_buffer_unuse(_ORBIT_send_buffer);
      }
   }
}
static ORBitSkeleton
get_skel_passlong(POA_passlong * servant,
		  GIOPRecvBuffer * _ORBIT_recv_buffer, gpointer * impl)
{
   gchar *opname = _ORBIT_recv_buffer->message.u.request.operation;

   switch (opname[0]) {
     case 'f':
	if (strcmp((opname + 1), "oo"))
	   break;
	*impl = (gpointer) servant->vepv->passlong_epv->foo;
	return (ORBitSkeleton) _ORBIT_skel_passlong_foo;
	break;
     default:
	break;
   }
   return NULL;
}

static void
init_local_objref_passlong(CORBA_Object obj, POA_passlong * servant)
{
   obj->vepv[passlong__classid] = servant->vepv->passlong_epv;
}

void
POA_passlong__init(PortableServer_Servant servant, CORBA_Environment * env)
{
   static const PortableServer_ClassInfo class_info =
      { (ORBit_impl_finder) & get_skel_passlong, "IDL:passlong:1.0",
	 (ORBit_local_objref_init) & init_local_objref_passlong };

   PortableServer_ServantBase__init(((PortableServer_ServantBase *) servant),
				    env);
   ORBIT_OBJECT_KEY(((PortableServer_ServantBase *) servant)->_private)->
      class_info = (PortableServer_ClassInfo *) & class_info;
   if (!passlong__classid)
      passlong__classid = ORBit_register_class(&class_info);
}

void
POA_passlong__fini(PortableServer_Servant servant, CORBA_Environment * env)
{
   PortableServer_ServantBase__fini(servant, env);
}
