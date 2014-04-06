structure GenSML_CInterface : 
     sig 
	 val gen_sml : AST.file -> unit 
         val gen_smlFromAST : TextIO.outstream * AST.file -> unit
         val gen_sigFromAST : TextIO.outstream * AST.file -> unit
         val makeLoadFile : TextIO.outstream  -> unit
         val genCutilSmlHeader : TextIO.outstream  -> unit
         val genCutilSigHeader : TextIO.outstream  -> unit
         val endCutilSml: TextIO.outstream  -> unit
         val endCutilSig: TextIO.outstream  -> unit
	 val interfaceName : string ref
	 val moduleName : string ref
	 val doComma : bool ref
	 val passParam : bool ref
	 val voidReturn : bool ref
	 val doCtype : bool ref
	 val ml_c_dir : string ref
         val scoped_type : bool ref
     end =
struct

  structure A = AST

  val ml_c_dir = ref ""
  val interfaceName = ref ""
  val moduleName = ref ""
  val doComma = ref false
  val doCtype = ref false
  val passParam = ref false
  val voidReturn = ref false
  val scoped_type = ref false

(********GENSIG: code to generate cutil.sig.sml *****************)

fun gen_sigFromAST(outstream, a0) =
 let fun say s  = TextIO.output(outstream, s)
     fun sayln s = (say s; say "\n")

  fun indent 0 = ()
    | indent i = (say " "; indent(i-1))


  fun dolist d f [a] = (f(a,d+1))
    | dolist d f (a::r) = (f(a,d+1); say ""; dolist d f r)
    | dolist d f nil = ()




  fun var(A.SimpleVar(s,p),d) = (indent d; say "SimpleVar("; 
			         say(s); say ")")
  and exp(A.VarExp v, d) = (indent d; sayln "VarExp("; var(v,d+1); say ")")
    | exp(A.NilExp, d) = ()
    | exp(A.InterfaceDcl(head,body), d) = (
			(*Get Interface Name*)
			exp(head,d+1);
			(**gen sig for create method**)
			say "\t\t val CORBin_";
			if ((!moduleName) = "") then say ""
			else (say (!moduleName); say "_");
			say (!interfaceName);
			say "_";
			say "create"; say " : ";
			say "caddr ";	
			say " -> ";
			say " caddr ";
			sayln "";




			(*Loop over Interface Body*)
			
			dolist (d+1) exp body) 
    | exp(A.EmptyInterfaceDcl(head), d) = ()
    | exp(A.IntfHeader(name,inherit), d) = (
			(*Set interfaceName *)
			interfaceName := Symbol.name name ) 
    | exp(A.AbsIntfHeader(name,inherit), d) = (indent d; 
			say "AbstractInterfaceHeader("; say (Symbol.name name);
			say ",["; dolist d exp inherit; sayln "])") 
    | exp(A.LocalIntfHeader(name,inherit), d) = (indent d; 
			say "LocalInterfaceHeader("; say (Symbol.name name);
			say ",["; dolist d exp inherit; sayln "])") 
    | exp(A.ModuleExp(s,p),d) = ( moduleName := (Symbol.name s);
				  dolist (d+2) exp p; moduleName := "" )
    | exp(A.ValueExp(s,p),d) = (indent d; say "ValueExp(";
				 say(s); say ")")
    | exp(A.OpExp(ret_type,name, args), d) = (

			(*gen sig for stubs*)

			say "\t\t val CORBin_";
			if ((!moduleName) = "") then say ""
			else (say (!moduleName); say "_");
			say (!interfaceName);
			say "_";
			say (Symbol.name name); say " : ";
			say "caddr ";	
			doComma := false;
			dolist (d+2) exp args;
			say " -> ";
			ty(ret_type, 0); 
			sayln "";

			(*gen sig for skeletons*)			

			say "\t\t val CORBin_";
			if ((!moduleName) = "") then say ""
			else (say (!moduleName); say "_");
			say (!interfaceName);
			say "_";
			say (Symbol.name name); 
			say "_SetMLFn";
			say " : ";
			say "(cdata list -> cdata)";
			say " -> ";
			say " unit ";
			sayln "") 
    | exp(A.ParamExp(a,t,declarator), d) = (
			say " * ";
			ty(t,0) )
    | exp(A.ScopedName(n), d) = (indent d; 
			if ((!scoped_type) = true) then
			   say "caddr "
			else 
			   sayln (Symbol.name n);
			say "") 
    | exp(A.TypeDefDcl(n), d) = (indent d; 
			sayln "TypeDefDcl:"; 
			exp(n,d+2);
			sayln "") 
    | exp(A.TypeDeclarator(t,dl), d) = (indent d; 
			sayln "TypeDeclarator:"; 
			indent (d+1); say "Type: "; ty(t,d+2);
			dolist (d+1) dec dl;
			sayln "") 
    | exp(A.ForAbsInterface(n), d) = (indent d; 
			say "Forward Abstract Interface: ";  
			sayln (Symbol.name n))
    | exp(A.ForLocalInterface(n), d) = (indent d; 
			say "Forward Local Interface: ";  
			sayln (Symbol.name n))
    | exp(A.ForInterface(n), d) = (indent d; 
			say "Forward Interface: ";  
			sayln (Symbol.name n))
    | exp(A.ConstDcl(t,i,e), d) = (indent d; 
			say "Constant: ";  
			sayln (Symbol.name i);
			indent (d+1); say "Type: ";
			ty(t,d+1); say "  Value: ";
			exp(e,d+1); sayln "")
    | exp(A.ExceptDcl(i, l), d) = (indent d; 
			say "Exception: ";  
			sayln (Symbol.name i);
			indent (d+1);
			say "Member(s): "; dolist (d+2) exp l )
    | exp(A.Member(t,dl), d) = (indent d;
			say "Member: "; say "(type): ";
			ty(t,d+1); dolist (d+1) dec dl) 
    | exp(A.ReadOnlyAttribute(t,dl), d) = ((*indent d;
			say "ReadOnlyAttribute: "; say "(type): ";
			ty(t,d+1); dolist (d+1) dec dl*)) 
    | exp(A.Attribute(t,dl), d) = ((*indent d;
			say "Attribute: "; say "(type): ";
			ty(t,d+1); dolist (d+1) dec dl*)) 


  and file(A.Spec s, d) = (dolist d exp s)

  and ty(A.VoidType, d) = (say "unit " )
    | ty(A.NilType, d)  = ()
    | ty(A.StringType s, d) = (say "string ") 
    | ty(A.WStringType s, d) = (say "string ") 
    | ty(A.CharType, d)  = (say "char ")
    | ty(A.WCharType, d)  = (say "char " )
    | ty(A.BooleanType, d)  = (say "boolean " )
    | ty(A.OctetType, d)  = (say "octet " )
    | ty(A.AnyType, d)  = (say "any " )
    | ty(A.ObjectType, d)  = (say "caddr " )
    | ty(A.LongType, d)  = (say "Word32.word " )
    | ty(A.LongLongType, d)  = (say "long long " )
    | ty(A.UnsignedShortIntType, d)  = (say "unsigned short " )
    | ty(A.UnsignedLongIntType, d)  = (say "Word32.word " )
    | ty(A.UnsignedLongLongIntType, d)  = (say "unsigned long long " )
    | ty(A.ShortIntType, d)  = (say "Word32.word " )
    | ty(A.LongIntType, d)  = (say "Word32.word " )
    | ty(A.LongLongIntType, d)  = (say "long long " )
    | ty(A.FloatType, d)  = (say "real " )
    | ty(A.DoubleType, d)  = (say "real " )
    | ty(A.LongDoubleType, d)  = (say "long double " )
    | ty(A.ValueBaseType, d)  = (say "valuebase " )
    | ty(A.FixedPtType, d)  = (say "fixed " )
    | ty(A.UnionType, d)  = (say "union " )
    | ty(A.StructType, d)  = (say "struct " )
    | ty(A.ScopedType u, d)  = (scoped_type := true;
				exp(u,d+1);
				scoped_type := false )
	
  and attrib(A.InAttrib, d) = (indent d; say "in")
    | attrib(A.OutAttrib, d) = (indent d; say "out")
    | attrib(A.InOutAttrib, d) = (indent d; say "inout")

  and dec(A.SimpleDec s, d) = (say (Symbol.name s); say "")
    | dec(A.ArrayDec  a, d) = (say (Symbol.name a))

 in  file(a0,0); sayln ""; TextIO.flushOut outstream
