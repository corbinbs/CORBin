(* cutil.sig.sml
 * 
 * The SMLNJ-C Interface is COPYRIGHT (c) 1996 Bell Laboratories, Lucent Technologies
 *)

signature C_UTIL = 
	sig
		 type caddr
		 type cdata
(**Main CORBin-lib routines**)
		 val CORBin_exception_init : unit -> unit
		 val CORBin_orb_init : caddr -> unit
		 val CORBin_string_to_object : string -> caddr
		 val CORBin_Object_release : caddr -> unit
		 val CORBin_ORB_run : unit -> unit
		 val CORBin_ORB_resolve_initial_references : string -> caddr
		 val CORBin_PortableServer_POAManager_activate : caddr  -> unit
		 val CORBin_PortableServer_POA__get_the_POAManager : caddr  -> caddr
		 val CORBin_create_name : string  -> caddr
		 val CORBin_CosNaming_NamingContext_resolve : caddr * caddr  -> caddr
		 val CORBin_CosNaming_NamingContext_bind : caddr * caddr * caddr  -> unit
(**Routines generated by corbin-idl **)
		 val CORBin_passlong_foo : caddr  * Word32.word  -> Word32.word 


end (*end of cutil.sig.sml*)
