structure AST = 
struct

type pos = int   and   symbol = Symbol.symbol

datatype var = SimpleVar of string * pos

and file = Spec of exp list 

and exp = VarExp of var
        | NilExp
	| InterfaceDcl of exp * exp list
	| EmptyInterfaceDcl of  exp 
	| IntfHeader of symbol * exp list
	| AbsIntfHeader of symbol * exp list
	| LocalIntfHeader of symbol * exp list
	| ForAbsInterface of symbol 
	| ForLocalInterface of symbol
	| ForInterface of symbol 
	| ModuleExp of symbol * exp list 
	| ValueExp of string * pos 
	| OpExp of ty * symbol * exp list
	| ParamExp of attrib * ty * dec 
	| ScopedName of symbol
	| TypeDefDcl of exp
	| TypeDeclarator of ty * dec list
	| ConstDcl of ty * symbol * exp
	| ExceptDcl of symbol * exp list
	| Member of ty * dec list
	| ReadOnlyAttribute of ty * dec list
	| Attribute of ty * dec list

and ty  = VoidType
	| NilType
	| StringType of exp 
	| WStringType of exp 
	| CharType
	| WCharType
	| BooleanType
	| OctetType
	| AnyType
	| ObjectType
	| LongType
	| LongLongType
	| UnsignedShortIntType
	| UnsignedLongIntType
	| UnsignedLongLongIntType
	| ShortIntType
	| LongIntType
	| LongLongIntType
	| FloatType
	| DoubleType
	| LongDoubleType
	| ValueBaseType
	| FixedPtType
	| UnionType
	| StructType
	| ScopedType of exp 

and attrib = InAttrib
	   | OutAttrib
	   | InOutAttrib

and dec = SimpleDec of symbol
	| ArrayDec of symbol

end
        
