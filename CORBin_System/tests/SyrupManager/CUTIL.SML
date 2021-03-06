(* cutil.sml
 * 
 * The SMLNJ-C Interface is COPYRIGHT (c) 1996 Bell Laboratories, Lucent Technologies
 *)

functor CUtil (structure C: C_CALLS) : C_UTIL = 
	 struct 
		 open C

(****Main CORBin-lib Routines****)
	 val CORBin_exception_init' = 
		 registerAutoFreeCFn("CORBin_exception_init",[], CvoidT)
	 fun CORBin_exception_init () = 
		 let val Cvoid  = CORBin_exception_init' [] in () end
	 val CORBin_orb_init' = 
		 registerAutoFreeCFn("CORBin_orb_init",[CstringT], CvoidT)
	 fun CORBin_orb_init p = 
		 let val Cvoid  = CORBin_orb_init' [Cstring p] in () end
	 val CORBin_string_to_object' = 
		 registerAutoFreeCFn("CORBin_string_to_object",[CstringT], CaddrT)
	 fun CORBin_string_to_object p = 
		 let val Caddr s = CORBin_string_to_object' [Cstring p] in s end
	 val CORBin_Object_release' = 
		 registerAutoFreeCFn("CORBin_Object_release",[CaddrT], CvoidT)
	 fun CORBin_Object_release p = 
		 let val Cvoid = CORBin_Object_release' [Caddr p] in () end
	 val CORBin_Object_duplicate' = 
		 registerAutoFreeCFn("CORBin_Object_duplicate",[CaddrT], CaddrT)
	 fun CORBin_Object_duplicate p = 
		 let val Caddr s = CORBin_Object_duplicate' [Caddr p] in s end
	 val CORBin_ORB_run' = 
		 registerAutoFreeCFn("CORBin_ORB_run",[], CvoidT)
	 fun CORBin_ORB_run () = 
		 let val Cvoid  = CORBin_ORB_run' [] in () end
	 val CORBin_ORB_resolve_initial_references' = 
		 registerAutoFreeCFn("CORBin_ORB_resolve_initial_references",[CstringT], CaddrT)
	 fun CORBin_ORB_resolve_initial_references p = 
		 let val Caddr s  = CORBin_ORB_resolve_initial_references' [Cstring p] in s end
	 val CORBin_PortableServer_POAManager_activate' = 
		 registerAutoFreeCFn("CORBin_PortableServer_POAManager_activate",[CaddrT], CvoidT)
	 fun CORBin_PortableServer_POAManager_activate p = 
		 let val Cvoid  = CORBin_PortableServer_POAManager_activate' [Caddr p] in () end
	 val CORBin_PortableServer_POA__get_the_POAManager' = 
		 registerAutoFreeCFn("CORBin_PortableServer_POA__get_the_POAManager",[CaddrT], CaddrT)
	 fun CORBin_PortableServer_POA__get_the_POAManager p = 
		 let val Caddr s  = CORBin_PortableServer_POA__get_the_POAManager' [Caddr p] in s  end
	 val CORBin_create_name' = 
		 registerAutoFreeCFn("CORBin_create_name",[CstringT], CaddrT)
	 fun CORBin_create_name p = 
		 let val Caddr s  = CORBin_create_name' [Cstring p] in s  end
	 val CORBin_CosNaming_NamingContext_resolve' = 
		 registerAutoFreeCFn("CORBin_CosNaming_NamingContext_resolve",[CaddrT,CaddrT], CaddrT)
	 fun CORBin_CosNaming_NamingContext_resolve (n,obj) = 
		 let val Caddr s  = CORBin_CosNaming_NamingContext_resolve' [Caddr n, Caddr obj] in s  end
	 val CORBin_CosNaming_NamingContext_bind' = 
		 registerAutoFreeCFn("CORBin_CosNaming_NamingContext_bind",[CaddrT,CaddrT,CaddrT], CvoidT)
	 fun CORBin_CosNaming_NamingContext_bind (ns,n,obj) = 
		 let val Cvoid  = CORBin_CosNaming_NamingContext_bind' [Caddr ns, Caddr n, Caddr obj] in () end
