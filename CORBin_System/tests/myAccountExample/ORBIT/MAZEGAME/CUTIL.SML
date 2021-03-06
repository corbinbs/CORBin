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
		 registerAutoFreeCFn("CORBin_orb_init",[CaddrT], CvoidT)
	 fun CORBin_orb_init p = 
		 let val Cvoid  = CORBin_orb_init' [Caddr p] in () end
	 val CORBin_string_to_object' = 
		 registerAutoFreeCFn("CORBin_string_to_object",[CstringT], CaddrT)
	 fun CORBin_string_to_object p = 
		 let val Caddr s = CORBin_string_to_object' [Cstring p] in s end
	 val CORBin_Object_release' = 
		 registerAutoFreeCFn("CORBin_Object_release",[CaddrT], CvoidT)
	 fun CORBin_Object_release p = 
		 let val Cvoid = CORBin_Object_release' [Caddr p] in () end
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

	val CORBin_MazeApp_PlayerCallBack_create' = 
		registerAutoFreeCFn("CORBin_MazeApp_PlayerCallBack_create", [CaddrT], CaddrT)
	fun CORBin_MazeApp_PlayerCallBack_create (poa) = 
		let val  Caddr an_obj = CORBin_MazeApp_PlayerCallBack_create' [Caddr poa] in  an_obj  end 

	val CORBin_MazeApp_PlayerCallBack_message' = 
		registerAutoFreeCFn("CORBin_MazeApp_PlayerCallBack_message", [CaddrT,CstringT], CvoidT)
	fun CORBin_MazeApp_PlayerCallBack_message (CORBin_this_obj_ref,msg) = 
		let val Cvoid  = CORBin_MazeApp_PlayerCallBack_message' [Caddr CORBin_this_obj_ref,Cstring msg] in  ()  end 

	val CORBin_MazeApp_PlayerCallBack_message_SetMLFn' = 
		registerAutoFreeCFn("CORBin_MazeApp_PlayerCallBack_message_SetMLFn", [CfunctionT([CstringT],  CintT )],CvoidT)
	fun CORBin_MazeApp_PlayerCallBack_message_SetMLFn f = 
		let val  Cvoid  = CORBin_MazeApp_PlayerCallBack_message_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_MazeApp_PlayerCallBack_getPlayersName' = 
		registerAutoFreeCFn("CORBin_MazeApp_PlayerCallBack_getPlayersName", [CaddrT], CstringT)
	fun CORBin_MazeApp_PlayerCallBack_getPlayersName (CORBin_this_obj_ref) = 
		let val Cstring my_return_value = CORBin_MazeApp_PlayerCallBack_getPlayersName' [Caddr CORBin_this_obj_ref] in  my_return_value  end 

	val CORBin_MazeApp_PlayerCallBack_getPlayersName_SetMLFn' = 
		registerAutoFreeCFn("CORBin_MazeApp_PlayerCallBack_getPlayersName_SetMLFn", [CfunctionT([], CstringT)],CvoidT)
	fun CORBin_MazeApp_PlayerCallBack_getPlayersName_SetMLFn f = 
		let val  Cvoid  = CORBin_MazeApp_PlayerCallBack_getPlayersName_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_MazeApp_PlayerCallBack_getRoomNo' = 
		registerAutoFreeCFn("CORBin_MazeApp_PlayerCallBack_getRoomNo", [CaddrT], ClongT)
	fun CORBin_MazeApp_PlayerCallBack_getRoomNo (CORBin_this_obj_ref) = 
		let val Clong my_return_value = CORBin_MazeApp_PlayerCallBack_getRoomNo' [Caddr CORBin_this_obj_ref] in  my_return_value  end 

	val CORBin_MazeApp_PlayerCallBack_getRoomNo_SetMLFn' = 
		registerAutoFreeCFn("CORBin_MazeApp_PlayerCallBack_getRoomNo_SetMLFn", [CfunctionT([], ClongT)],CvoidT)
	fun CORBin_MazeApp_PlayerCallBack_getRoomNo_SetMLFn f = 
		let val  Cvoid  = CORBin_MazeApp_PlayerCallBack_getRoomNo_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_MazeApp_PlayerCallBack_turnRight' = 
		registerAutoFreeCFn("CORBin_MazeApp_PlayerCallBack_turnRight", [CaddrT], CvoidT)
	fun CORBin_MazeApp_PlayerCallBack_turnRight (CORBin_this_obj_ref) = 
		let val Cvoid  = CORBin_MazeApp_PlayerCallBack_turnRight' [Caddr CORBin_this_obj_ref] in  ()  end 

	val CORBin_MazeApp_PlayerCallBack_turnRight_SetMLFn' = 
		registerAutoFreeCFn("CORBin_MazeApp_PlayerCallBack_turnRight_SetMLFn", [CfunctionT([],  CintT )],CvoidT)
	fun CORBin_MazeApp_PlayerCallBack_turnRight_SetMLFn f = 
		let val  Cvoid  = CORBin_MazeApp_PlayerCallBack_turnRight_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_MazeApp_PlayerCallBack_turnLeft' = 
		registerAutoFreeCFn("CORBin_MazeApp_PlayerCallBack_turnLeft", [CaddrT], CvoidT)
	fun CORBin_MazeApp_PlayerCallBack_turnLeft (CORBin_this_obj_ref) = 
		let val Cvoid  = CORBin_MazeApp_PlayerCallBack_turnLeft' [Caddr CORBin_this_obj_ref] in  ()  end 

	val CORBin_MazeApp_PlayerCallBack_turnLeft_SetMLFn' = 
		registerAutoFreeCFn("CORBin_MazeApp_PlayerCallBack_turnLeft_SetMLFn", [CfunctionT([],  CintT )],CvoidT)
	fun CORBin_MazeApp_PlayerCallBack_turnLeft_SetMLFn f = 
		let val  Cvoid  = CORBin_MazeApp_PlayerCallBack_turnLeft_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_MazeApp_PlayerCallBack_turnAround' = 
		registerAutoFreeCFn("CORBin_MazeApp_PlayerCallBack_turnAround", [CaddrT], CvoidT)
	fun CORBin_MazeApp_PlayerCallBack_turnAround (CORBin_this_obj_ref) = 
		let val Cvoid  = CORBin_MazeApp_PlayerCallBack_turnAround' [Caddr CORBin_this_obj_ref] in  ()  end 

	val CORBin_MazeApp_PlayerCallBack_turnAround_SetMLFn' = 
		registerAutoFreeCFn("CORBin_MazeApp_PlayerCallBack_turnAround_SetMLFn", [CfunctionT([],  CintT )],CvoidT)
	fun CORBin_MazeApp_PlayerCallBack_turnAround_SetMLFn f = 
		let val  Cvoid  = CORBin_MazeApp_PlayerCallBack_turnAround_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_MazeApp_PlayerCallBack_getIntDirection' = 
		registerAutoFreeCFn("CORBin_MazeApp_PlayerCallBack_getIntDirection", [CaddrT], ClongT)
	fun CORBin_MazeApp_PlayerCallBack_getIntDirection (CORBin_this_obj_ref) = 
		let val Clong my_return_value = CORBin_MazeApp_PlayerCallBack_getIntDirection' [Caddr CORBin_this_obj_ref] in  my_return_value  end 

	val CORBin_MazeApp_PlayerCallBack_getIntDirection_SetMLFn' = 
		registerAutoFreeCFn("CORBin_MazeApp_PlayerCallBack_getIntDirection_SetMLFn", [CfunctionT([], ClongT)],CvoidT)
	fun CORBin_MazeApp_PlayerCallBack_getIntDirection_SetMLFn f = 
		let val  Cvoid  = CORBin_MazeApp_PlayerCallBack_getIntDirection_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_MazeApp_PlayerCallBack_changeRooms' = 
		registerAutoFreeCFn("CORBin_MazeApp_PlayerCallBack_changeRooms", [CaddrT,ClongT], CvoidT)
	fun CORBin_MazeApp_PlayerCallBack_changeRooms (CORBin_this_obj_ref,room) = 
		let val Cvoid  = CORBin_MazeApp_PlayerCallBack_changeRooms' [Caddr CORBin_this_obj_ref,Clong room] in  ()  end 

	val CORBin_MazeApp_PlayerCallBack_changeRooms_SetMLFn' = 
		registerAutoFreeCFn("CORBin_MazeApp_PlayerCallBack_changeRooms_SetMLFn", [CfunctionT([ClongT],  CintT )],CvoidT)
	fun CORBin_MazeApp_PlayerCallBack_changeRooms_SetMLFn f = 
		let val  Cvoid  = CORBin_MazeApp_PlayerCallBack_changeRooms_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_MazeApp_PlayerCallBack_getStatus' = 
		registerAutoFreeCFn("CORBin_MazeApp_PlayerCallBack_getStatus", [CaddrT], CstringT)
	fun CORBin_MazeApp_PlayerCallBack_getStatus (CORBin_this_obj_ref) = 
		let val Cstring my_return_value = CORBin_MazeApp_PlayerCallBack_getStatus' [Caddr CORBin_this_obj_ref] in  my_return_value  end 

	val CORBin_MazeApp_PlayerCallBack_getStatus_SetMLFn' = 
		registerAutoFreeCFn("CORBin_MazeApp_PlayerCallBack_getStatus_SetMLFn", [CfunctionT([], CstringT)],CvoidT)
	fun CORBin_MazeApp_PlayerCallBack_getStatus_SetMLFn f = 
		let val  Cvoid  = CORBin_MazeApp_PlayerCallBack_getStatus_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_MazeApp_MazeServer_create' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_create", [CaddrT], CaddrT)
	fun CORBin_MazeApp_MazeServer_create (poa) = 
		let val  Caddr an_obj = CORBin_MazeApp_MazeServer_create' [Caddr poa] in  an_obj  end 

	val CORBin_MazeApp_MazeServer_joinGame' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_joinGame", [CaddrT, PlayerCallBack
], CvoidT)
	fun CORBin_MazeApp_MazeServer_joinGame (CORBin_this_obj_ref,play_obj) = 
		let val Cvoid  = CORBin_MazeApp_MazeServer_joinGame' [Caddr CORBin_this_obj_ref, PlayerCallBack