end

(********GENSML: code to generate cutil.sml *****************)

fun gen_smlFromAST(outstream, a0) =
 let fun say s  = TextIO.output(outstream, s)
     fun sayln s = (say s; say "\n")

  fun indent 0 = ()
    | indent i = (say " "; indent(i-1))


  fun dolist d f [a] = (f(a,d+1))
    | dolist d f (a::r) = (f(a,d+1); say ""; dolist d f r)
    | dolist d f nil = ()


  fun doSkellist d f [a] = (f(a,d+1))
    | doSkellist d f (a::r) = (f(a,d+1); doComma := true;
					say ""; doSkellist d f r)
    | doSkellist d f nil = ()


  fun var(A.SimpleVar(s,p),d) = (indent d; say "SimpleVar("; 
			         say(s); say ")")
  and exp(A.VarExp v, d) = (indent d; sayln "VarExp("; var(v,d+1); say ")")
    | exp(A.NilExp, d) = ()
    | exp(A.InterfaceDcl(head,body), d) = (
			(*Get Interface Name*)
			exp(head,d+1);

			doCtype := true;
			say "\tval CORBin_";
			if ((!moduleName) = "") then say ""
			else (say (!moduleName); say "_");
			say (!interfaceName); say "_";
			say "create"; sayln "' = ";
			say "\t\tregisterAutoFreeCFn(\"";
			say "CORBin_";
			if ((!moduleName) = "") then say ""
			else (say (!moduleName); say "_");
			say (!interfaceName); say "_";
			say "create"; say "\", [CaddrT";
			say "], ";
			say "CaddrT";
			sayln ")";
			doCtype := false;


			say "\tfun CORBin_";
			if ((!moduleName) = "") then say ""
			else (say (!moduleName); say "_");
			say (!interfaceName); say "_";
			say "create"; 
			say " (poa";	
			sayln ") = ";
			say "\t\tlet val ";
			say " Caddr ";
			say "an_obj";
			say " = ";	
			say "CORBin_";
			if ((!moduleName) = "") then say ""
			else (say (!moduleName); say "_");
			say (!interfaceName); say "_";
			say "create"; say "' "; 
			say "[Caddr poa";
			say "] in ";
			say " an_obj ";
			sayln " end ";	
			voidReturn := false;
			sayln "";


			(*Loop over Interface Body*)
			dolist (d+1) exp body) 
    | exp(A.EmptyInterfaceDcl(head), d) = ()
    | exp(A.IntfHeader(name,inherit), d) = (
			(*Set interfaceName *)
			interfaceName := Symbol.name name ) 
    | exp(A.AbsIntfHeader(name,inherit), d) = (indent d; 
			say "AbstractInterfaceHeader("; say (Symbol.name name);
			say ",["; dolist d exp inherit; sayln "])") 
    | exp(A.LocalIntfHeader(name,inherit), d) = (indent d; 
			say "LocalInterfaceHeader("; say (Symbol.name name);
			say ",["; dolist d exp inherit; sayln "])") 
    | exp(A.ModuleExp(s,p),d) = ( moduleName := (Symbol.name s);
				  dolist (d+2) exp p; moduleName := "" )
    | exp(A.ValueExp(s,p),d) = (indent d; say "ValueExp(";
				 say(s); say ")")
    | exp(A.OpExp(ret_type,name, args), d) = (

			(* stub generation *)

			doCtype := true;
			say "\tval CORBin_";
			if ((!moduleName) = "") then say ""
			else (say (!moduleName); say "_");
			say (!interfaceName); say "_";
			say (Symbol.name name); sayln "' = ";
			say "\t\tregisterAutoFreeCFn(\"";
			say "CORBin_";
			if ((!moduleName) = "") then say ""
			else (say (!moduleName); say "_");
			say (!interfaceName); say "_";
			say (Symbol.name name); say "\", [CaddrT";
			doComma := true;
			dolist (0) exp args;
			doComma := false;
			say "], ";
			ty(ret_type, 0); 
			sayln ")";
			doCtype := false;

			say "\tfun CORBin_";
			if ((!moduleName) = "") then say ""
			else (say (!moduleName); say "_");
			say (!interfaceName); say "_";
			say (Symbol.name name); 
			say " (CORBin_this_obj_ref";	
			passParam := true;
			doComma   := true;
			dolist (0) exp args;
			doComma   := false;
			passParam := false;
			sayln ") = ";
			say "\t\tlet val ";
			ty(ret_type, 0); 
			if(!voidReturn = true) then say ""
			else say "my_return_value";
			say " = ";	
			say "CORBin_";
			if ((!moduleName) = "") then say ""
			else (say (!moduleName); say "_");
			say (!interfaceName); say "_";
			say (Symbol.name name); say "' "; 
			say "[Caddr CORBin_this_obj_ref";
			doComma   := true;
			dolist (0) exp args;
			doComma   := false;
			say "] in ";
			if(!voidReturn = true) then say " () "
			else say " my_return_value ";
			sayln " end ";	
			sayln "";


			(*Skeleton generation*)

			doCtype := true;
			say "\tval CORBin_";
			if ((!moduleName) = "") then say ""
			else (say (!moduleName); say "_");
			say (!interfaceName); say "_";
			say (Symbol.name name); 
			say "_SetMLFn";
			sayln "' = ";
			say "\t\tregisterAutoFreeCFn(\"";
			say "CORBin_";
			if ((!moduleName) = "") then say ""
			else (say (!moduleName); say "_");
			say (!interfaceName); say "_";
			say (Symbol.name name); 
			say "_SetMLFn";
			say "\", [CfunctionT([";
			doSkellist (0) exp args;
			doComma := false;
			say "], ";
			if(!voidReturn = true) then say " CintT "
			else ty(ret_type, 0); 
			say ")],";
			sayln "CvoidT)";
			doCtype := false;


			say "\tfun CORBin_";
			if ((!moduleName) = "") then say ""
			else (say (!moduleName); say "_");
			say (!interfaceName); say "_";
			say (Symbol.name name); 
			say "_SetMLFn";
			sayln " f = ";
			say "\t\tlet val ";
			say " Cvoid ";
			say " = ";	
			say "CORBin_";
			if ((!moduleName) = "") then say ""
			else (say (!moduleName); say "_");
			say (!interfaceName); say "_";
			say (Symbol.name name); 
			say "_SetMLFn"; say "' "; 
			say "[Cfunction f";
			say "] in ";
			say " () ";
			sayln " end ";	
			voidReturn := false;
			sayln "")

    | exp(A.ParamExp(a,t,declarator), d) = (
			if(!doComma = true) then say ","
			else say "";
			if (!doCtype = true) then ty(t,0)
			else (
			   if(!passParam = true) then (dec(declarator,0))
			   else (ty(t,0); dec(declarator,0))   )  )
    | exp(A.ScopedName(n), d) = (indent d; 
			if ((!scoped_type) = true) then
			   if(!doCtype = true) then 
				say "CaddrT"
			   else 
				say "Caddr "
			else 
			   sayln (Symbol.name n);
			say "") 
    | exp(A.TypeDefDcl(n), d) = (indent d; 
			sayln "TypeDefDcl:"; 
			exp(n,d+2);
			sayln "") 
    | exp(A.TypeDeclarator(t,dl), d) = (indent d; 
			sayln "TypeDeclarator:"; 
			indent (d+1); say "Type: "; ty(t,d+2);
			dolist (d+1) dec dl;
			sayln "") 
    | exp(A.ForAbsInterface(n), d) = (indent d; 
			say "Forward Abstract Interface: ";  
			sayln (Symbol.name n))
    | exp(A.ForLocalInterface(n), d) = (indent d; 
			say "Forward Local Interface: ";  
			sayln (Symbol.name n))
    | exp(A.ForInterface(n), d) = (indent d; 
			say "Forward Interface: ";  
			sayln (Symbol.name n))
    | exp(A.ConstDcl(t,i,e), d) = (indent d; 
			say "Constant: ";  
			sayln (Symbol.name i);
			indent (d+1); say "Type: ";
			ty(t,d+1); say "  Value: ";
			exp(e,d+1); sayln "")
    | exp(A.ExceptDcl(i, l), d) = (indent d; 
			say "Exception: ";  
			sayln (Symbol.name i);
			indent (d+1);
			say "Member(s): "; dolist (d+2) exp l )
    | exp(A.Member(t,dl), d) = (indent d;
			say "Member: "; say "(type): ";
			ty(t,d+1); dolist (d+1) dec dl) 
    | exp(A.ReadOnlyAttribute(t,dl), d) = ((*indent d;
			say "ReadOnlyAttribute: "; say "(type): ";
			ty(t,d+1); dolist (d+1) dec dl*)) 
    | exp(A.Attribute(t,dl), d) = ((*indent d;
			say "Attribute: "; say "(type): ";
			ty(t,d+1); dolist (d+1) dec dl*)) 


  and file(A.Spec s, d) = (dolist d exp s)

  and ty(A.VoidType, d) = (if(!doCtype= true) then say "CvoidT" else say "Cvoid ";
				voidReturn := true )
    | ty(A.NilType, d)  = ()
    | ty(A.StringType s, d) = (if(!doCtype= true) then say "CstringT" else say "Cstring " ) 
    | ty(A.WStringType s, d) = (if(!doCtype= true) then say "CstringT" else say "Cstring " ) 
    | ty(A.CharType, d)  = (if(!doCtype= true) then say "CcharT" else say "Cchar " )
    | ty(A.WCharType, d)  = (if(!doCtype= true) then say "CcharT" else say "Cchar " )
    | ty(A.BooleanType, d)  = (say "boolean " )
    | ty(A.OctetType, d)  = (say "octet " )
    | ty(A.AnyType, d)  = (say "any " )
    | ty(A.ObjectType, d)  = (if(!doCtype= true) then say "CaddrT" else say "Caddr " )
    | ty(A.LongType, d)  = (if(!doCtype= true) then say "ClongT" else say "Clong " )
    | ty(A.LongLongType, d)  = (say "long long " )
    | ty(A.UnsignedShortIntType, d)  = (if(!doCtype= true) then say "CshortT" else say "Cshort " )
    | ty(A.UnsignedLongIntType, d)  = (if(!doCtype= true) then say "ClongT" else say "Clong " )
    | ty(A.UnsignedLongLongIntType, d)  = (say "unsigned long long " )
    | ty(A.ShortIntType, d)  = (if(!doCtype= true) then say "CshortT" else say "Cshort " )
    | ty(A.LongIntType, d)  = (if(!doCtype= true) then say "ClongT" else say "Clong " )
    | ty(A.LongLongIntType, d)  = (say "long long " )
    | ty(A.FloatType, d)  = (if(!doCtype= true) then say "CfloatT" else say "Cfloat " )
    | ty(A.DoubleType, d)  = (if(!doCtype= true) then say "CdoubleT" else say "Cdouble " )
    | ty(A.LongDoubleType, d)  = (say "long double " )
    | ty(A.ValueBaseType, d)  = (say "valuebase " )
    | ty(A.FixedPtType, d)  = (say "fixed " )
    | ty(A.UnionType, d)  = (say "union " )
    | ty(A.StructType, d)  = (say "struct " )
    | ty(A.ScopedType u, d)  = (scoped_type := true;
				exp(u,d+1);
				scoped_type := false )
	
  and attrib(A.InAttrib, d) = (indent d; say "in")
    | attrib(A.OutAttrib, d) = (indent d; say "out")
    | attrib(A.InOutAttrib, d) = (indent d; say "inout")

  and dec(A.SimpleDec s, d) = (say (Symbol.name s); say "")
    | dec(A.ArrayDec  a, d) = (say (Symbol.name a))

 in  file(a0,0); sayln ""; TextIO.flushOut outstream
