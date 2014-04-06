
/*
 * name.c - helper function for creating CosNaming::Name components
 *
 */


#include "name.h"


CosNaming_Name* create_name(const char* name) {

  CosNaming_Name *cos_name;
  CosNaming_NameComponent *cos_name_cmp;
  char *id;
  char *kind;
  char *dummy_kind = "CORBin_ML";

  /* Allocate a CosNaming::Name (sequence of CosNaming::NameComponent) */
  cos_name = (CosNaming_Name *) malloc (sizeof(CosNaming_Name));
  cos_name->_maximum=1L;
  cos_name->_length=1L;

  /* Relinquish ownership of the NameComponent to the sequence. When
     CORBA_free is called on it later, the NameComponent will be freed */
  CORBA_sequence_set_release(cos_name, FALSE);

  /* Create the naming component.  We don't care about the kind, so
   * we give it a dummy value */
  cos_name_cmp = (CosNaming_NameComponent*)
    malloc(sizeof(CosNaming_NameComponent));

  /* Create id and kind value components. id is the name of our object */
  id = CORBA_string_alloc(strlen(name));
  strcpy(id,name);
  cos_name_cmp->id = id;
  kind=CORBA_string_alloc(strlen(dummy_kind));
  strcpy(kind,dummy_kind);
  cos_name_cmp->kind=kind;

  cos_name->_buffer=cos_name_cmp;

  return cos_name;
}