play_obj] in  ()  end 

	val CORBin_MazeApp_MazeServer_joinGame_SetMLFn' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_joinGame_SetMLFn", [CfunctionT([ PlayerCallBack
],  CintT )],CvoidT)
	fun CORBin_MazeApp_MazeServer_joinGame_SetMLFn f = 
		let val  Cvoid  = CORBin_MazeApp_MazeServer_joinGame_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_MazeApp_MazeServer_leaveGame' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_leaveGame", [CaddrT, PlayerCallBack
], CvoidT)
	fun CORBin_MazeApp_MazeServer_leaveGame (CORBin_this_obj_ref,play_obj) = 
		let val Cvoid  = CORBin_MazeApp_MazeServer_leaveGame' [Caddr CORBin_this_obj_ref, PlayerCallBack
play_obj] in  ()  end 

	val CORBin_MazeApp_MazeServer_leaveGame_SetMLFn' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_leaveGame_SetMLFn", [CfunctionT([ PlayerCallBack
],  CintT )],CvoidT)
	fun CORBin_MazeApp_MazeServer_leaveGame_SetMLFn f = 
		let val  Cvoid  = CORBin_MazeApp_MazeServer_leaveGame_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_MazeApp_MazeServer_turnRight' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_turnRight", [CaddrT, PlayerCallBack
], CvoidT)
	fun CORBin_MazeApp_MazeServer_turnRight (CORBin_this_obj_ref,play_obj) = 
		let val Cvoid  = CORBin_MazeApp_MazeServer_turnRight' [Caddr CORBin_this_obj_ref, PlayerCallBack
