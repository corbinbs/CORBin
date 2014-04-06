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
		 val CORBin_orb_init : string -> unit
		 val CORBin_string_to_object : string -> caddr
		 val CORBin_Object_release : caddr -> unit
		 val CORBin_Object_duplicate : caddr -> caddr
		 val CORBin_ORB_run : unit -> unit
		 val CORBin_ORB_resolve_initial_references : string -> caddr
		 val CORBin_PortableServer_POAManager_activate : caddr  -> unit
		 val CORBin_PortableServer_POA__get_the_POAManager : caddr  -> caddr
		 val CORBin_create_name : string  -> caddr
		 val CORBin_CosNaming_NamingContext_resolve : caddr * caddr  -> caddr
		 val CORBin_CosNaming_NamingContext_bind : caddr * caddr * caddr  -> unit
(**Routines generated by corbin-idl **)
		 val CORBin_Syrup_SyrupClient_create : caddr  ->  caddr 
		 val CORBin_Syrup_SyrupClient_Message : caddr  * string  * string  -> unit 
		 val CORBin_Syrup_SyrupClient_Message_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_Syrup_SyrupClient_AddUserToList : caddr  * string  -> unit 
		 val CORBin_Syrup_SyrupClient_AddUserToList_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_Syrup_SyrupClient_RemoveUserFromList : caddr  * string  -> unit 
		 val CORBin_Syrup_SyrupClient_RemoveUserFromList_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_Syrup_SyrupManager_create : caddr  ->  caddr 
		 val CORBin_Syrup_SyrupManager_Login : caddr  * string  *  caddr  -> unit 
		 val CORBin_Syrup_SyrupManager_Login_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_Syrup_SyrupManager_Logout : caddr  * string  -> unit 
		 val CORBin_Syrup_SyrupManager_Logout_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_Syrup_SyrupManager_PostMessage : caddr  * string  * string  -> unit 
		 val CORBin_Syrup_SyrupManager_PostMessage_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_Syrup_SyrupManager_SendMessage : caddr  * string  * string  * string  -> unit 
		 val CORBin_Syrup_SyrupManager_SendMessage_SetMLFn : (cdata list -> cdata) ->  unit 


end (*end of cutil.sig.sml*)