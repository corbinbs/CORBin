structure PrintAST : 
     sig val print : TextIO.outstream * AST.file -> unit 
	 val scoped_type: bool ref
     end =
struct

  structure A = AST

val scoped_type = ref false

fun print (outstream, e0) =
 let fun say s =  TextIO.output(outstream,s)
  fun sayln s= (say s; say "\n") 

  fun indent 0 = ()
    | indent i = (say " "; indent(i-1))


  fun dolist d f [a] = (sayln ""; f(a,d+1))
    | dolist d f (a::r) = (sayln ""; f(a,d+1); say ""; dolist d f r)
    | dolist d f nil = ()


  fun var(A.SimpleVar(s,p),d) = (indent d; say "SimpleVar("; 
			         say(s); say ")")
  and exp(A.VarExp v, d) = (indent d; sayln "VarExp("; var(v,d+1); say ")")
    | exp(A.NilExp, d) = (indent d; say "none")
    | exp(A.InterfaceDcl(head,body), d) = (indent d; 
			sayln "InterfaceDcl:"; 
			exp(head,d+1);
			indent d; say " body:"; dolist (d+1) exp body; say "") 
    | exp(A.EmptyInterfaceDcl(head), d) = (indent d; 
			say "EmptyInterfaceDcl("; exp(head,d);
			say ")") 
    | exp(A.IntfHeader(name,inherit), d) = (indent d; 
			say "Interface: ";  sayln (Symbol.name name); 
			indent d; 
			say "  inheritance: "; dolist (d+2) exp inherit; 
			sayln "") 
    | exp(A.AbsIntfHeader(name,inherit), d) = (indent d; 
			say "AbstractInterfaceHeader("; say (Symbol.name name);
			say ",["; dolist d exp inherit; sayln "])") 
    | exp(A.LocalIntfHeader(name,inherit), d) = (indent d; 
			say "LocalInterfaceHeader("; say (Symbol.name name);
			say ",["; dolist d exp inherit; sayln "])") 
    | exp(A.ModuleExp(s,p),d) = (indent d; say "Module: ";
				 say(Symbol.name s); 
				 dolist (d+2) exp p; 
				 sayln "")
    | exp(A.ValueExp(s,p),d) = (indent d; say "ValueExp(";
				 say(s); say ")")
    | exp(A.OpExp(ret_type,name, args), d) = (indent d; 
			say "Operation: "; sayln (Symbol.name name);
			indent d; say " Return Type: "; ty(ret_type, d);
			sayln "";  indent d; say " Parameters: ";
			dolist (d+2) exp args; say "") 
    | exp(A.ParamExp(a,t,declarator), d) = (indent d; 
			say "Name: "; dec(declarator,0); say " "; 
			say "Attribute: "; attrib(a,0); say " ";
			say "Type: "; ty(t,0); sayln "" )
    | exp(A.ScopedName(n), d) = (indent d; 
			if ((!scoped_type) = true) then 
				say (Symbol.name n)
			else 
				say (Symbol.name n);
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
    | exp(A.ReadOnlyAttribute(t,dl), d) = (indent d;
			say "ReadOnlyAttribute: "; say "(type): ";
			ty(t,d+1); dolist (d+1) dec dl) 
    | exp(A.Attribute(t,dl), d) = (indent d;
			say "Attribute: "; say "(type): ";
			ty(t,d+1); dolist (d+1) dec dl) 


  and file(A.Spec s, d) = (say "IDLSpecification "; dolist d exp s )

  and ty(A.VoidType, d) = (indent d; say "void" )
    | ty(A.NilType, d)  = (indent d; say "none" )
    | ty(A.StringType s, d) = (indent d; say "string"; say "  extra info: "; exp (s, d)) 
    | ty(A.WStringType s, d) = (indent d; say "wstring"; exp (s, d)) 
    | ty(A.CharType, d)  = (indent d; say "char" )
    | ty(A.WCharType, d)  = (indent d; say "wchar" )
    | ty(A.BooleanType, d)  = (indent d; say "boolean" )
    | ty(A.OctetType, d)  = (indent d; say "octet" )
    | ty(A.AnyType, d)  = (indent d; say "any" )
    | ty(A.ObjectType, d)  = (indent d; say "Object" )
    | ty(A.LongType, d)  = (indent d; say "long" )
    | ty(A.LongLongType, d)  = (indent d; say "long long" )
    | ty(A.UnsignedShortIntType, d)  = (indent d; say "unsigned short" )
    | ty(A.UnsignedLongIntType, d)  = (indent d; say "unsigned long" )
    | ty(A.UnsignedLongLongIntType, d)  = (indent d; say "unsigned long long" )
    | ty(A.ShortIntType, d)  = (indent d; say "short" )
    | ty(A.LongIntType, d)  = (indent d; say "long" )
    | ty(A.LongLongIntType, d)  = (indent d; say "long long" )
    | ty(A.FloatType, d)  = (indent d; say "float" )
    | ty(A.DoubleType, d)  = (indent d; say "double" )
    | ty(A.LongDoubleType, d)  = (indent d; say "long double" )
    | ty(A.ValueBaseType, d)  = (indent d; say "valuebase" )
    | ty(A.FixedPtType, d)  = (indent d; say "fixed" )
    | ty(A.UnionType, d)  = (indent d; say "union" )
    | ty(A.StructType, d)  = (indent d; say "struct" )
    | ty(A.ScopedType u, d)  = (indent d; scoped_type := true; 
					  exp(u,d+1);
					  scoped_type := false )
	
  and attrib(A.InAttrib, d) = (indent d; say "in")
    | attrib(A.OutAttrib, d) = (indent d; say "out")
    | attrib(A.InOutAttrib, d) = (indent d; say "inout")

  and dec(A.SimpleDec s, d) = ( indent d; say (Symbol.name s))
    | dec(A.ArrayDec  a, d) = ( indent d; say (Symbol.name a))

 in  file(e0,0); sayln ""; TextIO.flushOut outstream
end

end