play_obj] in  ()  end 

	val CORBin_MazeApp_MazeServer_turnRight_SetMLFn' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_turnRight_SetMLFn", [CfunctionT([ PlayerCallBack
],  CintT )],CvoidT)
	fun CORBin_MazeApp_MazeServer_turnRight_SetMLFn f = 
		let val  Cvoid  = CORBin_MazeApp_MazeServer_turnRight_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_MazeApp_MazeServer_turnLeft' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_turnLeft", [CaddrT, PlayerCallBack
], CvoidT)
	fun CORBin_MazeApp_MazeServer_turnLeft (CORBin_this_obj_ref,play_obj) = 
		let val Cvoid  = CORBin_MazeApp_MazeServer_turnLeft' [Caddr CORBin_this_obj_ref, PlayerCallBack
play_obj] in  ()  end 

	val CORBin_MazeApp_MazeServer_turnLeft_SetMLFn' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_turnLeft_SetMLFn", [CfunctionT([ PlayerCallBack
],  CintT )],CvoidT)
	fun CORBin_MazeApp_MazeServer_turnLeft_SetMLFn f = 
		let val  Cvoid  = CORBin_MazeApp_MazeServer_turnLeft_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_MazeApp_MazeServer_turnAround' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_turnAround", [CaddrT, PlayerCallBack
], CvoidT)
	fun CORBin_MazeApp_MazeServer_turnAround (CORBin_this_obj_ref,play_obj) = 
		let val Cvoid  = CORBin_MazeApp_MazeServer_turnAround' [Caddr CORBin_this_obj_ref, PlayerCallBack
