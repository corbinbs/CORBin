(* Must open these structures in order to use the ML/C Interface *)
open CI;
open CU;
(*****************************************************************)

use "SyrupManager.sml";

val naming_ior = "-ORBNamingIOR=IOR:000000000000002849444c3a6f6d672e6f72672f436f734e616d696e672f4e616d696e67436f6e746578743a312e3000000000010000000000000054000101000000000e3133302e3132372e35362e333400040200000018afabcafe00000002ebbd33240000000800000000000000000000000100000001000000140000000000010020000000000001010000000000";

(*****set function ptrs ****)

fun Login [Cstring id, Caddr obj] = (SyrupManager.add_user_to_list(id,obj);
			  print (id ^ " just logged in to SyrupManager\n");
			  SyrupManager.print_user_list();
			  print ("Sending Message to: " ^ id ^ "\n");
			  CORBin_Syrup_SyrupClient_Message(obj, "SyrupManager",
					"Welcome to Syrup!!!");
			  Cint(0w1) )
fun Logout [Cstring id] = (SyrupManager.remove_user_from_list(id);
			  print (id ^ " just logged out of SyrupManager\n");
			  SyrupManager.print_user_list();
			  Cint(0w1) )
fun PostMessage [Cstring id, Cstring msg] = (
			  SyrupManager.write_message(id, msg);
			  print ("PostMessage: " ^ id ^ " " ^ msg ^ "\n");
			  Cint(0w1) )

fun SendMessage [Cstring from, Cstring to, Cstring msg] = (
			  print ("In SendMessage:\n");
			  SyrupManager.send_message(from,to, msg);
			  print ("SendMessage: " ^ from ^ " " ^ to ^ " " ^ 
						   msg ^ "\n");
			  Cint(0w1) )

val _ = CORBin_Syrup_SyrupManager_Login_SetMLFn(Login);
val _ = CORBin_Syrup_SyrupManager_Logout_SetMLFn(Logout);
val _ = CORBin_Syrup_SyrupManager_PostMessage_SetMLFn(PostMessage);
val _ = CORBin_Syrup_SyrupManager_SendMessage_SetMLFn(SendMessage);

val x = CORBin_exception_init() ;

val x = CORBin_orb_init (naming_ior);

val root_poa = CORBin_ORB_resolve_initial_references("RootPOA");
val poa_man = CORBin_PortableServer_POA__get_the_POAManager(root_poa);
val _ = CORBin_PortableServer_POAManager_activate(poa_man);

val manager = CORBin_Syrup_SyrupManager_create(root_poa);

val name_srv = CORBin_ORB_resolve_initial_references("NameService");

val manager_name = CORBin_create_name("SyrupManager");

val _ = CORBin_CosNaming_NamingContext_bind(name_srv, manager_name, manager);

print "Ready to serve requests!\n\n";
val _ = CORBin_ORB_run(); 
val ok = CORBin_Object_release(acc_obj);