end

fun makeLoadFile(out) =
	let fun say s   =  TextIO.output(out,s)
            fun sayln s = (say s; say "\n") 
	in
		sayln "(*   loadInterface.sml";	
		sayln " *   ";	
		sayln " *   The SMLNJ-C Interface is COPYRIGHT (c) 1996 Bell Laboratories, Lucent Technologies";	
		sayln " *   This file constructs an SML/NJ C Interface for functions that were generated via corbin-idl.";
		sayln " *) ";
		sayln "";
		sayln "val _ = print \"loading information about C types...\\n\";";
		say "app use [\"";
		say (!ml_c_dir);
		sayln "/cc-info.sig.sml\",";
		say "\t\"";
		say (!ml_c_dir);
		sayln "/cc-info.defaults.sml\",";
		say "\t\"";
		say (!ml_c_dir);
		sayln "/cc-info.gcc-x86-linux.sml\",";
		say "\t\"";
		say (!ml_c_dir);
		sayln "/cc-info.gcc-sparc-sunos.sml\"];";
		sayln "\n\n";

		sayln "val _ = print \"loading C interface...\\n\";";
		say "app use [\"";
		say (!ml_c_dir);
		sayln "/c-calls.sig.sml\",";
		say "\t\"";
		say (!ml_c_dir);
		sayln "/c-calls.sml\",";
		say "\t\"";
		sayln "cutil.sig.sml\",";
		say "\t\"";
		sayln "cutil.sml\"];";
		sayln "\n\n";

		if(CORBinLib.getCorbinOS() = "linux") then
		 if(CORBinLib.getCorbinARCH() = "x86") then (
		   sayln ("val _ = print \"instantiating CCalls for GCC on X86Linux...\\n\";");
		   sayln ("structure CI = CCalls(structure CCInfo = GCCInfoX86Linux);");
		   sayln ("\n\n"))
		 else say ""
		else say "";

		if(CORBinLib.getCorbinOS() = "solaris") then
		 if(CORBinLib.getCorbinARCH() = "sparc") then (
		   sayln ("val _ = print \"instantiating CCalls for GCC on Sparc Solaris...\\n\";");
		   sayln ("structure CI = CCalls(structure CCInfo = GCCInfoSparcSunOS);");
		   sayln ("\n\n"))
		 else say ""
		else say "";

		sayln "val _ = print \"instantiating CUtil...\\n\";";
		sayln "structure CU = CUtil(structure C = CI);";
		sayln "\n\n";
		sayln "";
		TextIO.flushOut out
	end