play_obj] in  ()  end 

	val CORBin_MazeApp_MazeServer_turnAround_SetMLFn' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_turnAround_SetMLFn", [CfunctionT([ PlayerCallBack
],  CintT )],CvoidT)
	fun CORBin_MazeApp_MazeServer_turnAround_SetMLFn f = 
		let val  Cvoid  = CORBin_MazeApp_MazeServer_turnAround_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_MazeApp_MazeServer_move' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_move", [CaddrT, PlayerCallBack
], CvoidT)
	fun CORBin_MazeApp_MazeServer_move (CORBin_this_obj_ref,play_obj) = 
		let val Cvoid  = CORBin_MazeApp_MazeServer_move' [Caddr CORBin_this_obj_ref, PlayerCallBack
play_obj] in  ()  end 

	val CORBin_MazeApp_MazeServer_move_SetMLFn' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_move_SetMLFn", [CfunctionT([ PlayerCallBack
],  CintT )],CvoidT)
	fun CORBin_MazeApp_MazeServer_move_SetMLFn f = 
		let val  Cvoid  = CORBin_MazeApp_MazeServer_move_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_MazeApp_MazeServer_notifyPlayerInfo' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_notifyPlayerInfo", [CaddrT, PlayerCallBack
], CvoidT)
	fun CORBin_MazeApp_MazeServer_notifyPlayerInfo (CORBin_this_obj_ref,play_obj) = 
		let val Cvoid  = CORBin_MazeApp_MazeServer_notifyPlayerInfo' [Caddr CORBin_this_obj_ref, PlayerCallBack
play_obj] in  ()  end 

	val CORBin_MazeApp_MazeServer_notifyPlayerInfo_SetMLFn' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_notifyPlayerInfo_SetMLFn", [CfunctionT([ PlayerCallBack
],  CintT )],CvoidT)
	fun CORBin_MazeApp_MazeServer_notifyPlayerInfo_SetMLFn f = 
		let val  Cvoid  = CORBin_MazeApp_MazeServer_notifyPlayerInfo_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_MazeApp_MazeServer_viewLeft' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_viewLeft", [CaddrT, PlayerCallBack
], ClongT)
	fun CORBin_MazeApp_MazeServer_viewLeft (CORBin_this_obj_ref,play_obj) = 
		let val Clong my_return_value = CORBin_MazeApp_MazeServer_viewLeft' [Caddr CORBin_this_obj_ref, PlayerCallBack
play_obj] in  my_return_value  end 

	val CORBin_MazeApp_MazeServer_viewLeft_SetMLFn' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_viewLeft_SetMLFn", [CfunctionT([ PlayerCallBack
], ClongT)],CvoidT)
	fun CORBin_MazeApp_MazeServer_viewLeft_SetMLFn f = 
		let val  Cvoid  = CORBin_MazeApp_MazeServer_viewLeft_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_MazeApp_MazeServer_viewCenter' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_viewCenter", [CaddrT, PlayerCallBack
], ClongT)
	fun CORBin_MazeApp_MazeServer_viewCenter (CORBin_this_obj_ref,play_obj) = 
		let val Clong my_return_value = CORBin_MazeApp_MazeServer_viewCenter' [Caddr CORBin_this_obj_ref, PlayerCallBack
play_obj] in  my_return_value  end 

	val CORBin_MazeApp_MazeServer_viewCenter_SetMLFn' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_viewCenter_SetMLFn", [CfunctionT([ PlayerCallBack
], ClongT)],CvoidT)
	fun CORBin_MazeApp_MazeServer_viewCenter_SetMLFn f = 
		let val  Cvoid  = CORBin_MazeApp_MazeServer_viewCenter_SetMLFn' [Cfunction f] in  ()  end 

	val CORBin_MazeApp_MazeServer_viewRight' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_viewRight", [CaddrT, PlayerCallBack
], ClongT)
	fun CORBin_MazeApp_MazeServer_viewRight (CORBin_this_obj_ref,play_obj) = 
		let val Clong my_return_value = CORBin_MazeApp_MazeServer_viewRight' [Caddr CORBin_this_obj_ref, PlayerCallBack
play_obj] in  my_return_value  end 

	val CORBin_MazeApp_MazeServer_viewRight_SetMLFn' = 
		registerAutoFreeCFn("CORBin_MazeApp_MazeServer_viewRight_SetMLFn", [CfunctionT([ PlayerCallBack
], ClongT)],CvoidT)
	fun CORBin_MazeApp_MazeServer_viewRight_SetMLFn f = 
		let val  Cvoid  = CORBin_MazeApp_MazeServer_viewRight_SetMLFn' [Cfunction f] in  ()  end 



end (*end of cutil.sml*)
