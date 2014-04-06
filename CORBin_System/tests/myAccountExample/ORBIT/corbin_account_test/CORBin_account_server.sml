(* Must open these structures in order to use the ML/C Interface *)
open CI;
open CU;
(*****************************************************************)

val str = Cstring("-ORBNamingIOR=IOR:000000000000002849444c3a6f6d672e6f72672f436f734e616d696e672f4e616d696e67436f6e746578743a312e3000000000010000000000000054000101000000000e3133302e3132372e35362e3334000ecc00000018afabcafe00000002e6750aa10000000800000000000000000000000100000001000000140000000000010020000000000001010000000000");

val cnv = datumMLtoC(CstringT);
val param = cnv(str);
val p = #1(param);

val balance = ref (Word32.fromInt(0));

(*****set function ptrs ****)

fun withdraw [Clong x] = (balance := (!balance) - x; 
			  print ("balance is : " 
			^ (Int.toString((Word32.toInt(!balance)))) ^"\n");
			  Cint(0w1) )
fun deposit [Clong x] = (balance := (!balance) + x; 
			  print ("balance is : " 
			^ (Int.toString((Word32.toInt(!balance)))) ^"\n");
			  Cint(0w1) )


val _ = CORBin_Account_deposit_SetMLFn(deposit);
val _ = CORBin_Account_withdraw_SetMLFn(withdraw);

val x = CORBin_exception_init() ;

val x = CORBin_orb_init (p);

val root_poa = CORBin_ORB_resolve_initial_references("RootPOA");
val poa_man = CORBin_PortableServer_POA__get_the_POAManager(root_poa);
val _ = CORBin_PortableServer_POAManager_activate(poa_man);

val acc_obj = CORBin_Account_create(root_poa);

val name_srv = CORBin_ORB_resolve_initial_references("NameService");

val acct_name = CORBin_create_name("CorbinAccountServer");

val _ = CORBin_CosNaming_NamingContext_bind(name_srv, acct_name, acc_obj);

print "Ready to serve requests!\n\n";
print ("Initial balance is : " 
	^ (Int.toString((Word32.toInt(!balance)))) ^"\n");
val _ = CORBin_ORB_run(); 

val ok = CORBin_Object_release(acc_obj);