fun genCutilSigHeader(out) =
	let fun say s   =  TextIO.output(out,s)
            fun sayln s = (say s; say "\n") 
	in
		sayln "(* cutil.sig.sml";	
		sayln " * ";	
		sayln " * The SMLNJ-C Interface is COPYRIGHT (c) 1996 Bell Laboratories, Lucent Technologies";	
		sayln " *)";
		sayln "";
		sayln "signature C_UTIL = ";
		sayln "\tsig";
		sayln "\t\t type caddr";
		sayln "\t\t type cdata";
		sayln "(**Main CORBin-lib routines**)";
		sayln "\t\t val CORBin_exception_init : unit -> unit"; 
		sayln "\t\t val CORBin_orb_init : string -> unit"; 
		sayln "\t\t val CORBin_string_to_object : string -> caddr"; 
		sayln "\t\t val CORBin_Object_release : caddr -> unit"; 
		sayln "\t\t val CORBin_Object_duplicate : caddr -> caddr"; 
		sayln "\t\t val CORBin_ORB_run : unit -> unit"; 
		sayln "\t\t val CORBin_ORB_resolve_initial_references : string -> caddr"; 
		sayln "\t\t val CORBin_PortableServer_POAManager_activate : caddr  -> unit"; 
		sayln "\t\t val CORBin_PortableServer_POA__get_the_POAManager : caddr  -> caddr"; 
		sayln "\t\t val CORBin_create_name : string  -> caddr"; 
		sayln "\t\t val CORBin_CosNaming_NamingContext_resolve : caddr * caddr  -> caddr"; 
		sayln "\t\t val CORBin_CosNaming_NamingContext_bind : caddr * caddr * caddr  -> unit"; 
		sayln "(**Routines generated by corbin-idl **)"

	end 

