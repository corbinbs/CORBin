structure GenCWrappers : 
     sig 
	 val gen_wrappers : AST.file -> unit 
         val output_cwrappers : TextIO.outstream * AST.file -> unit
	 val interfaceName : string ref
	 val moduleName : string ref
	 val voidReturn : bool ref
	 val doComma : bool ref
	 val passParam : bool ref
	 val outfileName : string ref
	 val scoped_type : bool ref
     end =
struct

  structure A = AST

  val outfileName = ref ""
  val interfaceName = ref ""
  val moduleName = ref ""
  val voidReturn = ref false
  val doComma = ref false
  val passParam = ref false
  val scoped_type = ref false


fun output_cwrappers(outstream, a0) =
 let fun say s =  TextIO.output(outstream,s)
  fun sayln s= (say s; say "\n") 

  fun indent 0 = ()
    | indent i = (say " "; indent(i-1))


  fun dolist d f [a] = (f(a,d+1))
    | dolist d f (a::r) = (f(a,d+1); say ""; dolist d f r)
    | dolist d f nil = ()


  fun doAttriblist d f [a] = (f(a,d+1))
    | doAttriblist d f (a::r) = (f(a,d+1); say ""; doAttriblist d f r)
    | doAttriblist d f nil = ()


  fun var(A.SimpleVar(s,p),d) = (indent d; say "SimpleVar("; 
			         say(s); say ")")
  and exp(A.VarExp v, d) = (indent d; sayln "VarExp("; var(v,d+1); say ")")
    | exp(A.NilExp, d) = ()
    | exp(A.InterfaceDcl(head,body), d) = (
			(*Get Interface Name*)
			exp(head,d+1);
			(*Loop over Interface Body*)
			dolist (d+1) exp body;
			(**Generate wrapper for object's create method**)

			sayln "";
			say "void * \nCORBin_";
			if ((!moduleName) = "") then say ""
			else (say (!moduleName); say "_");
			say (!interfaceName); 
			sayln "_create(PortableServer_POA poa)";
			sayln "{";	
			indent(3);
			say "return impl_";
			if ((!moduleName) = "") then say ""
			else (say (!moduleName); say "_");
			say (!interfaceName); 
			sayln "__create(poa, &ev);";
			sayln "}") 
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
				  dolist (d+2) exp p;  moduleName := "" )
    | exp(A.ValueExp(s,p),d) = (indent d; say "ValueExp(";
				 say(s); say ")")
    | exp(A.OpExp(ret_type,name, args), d) = (
			ty(ret_type, 0); 
			say "CORBin_";
			if ((!moduleName) = "") then say ""
			else (say (!moduleName); say "_");
			say (!interfaceName); say "_";
			say (Symbol.name name); say "(CORBA_Object obj";
			doComma := true;
			dolist (d+2) exp args;
			doComma := false;
			sayln ")"; 
			sayln "{";
			indent 5; 
			if (!voidReturn = false) then say "return "
			else say "";
			if ((!moduleName) = "") then say ""
			else (say (!moduleName); say "_");
			say (!interfaceName); say "_"; 
			say (Symbol.name name); say "(obj";	
			doComma := true;
			passParam := true;
			dolist (d+2) exp args;
			passParam := false;
			doComma := false;
			sayln ", &ev);";
			sayln "}"; sayln ""; voidReturn := false) 
    | exp(A.ParamExp(a,t,declarator), d) = (
			if (!doComma = true) then say ", "
			else say "";
			if (!passParam = false) then ty(t,0)
			else say "";
			dec(declarator,0))
    | exp(A.ScopedName(n), d) = (indent d; 
			if ((!scoped_type) = true) then
			   say "void * "
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
    | exp(A.ReadOnlyAttribute(t,dl), d) = ()
    | exp(A.Attribute(t,dl), d) = ()

  and file(A.Spec s, d) = (sayln "";
			   sayln ("#ifndef " ^ (!outfileName));
			   sayln ("#define " ^ (!outfileName)); 
			   sayln "";
			   sayln "#include <orb/orbit.h>";
			   sayln ("#include \"" ^ 
				  (CORBinLib.getCORBHeaderName()) ^ "\"");
			   sayln "";
			   sayln "extern CORBA_Environment ev;";
			   sayln "";

			   GenCSkelImpl.output_cskelimpl(outstream, a0);

			   (****** generate C wrappers *******)
		           dolist d exp s;

			   (* generate skeletons *)
			   GenCSkels.output_cskels(outstream, a0);
			   sayln "#endif"  )

  and ty(A.VoidType, d) = (say "void "; voidReturn := true )
    | ty(A.NilType, d)  = ()
    | ty(A.StringType s, d) = (say "char * ") 
    | ty(A.WStringType s, d) = (say "char * ") 
    | ty(A.CharType, d)  = (say "char ")
    | ty(A.WCharType, d)  = (say "char " )
    | ty(A.BooleanType, d)  = (say "boolean " )
    | ty(A.OctetType, d)  = (say "octet " )
    | ty(A.AnyType, d)  = (say "any " )
    | ty(A.ObjectType, d)  = (say "Object " )
    | ty(A.LongType, d)  = (say "long " )
    | ty(A.LongLongType, d)  = (say "long long " )
    | ty(A.UnsignedShortIntType, d)  = (say "unsigned short " )
    | ty(A.UnsignedLongIntType, d)  = (say "unsigned long " )
    | ty(A.UnsignedLongLongIntType, d)  = (say "unsigned long long " )
    | ty(A.ShortIntType, d)  = (say "short " )
    | ty(A.LongIntType, d)  = (say "long " )
    | ty(A.LongLongIntType, d)  = (say "long long " )
    | ty(A.FloatType, d)  = (say "float " )
    | ty(A.DoubleType, d)  = (say "double " )
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

fun gen_wrappers (tree) =  (
		outfileName := ("CORBIN_" ^ (CORBinLib.getFileName()) ^ "_WRAPPERS");
		TextIO.output(TextIO.stdOut, "Generating C-ORB Interface Wrapper functions...\n");
		let val out = TextIO.openOut((CORBinLib.getWrapperName())) 
		    val   _ = output_cwrappers(out,tree)
		in 
		    TextIO.closeOut out
		end handle IO.Io i => CORBinLib.fileError(CORBinLib.getWrapperName())
)


end