(****routines generated by corbin-idl****)

	val CORBin_Syrup_SyrupClient_create' = 
		registerAutoFreeCFn("CORBin_Syrup_SyrupClient_create", [CaddrT], CaddrT)
	fun CORBin_Syrup_SyrupClient_create (poa) = 
		let val  Caddr an_obj = CORBin_Syrup_SyrupClient_create' [Caddr poa] in  an_obj  end 

	val CORBin_Syrup_SyrupClient_Message' = 
		registerAutoFreeCFn("CORBin_Syrup_SyrupClient_Message", [CaddrT,CstringT,CstringT], CvoidT)
	fun CORBin_Syrup_SyrupClient_Message (CORBin_this_obj_ref,userid,msg) = 
		let val Cvoid  = CORBin_Syrup_SyrupClient_Message' [Caddr CORBin_this_obj_ref,Cstring userid,Cstring msg] in  ()  end 

	val CORBin_Syrup_SyrupClient_Message_SetMLFn' = 
		registerAutoFreeCFn("CORBin_Syrup_SyrupClient_Message_SetMLFn", [CfunctionT([CstringT,CstringT],  CintT )],CvoidT)
	fun CORBin_Syrup_SyrupClient_Message_SetMLFn f = 
		let val  Cvoid  = CORBin_Syrup_SyrupClient_Message_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_Syrup_SyrupClient_AddUserToList' = 
		registerAutoFreeCFn("CORBin_Syrup_SyrupClient_AddUserToList", [CaddrT,CstringT], CvoidT)
	fun CORBin_Syrup_SyrupClient_AddUserToList (CORBin_this_obj_ref,id) = 
		let val Cvoid  = CORBin_Syrup_SyrupClient_AddUserToList' [Caddr CORBin_this_obj_ref,Cstring id] in  ()  end 

	val CORBin_Syrup_SyrupClient_AddUserToList_SetMLFn' = 
		registerAutoFreeCFn("CORBin_Syrup_SyrupClient_AddUserToList_SetMLFn", [CfunctionT([CstringT],  CintT )],CvoidT)
	fun CORBin_Syrup_SyrupClient_AddUserToList_SetMLFn f = 
		let val  Cvoid  = CORBin_Syrup_SyrupClient_AddUserToList_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_Syrup_SyrupClient_RemoveUserFromList' = 
		registerAutoFreeCFn("CORBin_Syrup_SyrupClient_RemoveUserFromList", [CaddrT,CstringT], CvoidT)
	fun CORBin_Syrup_SyrupClient_RemoveUserFromList (CORBin_this_obj_ref,id) = 
		let val Cvoid  = CORBin_Syrup_SyrupClient_RemoveUserFromList' [Caddr CORBin_this_obj_ref,Cstring id] in  ()  end 

	val CORBin_Syrup_SyrupClient_RemoveUserFromList_SetMLFn' = 
		registerAutoFreeCFn("CORBin_Syrup_SyrupClient_RemoveUserFromList_SetMLFn", [CfunctionT([CstringT],  CintT )],CvoidT)
	fun CORBin_Syrup_SyrupClient_RemoveUserFromList_SetMLFn f = 
		let val  Cvoid  = CORBin_Syrup_SyrupClient_RemoveUserFromList_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_Syrup_SyrupManager_create' = 
		registerAutoFreeCFn("CORBin_Syrup_SyrupManager_create", [CaddrT], CaddrT)
	fun CORBin_Syrup_SyrupManager_create (poa) = 
		let val  Caddr an_obj = CORBin_Syrup_SyrupManager_create' [Caddr poa] in  an_obj  end 

	val CORBin_Syrup_SyrupManager_Login' = 
		registerAutoFreeCFn("CORBin_Syrup_SyrupManager_Login", [CaddrT,CstringT, CaddrT], CvoidT)
	fun CORBin_Syrup_SyrupManager_Login (CORBin_this_obj_ref,userid,client) = 
		let val Cvoid  = CORBin_Syrup_SyrupManager_Login' [Caddr CORBin_this_obj_ref,Cstring userid, Caddr client] in  ()  end 

	val CORBin_Syrup_SyrupManager_Login_SetMLFn' = 
		registerAutoFreeCFn("CORBin_Syrup_SyrupManager_Login_SetMLFn", [CfunctionT([CstringT, CaddrT],  CintT )],CvoidT)
	fun CORBin_Syrup_SyrupManager_Login_SetMLFn f = 
		let val  Cvoid  = CORBin_Syrup_SyrupManager_Login_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_Syrup_SyrupManager_Logout' = 
		registerAutoFreeCFn("CORBin_Syrup_SyrupManager_Logout", [CaddrT,CstringT], CvoidT)
	fun CORBin_Syrup_SyrupManager_Logout (CORBin_this_obj_ref,userid) = 
		let val Cvoid  = CORBin_Syrup_SyrupManager_Logout' [Caddr CORBin_this_obj_ref,Cstring userid] in  ()  end 

	val CORBin_Syrup_SyrupManager_Logout_SetMLFn' = 
		registerAutoFreeCFn("CORBin_Syrup_SyrupManager_Logout_SetMLFn", [CfunctionT([CstringT],  CintT )],CvoidT)
	fun CORBin_Syrup_SyrupManager_Logout_SetMLFn f = 
		let val  Cvoid  = CORBin_Syrup_SyrupManager_Logout_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_Syrup_SyrupManager_PostMessage' = 
		registerAutoFreeCFn("CORBin_Syrup_SyrupManager_PostMessage", [CaddrT,CstringT,CstringT], CvoidT)
	fun CORBin_Syrup_SyrupManager_PostMessage (CORBin_this_obj_ref,userid,msg) = 
		let val Cvoid  = CORBin_Syrup_SyrupManager_PostMessage' [Caddr CORBin_this_obj_ref,Cstring userid,Cstring msg] in  ()  end 

	val CORBin_Syrup_SyrupManager_PostMessage_SetMLFn' = 
		registerAutoFreeCFn("CORBin_Syrup_SyrupManager_PostMessage_SetMLFn", [CfunctionT([CstringT,CstringT],  CintT )],CvoidT)
	fun CORBin_Syrup_SyrupManager_PostMessage_SetMLFn f = 
		let val  Cvoid  = CORBin_Syrup_SyrupManager_PostMessage_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_Syrup_SyrupManager_SendMessage' = 
		registerAutoFreeCFn("CORBin_Syrup_SyrupManager_SendMessage", [CaddrT,CstringT,CstringT,CstringT], CvoidT)
	fun CORBin_Syrup_SyrupManager_SendMessage (CORBin_this_obj_ref,from,to,msg) = 
		let val Cvoid  = CORBin_Syrup_SyrupManager_SendMessage' [Caddr CORBin_this_obj_ref,Cstring from,Cstring to,Cstring msg] in  ()  end 

	val CORBin_Syrup_SyrupManager_SendMessage_SetMLFn' = 
		registerAutoFreeCFn("CORBin_Syrup_SyrupManager_SendMessage_SetMLFn", [CfunctionT([CstringT,CstringT,CstringT],  CintT )],CvoidT)
	fun CORBin_Syrup_SyrupManager_SendMessage_SetMLFn f = 
		let val  Cvoid  = CORBin_Syrup_SyrupManager_SendMessage_SetMLFn' [Cfunction f] in  ()  end 



end (*end of cutil.sml*)