fun genCutilSmlHeader(out) =
	let fun say s   =  TextIO.output(out,s)
            fun sayln s = (say s; say "\n") 
	in
		sayln "(* cutil.sml";	
		sayln " * ";	
		sayln " * The SMLNJ-C Interface is COPYRIGHT (c) 1996 Bell Laboratories, Lucent Technologies";	
		sayln " *)";
		sayln "";
		sayln "functor CUtil (structure C: C_CALLS) : C_UTIL = ";
		sayln "\t struct ";
		sayln "\t\t open C";
		sayln "";
		sayln "(****Main CORBin-lib Routines****)";
		sayln "\t val CORBin_exception_init' = ";
		say "\t\t registerAutoFreeCFn(\"CORBin_exception_init\",";
		sayln "[], CvoidT)";
		sayln "\t fun CORBin_exception_init () = ";
		sayln "\t\t let val Cvoid  = CORBin_exception_init' [] in () end";
		sayln "\t val CORBin_orb_init' = ";
		say "\t\t registerAutoFreeCFn(\"CORBin_orb_init\",";
		sayln "[CstringT], CvoidT)";
		sayln "\t fun CORBin_orb_init p = ";
		sayln "\t\t let val Cvoid  = CORBin_orb_init' [Cstring p] in () end";

		sayln "\t val CORBin_string_to_object' = ";
		say "\t\t registerAutoFreeCFn(\"CORBin_string_to_object\",";
		sayln "[CstringT], CaddrT)";	
		sayln "\t fun CORBin_string_to_object p = ";
		sayln "\t\t let val Caddr s = CORBin_string_to_object' [Cstring p] in s end";

		sayln "\t val CORBin_Object_release' = ";
		say "\t\t registerAutoFreeCFn(\"CORBin_Object_release\",";
		sayln "[CaddrT], CvoidT)";
		sayln "\t fun CORBin_Object_release p = ";
		sayln "\t\t let val Cvoid = CORBin_Object_release' [Caddr p] in () end";
		sayln "\t val CORBin_Object_duplicate' = ";
		say "\t\t registerAutoFreeCFn(\"CORBin_Object_duplicate\",";
		sayln "[CaddrT], CaddrT)";
		sayln "\t fun CORBin_Object_duplicate p = ";
		sayln "\t\t let val Caddr s = CORBin_Object_duplicate' [Caddr p] in s end";

		sayln "\t val CORBin_ORB_run' = ";
		say "\t\t registerAutoFreeCFn(\"CORBin_ORB_run\",";
		sayln "[], CvoidT)";
		sayln "\t fun CORBin_ORB_run () = ";
		sayln "\t\t let val Cvoid  = CORBin_ORB_run' [] in () end";

		sayln "\t val CORBin_ORB_resolve_initial_references' = ";
		say "\t\t registerAutoFreeCFn(\"CORBin_ORB_resolve_initial_references\",";
		sayln "[CstringT], CaddrT)";
		sayln "\t fun CORBin_ORB_resolve_initial_references p = ";
		sayln "\t\t let val Caddr s  = CORBin_ORB_resolve_initial_references' [Cstring p] in s end";


		sayln "\t val CORBin_PortableServer_POAManager_activate' = ";
		say "\t\t registerAutoFreeCFn(\"CORBin_PortableServer_POAManager_activate\",";
		sayln "[CaddrT], CvoidT)";
		sayln "\t fun CORBin_PortableServer_POAManager_activate p = ";
		sayln "\t\t let val Cvoid  = CORBin_PortableServer_POAManager_activate' [Caddr p] in () end";


		sayln "\t val CORBin_PortableServer_POA__get_the_POAManager' = ";
		say "\t\t registerAutoFreeCFn(\"CORBin_PortableServer_POA__get_the_POAManager\",";
		sayln "[CaddrT], CaddrT)";
		sayln "\t fun CORBin_PortableServer_POA__get_the_POAManager p = ";
		sayln "\t\t let val Caddr s  = CORBin_PortableServer_POA__get_the_POAManager' [Caddr p] in s  end";


		sayln "\t val CORBin_create_name' = ";
		say "\t\t registerAutoFreeCFn(\"CORBin_create_name\",";
		sayln "[CstringT], CaddrT)";
		sayln "\t fun CORBin_create_name p = ";
		sayln "\t\t let val Caddr s  = CORBin_create_name' [Cstring p] in s  end";

		sayln "\t val CORBin_CosNaming_NamingContext_resolve' = ";
		say "\t\t registerAutoFreeCFn(\"CORBin_CosNaming_NamingContext_resolve\",";
		sayln "[CaddrT,CaddrT], CaddrT)";
		sayln "\t fun CORBin_CosNaming_NamingContext_resolve (n,obj) = ";
		sayln "\t\t let val Caddr s  = CORBin_CosNaming_NamingContext_resolve' [Caddr n, Caddr obj] in s  end";

		sayln "\t val CORBin_CosNaming_NamingContext_bind' = ";
		say "\t\t registerAutoFreeCFn(\"CORBin_CosNaming_NamingContext_bind\",";
		sayln "[CaddrT,CaddrT,CaddrT], CvoidT)";
		sayln "\t fun CORBin_CosNaming_NamingContext_bind (ns,n,obj) = ";
		sayln "\t\t let val Cvoid  = CORBin_CosNaming_NamingContext_bind' [Caddr ns, Caddr n, Caddr obj] in () end";


		sayln "(****routines generated by corbin-idl****)";
		sayln ""


	end 


