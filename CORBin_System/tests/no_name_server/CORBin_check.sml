(* Must open these structures in order to use the ML/C Interface *)
open CI;
open CU;
(*****************************************************************)

val str = "IOR:01f4ffbf1000000049444c3a4163636f756e743a312e300002000000caaedfba44000000010100002c0000002f746d702f6f726269742d636f7262696e62732f6f72622d313832363039353530383135333833313136390000000000080000000000000001000000000000001c0000000101000006000000636f6e616e002b04080000000000000001000000";

val cnv = datumMLtoC(CstringT);
val param = cnv(str);
val p = #1(param);


val test = Word32.fromInt(187);

val x = CORBin_exception_init(p);

val x = CORBin_orb_init (p);

val obj_ref = CORBin_string_to_object (p);

val num = CORBin_Account_deposit(obj_ref, test);

val num = CORBin_Account_withdraw(obj_ref, 0w10 );

val ok = CORBin_Object_release(obj_ref);


