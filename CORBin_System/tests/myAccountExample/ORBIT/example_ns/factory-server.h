/*
 * factory-server.h
 *    This is the common header file for the two implementation files
 * and the driver file factory-server.c
 */

#include "factory.h"
#include "account.h"

extern factory 
impl_factory__create(PortableServer_POA poa, CORBA_Environment * ev);

extern Account 
impl_Account__create(PortableServer_POA poa, CORBA_Environment * ev);
 