fun endCutilSml(out) =
	let fun say s   =  TextIO.output(out,s)
            fun sayln s = (say s; say "\n") 
	in
		sayln "";	
		sayln "end (*end of cutil.sml*)";	
		TextIO.flushOut out
	end 


fun endCutilSig(out) =
	let fun say s   =  TextIO.output(out,s)
            fun sayln s = (say s; say "\n") 
	in
		sayln "";	
		sayln "end (*end of cutil.sig.sml*)";	
		TextIO.flushOut out
	end 

fun gen_sml (tree) =  (
		ml_c_dir := (CORBinLib.getSMLNJ_CDir());
		TextIO.output(TextIO.stdOut, "Generating ML code to activate the ML/C foreign function interface...\n");
		let val out = TextIO.openOut("loadInterface.sml") 
		    val   _ = makeLoadFile(out)	
		    val out2 = TextIO.openOut("cutil.sml") 
		    val out3 = TextIO.openOut("cutil.sig.sml") 
		    val   _ = genCutilSmlHeader(out2)
		    val   _ = genCutilSigHeader(out3)
		    val   _ = gen_sigFromAST(out3, tree)
		    val   _ = gen_smlFromAST(out2, tree)
		    val   _ = endCutilSml(out2)
		    val   _ = endCutilSig(out3)
		in 
		    TextIO.closeOut out;
		    TextIO.closeOut out2;
		    TextIO.closeOut out3
		end handle IO.Io i => CORBinLib.fileError(CORBinLib.getWrapperName())
)


end
