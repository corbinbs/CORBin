(* cutil.sig.sml
 * 
 * The SMLNJ-C Interface is COPYRIGHT (c) 1996 Bell Laboratories, Lucent Technologies
 *)

signature C_UTIL = 
	sig
		 type caddr
(**Main CORBin-lib routines**)
		 val CORBin_exception_init : caddr -> Word32.word
		 val CORBin_orb_init : caddr -> Word32.word
		 val CORBin_string_to_object : caddr -> caddr
		 val CORBin_Object_release : caddr -> Word32.word
(**Routines generated by corbin-idl **)
		 val CORBin_Account_deposit : caddr  * Word32.word  -> unit 
		 val CORBin_Account_withdraw : caddr  * Word32.word  -> unit 


end (*end of cutil.sig.sml*)
