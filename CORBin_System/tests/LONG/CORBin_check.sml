(* Must open these structures in order to use the ML/C Interface *)
open CI;
open CU;
(*****************************************************************)

val str = Cstring("IOR:010000001100000049444c3a706173736c6f6e673a312e3000696c6501000000caaedfba54000000010100002b0000002f746d702f6f726269742d636f7262696e62732f6f72622d3531333939323831343832373636343434350000000000001800000000000000c72342d00279e3e3010000006a9c91eca1b68ec4");


val cnv = datumMLtoC(CstringT);
val param = cnv(str);
val p = #1(param);


val test = Word32.fromInt(187);

val x = CORBin_exception_init(p) ;

val x = CORBin_orb_init (p);

val obj_ref = CORBin_string_to_object (p);

print (Int.toString (Word32.toInt test) ^ " was sent.\n");

val num = CORBin_passlong_foo(obj_ref, test );


print (Int.toString (Word32.toInt num) ^ " was returned.\n");

val ok = CORBin_Object_release(obj_ref);


