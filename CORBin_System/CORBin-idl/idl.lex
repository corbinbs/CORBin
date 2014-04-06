(****************************************************************)
(* idl.lex:  ML-Lex file for CORBin-idl 			*)
(* Author:   Brian S. Corbin					*)
(* Created:  Sat Jan 13 23:05:06 EST 2001 			*)
(* Modified: Wed Jan 17 15:00:48 EST 2001 			*)
(****************************************************************)

(* ML Declarations *)

structure Tokens = Tokens

type pos = int
type svalue = Tokens.svalue
type ('a,'b) token = ('a,'b) Tokens.token
type lexresult = (svalue, pos) token 

open Tokens

val lineNum = ErrorMsg.lineNum 
val linePos = ErrorMsg.linePos 

fun eof() = Tokens.EOF(!lineNum,!lineNum)

structure KeyWord : sig 
			val find : string -> 
				 (int * int -> (svalue, int) token) option
		    end =
  struct 

	val TableSize = 211 
	val HashFactor = 5

	val hash = fn s => 
	    foldl (fn (c,v)=>(v*HashFactor+(ord c)) mod TableSize) 0 (explode s)	

	val HashTable = Array.array(TableSize, nil) :
		(string * (int * int -> (svalue, int) token)) list Array.array

	val add = fn (s, v) =>
	  let val i = hash s
	  in Array.update(HashTable,i,(s,v) :: (Array.sub(HashTable, i)))
	  end

	val find = fn s =>
	  let val i = hash s 
	      fun f ((key,v)::r) = if s=key then SOME v else f r
		| f nil = NONE
	  in f (Array.sub(HashTable, i))
	  end 

(* IDL Keywords from CORBA Ver. 2.4 IDL Syntax & Semantics Documentation *)

	val _ = 
	    (List.app add
	[("abstract", YABSTRACT),
	 ("any", YANY),
	 ("attribute", YATTRIBUTE),
	 ("boolean", YBOOLEAN),
	 ("case", YCASE),
	 ("char", YCHAR),
	 ("const", YCONST),
	 ("context", YCONTEXT),
	 ("custom", YCUSTOM),
	 ("default", YDEFAULT),
	 ("double", YDOUBLE),
	 ("exception", YEXCEPTION),
	 ("enum", YENUM),
	 ("factory", YFACTORY),
	 ("FALSE", YFALSE),
	 ("fixed", YFIXED),
	 ("float", YFLOAT),
	 ("in", YIN),
	 ("inout", YINOUT),
	 ("interface", YINTERFACE),
	 ("local", YLOCAL),
	 ("long", YLONG),
	 ("module", YMODULE),
	 ("native", YNATIVE),
	 ("Object", YOBJECT),
	 ("octet", YOCTET),
	 ("oneway", YONEWAY),
	 ("out", YOUT),
	 ("private", YPRIVATE),
	 ("public", YPUBLIC),
	 ("raises", YRAISES),
	 ("readonly", YREADONLY),
	 ("sequence", YSEQUENCE),
	 ("short", YSHORT),
	 ("string", YSTRING),
	 ("struct", YSTRUCT),
	 ("supports", YSUPPORTS),
	 ("switch", YSWITCH),
	 ("TRUE", YTRUE),
	 ("truncatable", YTRUNCATABLE),
	 ("typedef", YTYPEDEF),
	 ("unsigned", YUNSIGNED),
	 ("union", YUNION),
	 ("ValueBase", YVALUEBASE),
	 ("valuetype", YVALUETYPE),
	 ("void", YVOID),
	 ("wchar", YWCHAR),
	 ("wstring", YWSTRING)
	])	

   end 
   open KeyWord

%%

%header (functor IdlLexFun(structure Tokens: Idl_TOKENS));
%s C_COMMENT CXX_COMMENT;
alpha=[A-Za-z];
digit=[0-9];
nonzerodigit=[1-9];
zerodigit=[0];
octdigit=[0-7];
hexdigit=[0-9A-Fa-f];
integer={digit}+;
ws=[\ \t];
underscore=[_];

%%

<INITIAL>{ws}+	=>  (lex());

<INITIAL>\n+	=>  ( lineNum := !lineNum+(String.size yytext); linePos := yypos :: !linePos; lex());
<INITIAL>\013+	=>  ( lineNum := !lineNum+(String.size yytext); linePos := yypos :: !linePos; lex());
<INITIAL>{alpha}+ => (case find yytext of SOME v => v(yypos, yypos+String.size yytext)
					 | _ => YID(yytext,!lineNum, !lineNum));
<INITIAL>{alpha}({alpha}|{underscore}|{digit})* => (Tokens.YID(yytext,!lineNum,!lineNum));
<INITIAL>{nonzerodigit}{digit}*  => (Tokens.YINTEGER(Int.fromString (yytext),!lineNum, !lineNum)); 
<INITIAL>{zerodigit}{octdigit}* => (Tokens.YOCTINTEGER(!lineNum, !lineNum));
<INITIAL>("0x" | "0X") {hexdigit}+ => (Tokens.YHEXINTEGER(!lineNum, !lineNum));
<INITIAL>{digit}+"."{digit}*	=> (Tokens.YFLOATLITERAL(!lineNum, !lineNum));
<INITIAL>{digit}*"."{digit}+	=> (Tokens.YFLOATLITERAL(!lineNum, !lineNum));
<INITIAL>{digit}+("e" | "E")("-")?{digit}+	=> 
				   (Tokens.YFLOATLITERAL(!lineNum, !lineNum));
