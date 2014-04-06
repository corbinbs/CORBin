(*   loadInterface.sml
 *   
 *   The SMLNJ-C Interface is COPYRIGHT (c) 1996 Bell Laboratories, Lucent Technologies
 *   This file constructs an SML/NJ C Interface for functions that were generated via corbin-idl.
 *) 

val _ = print "loading information about C types...\n";
app use ["/home/corbinbs/masters_proj/CORBin/sml_nj/src/smlnj-c/cc-info.sig.sml",
	"/home/corbinbs/masters_proj/CORBin/sml_nj/src/smlnj-c/cc-info.defaults.sml",
	"/home/corbinbs/masters_proj/CORBin/sml_nj/src/smlnj-c/cc-info.gcc-x86-linux.sml"];



val _ = print "loading C interface...\n";
app use ["/home/corbinbs/masters_proj/CORBin/sml_nj/src/smlnj-c/c-calls.sig.sml",
	"/home/corbinbs/masters_proj/CORBin/sml_nj/src/smlnj-c/c-calls.sml",
	"cutil.sig.sml",
	"cutil.sml"];



val _ = print "instantiating CCalls for GCC on X86Linux...\n";
structure CI = CCalls(structure CCInfo = GCCInfoX86Linux);



val _ = print "instantiating CUtil...\n";
structure CU = CUtil(structure C = CI);




