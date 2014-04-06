signature ERRORMSG =
sig
    val anyErrors : bool ref
    val fileName : string ref
    val lineNum : int ref
    val linePos : int list ref
    val sourceStream : TextIO.instream ref
    val error : int -> string -> unit
    exception Error
    exception FileIO
    val impossible : string -> 'a   (* raises Error *)
    val reset : unit -> unit
    val bomb : unit -> OS.Process.status 
    val usage : unit -> OS.Process.status 
    val ioError : unit -> OS.Process.status 
end

structure ErrorMsg : ERRORMSG =
struct

  val anyErrors = ref false
  val fileName = ref ""
  val lineNum = ref 1
  val linePos = ref [1]
  val sourceStream = ref TextIO.stdIn

  fun reset() = (anyErrors:=false;
		 fileName:="";
		 lineNum:=1;
		 linePos:=[1];
		 sourceStream:=TextIO.stdIn)

  exception Error
  exception FileIO

  fun error pos (msg:string) =
      let fun look(a::rest,n) =
		app print [":",
			"line:",
			Int.toString pos ]	
       in anyErrors := true;
	  print (!fileName);
	  look(!linePos,!lineNum);
	  print ":";
	  print msg;
	  print "\n"
      end

  fun impossible msg =
      (app print ["Error: Compiler bug: ",msg,"\n"];
       TextIO.flushOut TextIO.stdOut;
       raise Error)

  fun bomb () = 
	(app print ["\n",
		    "Compilation Errors have occurred.",
		    "\n",
		    "Please check your idl file starting ",
		    "on the line number of the first",
		    "\n",
		    "error message. ",
		    "\n",
		    "***Compilation Terminated***", 
		    "\n"];
         TextIO.flushOut TextIO.stdOut;
	 OS.Process.failure
	)

  fun usage () = 
	(app print ["\n",
		    "Usage: ",
		    "corbin_idl",
		    " <idl filename>",
		    "\n\n"];
         TextIO.flushOut TextIO.stdOut;
	 OS.Process.failure
	)

  fun ioError () = 
	(app print ["\n",
		    "File IO Problem: ",
		    "please check the filename \"",
		    !fileName,
		    "\" and try again.", 
		    "\n\n"];
         TextIO.flushOut TextIO.stdOut;
	 OS.Process.failure
	)
end  (* structure ErrorMsg *)
  
