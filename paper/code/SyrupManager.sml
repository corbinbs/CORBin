structure SyrupManager :
	sig 
		val print_list: (string * caddr) list -> unit
		val print_user_list:  unit  -> unit
		val add_user_to_list : (string * caddr) -> unit
		val remove_from_list: string * ((string * caddr) list) -> 
					(string * caddr) list
		val remove_user_from_list: string -> unit
		val write_message : string * string -> unit
		val send_message: string * string * string -> unit
		val user_list : (string * caddr) list ref
		val add_user_to_clients_gui: string * ((string * caddr) list) ->unit 
		val remove_user_from_clients_gui: string * ((string * caddr) list) ->unit 
        end = 

struct



(*******User List********)
val user_list: (string * caddr) list ref  = ref [] 

fun add_user_to_clients_gui(id: string, nil) =  ()
  | add_user_to_clients_gui(id: string, (uid: string, obj: caddr)::rest) = 
		(
                if (id = uid) then 
			add_user_to_clients_gui(id, rest)
		else 
		       (CORBin_Syrup_SyrupClient_AddUserToList(obj, id);
			add_user_to_clients_gui(id, rest)))

fun add_users_to_new_clients_gui(obj: caddr, nil) =  ()
  | add_users_to_new_clients_gui(obj: caddr,(uid: string, uobj: caddr)::rest) = 
		(CORBin_Syrup_SyrupClient_AddUserToList(obj, uid);
		add_users_to_new_clients_gui(obj, rest))

fun remove_user_from_clients_gui(id: string, nil) =  ()
  | remove_user_from_clients_gui(id: string, (uid: string, obj: caddr)::rest) = 
		(CORBin_Syrup_SyrupClient_RemoveUserFromList(obj, id);
		remove_user_from_clients_gui(id, rest))

fun add_user_to_list (id: string, obj: caddr) = 
	let val obj_copy = CORBin_Object_duplicate(obj)
        in
		user_list := (id,obj_copy)::(!user_list);
		add_user_to_clients_gui(id, !user_list);
		add_users_to_new_clients_gui(obj_copy, !user_list)
	end 


fun print_list (nil) = (print (""))
  | print_list ((id:string ,obj: caddr)::rest) = (print (id ^ "\n"); print_list rest)

fun print_user_list () = print_list (!user_list) 

fun remove_from_list(id: string, nil) = ( [] )
  | remove_from_list(id: string, (user: string,obj: caddr)::rest) = 
                               (if (id = user) then 
				    (remove_from_list(id, rest))
				else 
				    ((user,obj)::remove_from_list(id, rest)) )

fun remove_user_from_list(id: string) = 
		(user_list := (remove_from_list(id, !user_list));
                 remove_user_from_clients_gui(id, !user_list))


fun write_message(id, msg) = 
    let val msg_file = TextIO.openAppend("/usr/local/apache/htdocs/syrup/message_board/messages.txt")
        val _ = TextIO.output(msg_file, 
			("ScreenName: " ^ id ^ " wrote: \n" ^
			  msg ^ "\n\n"))
    in 
	TextIO.closeOut msg_file
    end

fun send_msg (from, to, msg, nil) = ()
  | send_msg (from, to, msg, (id: string,obj: caddr)::rest) = 
                               (if (to = id) then 
				  (print ("Sending Message to: " ^ id ^ "\n");
				  CORBin_Syrup_SyrupClient_Message(obj,
								   from, 
                                                                   msg))
				else 
				  send_msg(from,to, msg, rest))

			

fun send_message(from,to, msg) = send_msg(from, to, msg, (!user_list)) 


end 
