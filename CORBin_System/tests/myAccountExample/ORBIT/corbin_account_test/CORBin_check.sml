(* Must open these structures in order to use the ML/C Interface *)
open CI;
open CU;
(*****************************************************************)

val str = Cstring("-ORBNamingIOR=IOR:010000002800000049444c3a6f6d672e6f72672f436f734e616d696e672f4e616d696e67436f6e746578743a312e300001000000caaedfba54000000010100002c0000002f746d702f6f726269742d636f7262696e62732f6f72622d3439393231303334373137333636363839363100000000001800000000000000b1d5703ac4733c6a010000009e0629bd05e10982");


val cnv = datumMLtoC(CstringT);
val param = cnv(str);
val p = #1(param);


val test = Word32.fromInt(187);

val x = CORBin_exception_init() ;

val x = CORBin_orb_init (p);

val name_srv = CORBin_ORB_resolve_initial_references("NameService");

val acct_name = CORBin_create_name("CorbinAccountServer");

val acc_client = CORBin_CosNaming_NamingContext_resolve(name_srv, acct_name);

val _ = CORBin_Account_deposit(acc_client, test);

val ok = CORBin_Object_release(acc_client);


