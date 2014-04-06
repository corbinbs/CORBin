(*********************************************************
 ** CORBin-idl.sml 					**
 ** Author: Brian S. Corbin 				**
 **							**
 ** Contains main driver code for corbin_idl            **
 ** Uses Structures provided by Ml-Lex and Ml-Yacc      **
 **							**
 *********************************************************)

structure CORBinIdlParser : 
	sig val parse : string -> AST.file 
        end =
struct 
  structure IdlLrVals = IdlLrValsFun(structure Token = LrParser.Token)
  structure IdlLex = IdlLexFun(structure Tokens = IdlLrVals.Tokens)
  structure IdlParser = Join(structure ParserData = IdlLrVals.ParserData
			structure Lex=IdlLex
			structure LrParser = LrParser)
  fun parse filename =
      let val _ = (ErrorMsg.reset(); ErrorMsg.fileName := filename)
	  val file = TextIO.openIn filename
	  fun get _ = TextIO.input file
	  fun parseerror(s,p1:int,_) = ErrorMsg.error p1 s
	  val lexer = LrParser.Stream.streamify (IdlLex.makeLexer get)
	  val (ast, _) = IdlParser.parse(0,lexer,parseerror,())
       in 
	   TextIO.closeIn file;
	   ast
      end handle LrParser.ParseError => raise ErrorMsg.Error

end

fun corbin_idl (command,[]) = ErrorMsg.usage()
  | corbin_idl (command, [file]) =
    let val working_dir = OS.FileSys.getDir()	
	val full_filename = (working_dir ^ "/" ^ file)
	val ASTree = CORBinIdlParser.parse full_filename
    in  
	(
	    CORBinLib.init(full_filename);
(*******    PrintAST.print(TextIO.stdOut, ASTree);  *********)
	    GenCWrappers.gen_wrappers(ASTree);
	    GenCCALLSMacros.gen_macros(ASTree);
	    CORBinLib.genCORBcode(full_filename);
	    GenSML_CInterface.gen_sml(ASTree);
	    CORBinLib.update();
	    CORBinLib.rebuild(); 
	    OS.Process.success
	)	
    end handle ErrorMsg.Error => ErrorMsg.bomb()
	     | IO.Io i => ErrorMsg.ioError()
	     | CORBinLib.CORBinLibError s => CORBinLib.error(s)


