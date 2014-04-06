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
		 val CORBin_MazeApp_PlayerCallBack_create : caddr  ->  caddr 
		 val CORBin_MazeApp_PlayerCallBack_message : caddr  * string  -> unit 
		 val CORBin_MazeApp_PlayerCallBack_message_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_MazeApp_PlayerCallBack_getPlayersName : caddr  -> string 
		 val CORBin_MazeApp_PlayerCallBack_getPlayersName_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_MazeApp_PlayerCallBack_getRoomNo : caddr  -> Word32.word 
		 val CORBin_MazeApp_PlayerCallBack_getRoomNo_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_MazeApp_PlayerCallBack_turnRight : caddr  -> unit 
		 val CORBin_MazeApp_PlayerCallBack_turnRight_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_MazeApp_PlayerCallBack_turnLeft : caddr  -> unit 
		 val CORBin_MazeApp_PlayerCallBack_turnLeft_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_MazeApp_PlayerCallBack_turnAround : caddr  -> unit 
		 val CORBin_MazeApp_PlayerCallBack_turnAround_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_MazeApp_PlayerCallBack_getIntDirection : caddr  -> Word32.word 
		 val CORBin_MazeApp_PlayerCallBack_getIntDirection_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_MazeApp_PlayerCallBack_changeRooms : caddr  * Word32.word  -> unit 
		 val CORBin_MazeApp_PlayerCallBack_changeRooms_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_MazeApp_PlayerCallBack_getStatus : caddr  -> string 
		 val CORBin_MazeApp_PlayerCallBack_getStatus_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_MazeApp_MazeServer_create : caddr  ->  caddr 
		 val CORBin_MazeApp_MazeServer_joinGame : caddr  *  PlayerCallBack
 -> unit 
		 val CORBin_MazeApp_MazeServer_joinGame_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_MazeApp_MazeServer_leaveGame : caddr  *  PlayerCallBack
 -> unit 
		 val CORBin_MazeApp_MazeServer_leaveGame_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_MazeApp_MazeServer_turnRight : caddr  *  PlayerCallBack
 -> unit 
		 val CORBin_MazeApp_MazeServer_turnRight_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_MazeApp_MazeServer_turnLeft : caddr  *  PlayerCallBack
 -> unit 
		 val CORBin_MazeApp_MazeServer_turnLeft_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_MazeApp_MazeServer_turnAround : caddr  *  PlayerCallBack
 -> unit 
		 val CORBin_MazeApp_MazeServer_turnAround_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_MazeApp_MazeServer_move : caddr  *  PlayerCallBack
 -> unit 
		 val CORBin_MazeApp_MazeServer_move_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_MazeApp_MazeServer_notifyPlayerInfo : caddr  *  PlayerCallBack
 -> unit 
		 val CORBin_MazeApp_MazeServer_notifyPlayerInfo_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_MazeApp_MazeServer_viewLeft : caddr  *  PlayerCallBack
 -> Word32.word 
		 val CORBin_MazeApp_MazeServer_viewLeft_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_MazeApp_MazeServer_viewCenter : caddr  *  PlayerCallBack
 -> Word32.word 
		 val CORBin_MazeApp_MazeServer_viewCenter_SetMLFn : (cdata list -> cdata) ->  unit 
		 val CORBin_MazeApp_MazeServer_viewRight : caddr  *  PlayerCallBack
 -> Word32.word 
		 val CORBin_MazeApp_MazeServer_viewRight_SetMLFn : (cdata list -> cdata) ->  unit 


end (*end of cutil.sig.sml*)