<INITIAL>({digit}+("d"|"D")) | ("."{digit}+("d"|"D"))	=> 
				   (Tokens.YFIXEDPTLITERAL(!lineNum, !lineNum));
<INITIAL>({digit}+"."{digit}+("d"|"D"))	=> 
				   (Tokens.YFIXEDPTLITERAL(!lineNum, !lineNum));
<INITIAL>"L'" ({alpha} | {digit} | . ) "'" => 
				(Tokens.YWCHARLITERAL(!lineNum,!lineNum));
<INITIAL>"'" ({alpha} | {digit} | . ) "'" => 
				(Tokens.YCHARLITERAL(!lineNum,!lineNum));
<INITIAL>"L\"" ({alpha} | {digit} | . ) "\"" => 
				(Tokens.YWSTRINGLITERAL(!lineNum,!lineNum));
<INITIAL>"\"" ({alpha} | {digit} | . ) "\"" => 
				(Tokens.YSTRINGLITERAL(!lineNum,!lineNum));

<INITIAL>"/*"	=>  (YYBEGIN C_COMMENT; lex()); 
<INITIAL>"//"	=>  (YYBEGIN CXX_COMMENT; lex()); 
<INITIAL>";"	=>  (Tokens.YSEMI(!lineNum,!lineNum));
<INITIAL>"."	=>  (Tokens.YDOT(!lineNum,!lineNum));
<INITIAL>","	=>  (Tokens.YCOMMA(!lineNum,!lineNum));
<INITIAL>"::"	=>  (Tokens.YCOLONCOLON(!lineNum,!lineNum));
<INITIAL>":"	=>  (Tokens.YCOLON(!lineNum,!lineNum));
<INITIAL>"("	=>  (Tokens.YLEFTPAREN(!lineNum,!lineNum));
<INITIAL>")"	=>  (Tokens.YRIGHTPAREN(!lineNum,!lineNum));
<INITIAL>"{"	=>  (Tokens.YLEFTBRACE(!lineNum,!lineNum));
<INITIAL>"}"	=>  (Tokens.YRIGHTBRACE(!lineNum,!lineNum));
<INITIAL>"<<"	=>  (Tokens.YDBLLEFTANGLE(!lineNum,!lineNum));
<INITIAL>"<"	=>  (Tokens.YLEFTANGLE(!lineNum,!lineNum));
<INITIAL>">>"	=>  (Tokens.YDBLRIGHTANGLE(!lineNum,!lineNum));
<INITIAL>">"	=>  (Tokens.YRIGHTANGLE(!lineNum,!lineNum));
<INITIAL>"="	=>  (Tokens.YEQUALS(!lineNum,!lineNum));
<INITIAL>"|"	=>  (Tokens.YVBAR(!lineNum,!lineNum));
<INITIAL>"-"	=>  (Tokens.YMINUS(!lineNum,!lineNum));
<INITIAL>"+"	=>  (Tokens.YPLUS(!lineNum,!lineNum));
<INITIAL>"~"	=>  (Tokens.YTILDE(!lineNum,!lineNum));
<INITIAL>"%"	=>  (Tokens.YMOD(!lineNum,!lineNum));
<INITIAL>"&"	=>  (Tokens.YAND(!lineNum,!lineNum));
<INITIAL>"^"	=>  (Tokens.YCARAT(!lineNum,!lineNum));
<INITIAL>"*"	=>  (Tokens.YASTERISK(!lineNum,!lineNum));
<INITIAL>"/"	=>  (Tokens.YFWDSLASH(!lineNum,!lineNum));
<INITIAL>"["	=>  (Tokens.YLEFTBRACKET(!lineNum,!lineNum));
<INITIAL>"]"	=>  (Tokens.YRIGHTBRACKET(!lineNum,!lineNum));
<INITIAL>.	=>  (ErrorMsg.error (!lineNum) ("illegal character " ^ yytext);
	     lex());

<C_COMMENT>"*/"	=>  (YYBEGIN INITIAL; lex());
<C_COMMENT>[^\n] =>  (lex());
<C_COMMENT>\n+	=>  (lineNum := !lineNum+(String.size yytext); linePos := yypos :: !linePos; lex());
<C_COMMENT>\013+ =>  (lineNum := !lineNum+(String.size yytext); linePos := yypos :: !linePos; lex());

<CXX_COMMENT>[^\n]  =>  (lex());
<CXX_COMMENT>\n+    =>  (YYBEGIN INITIAL; 
		   lineNum := !lineNum+(String.size yytext); linePos := yypos :: !linePos; lex());
<CXX_COMMENT>\013+    =>  (YYBEGIN INITIAL; 
		   lineNum := !lineNum+(String.size yytext); linePos := yypos :: !linePos; lex());
