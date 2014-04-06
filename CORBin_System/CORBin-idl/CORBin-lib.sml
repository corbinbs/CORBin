structure CORBinLib : 
     sig 
	 val init : string -> unit
	 val update : unit -> unit 
	 val error : string -> OS.Process.status 
	 val fileError : string -> unit 
	 val genCORBcode : string -> unit
	 val rebuild : unit -> unit
	 val print_env : string option -> unit
	 val setIdlDir : string option -> unit
	 val setOS : string option -> unit
	 val setARCH : string option -> unit
	 val setOrbDir : string option -> unit
	 val setSrcDir : string option -> unit
	 val setSMLNJ_CDir : string option -> unit
	 val getIdlDir : unit -> string
	 val getOrbDir : unit -> string
	 val getSrcDir : unit -> string 
	 val getSMLNJ_CDir : unit -> string 
	 val getFileName : unit -> string 
	 val getCorbinOS : unit -> string 
	 val getCorbinARCH : unit -> string 
	 val getCORBHeaderName : unit -> string 
	 val getWrapperName : unit -> string
	 val getMacroName : unit -> string
	 val makeFileName : string -> string 
	 val buildFileName : char list -> char list
	 val idlOutputDir : string ref 
	 val cOrbOutputDir : string ref 
	 val smlSrcDir : string ref 
	 val smlnj_cDir : string ref 
	 val fileName : string ref 
	 val corbinOS : string ref 
	 val corbinARCH : string ref 
         exception CORBinLibError of string
     end =
struct

val idlOutputDir = ref ""
val cOrbOutputDir = ref ""
val smlSrcDir = ref ""
val smlnj_cDir = ref ""
val fileName = ref ""
val corbinOS = ref ""
val corbinARCH = ref ""

exception CORBinLibError of string 


fun buildFileName(cl) = if (hd(cl) = #"/" orelse hd(cl) = #"\\") then nil
			else (hd(cl) :: buildFileName (tl(cl)) )

fun makeFileName(f) = 
	  let val fl = explode f  
	  in 
		implode (rev(buildFileName (rev fl)))
	  end 

fun getIdlDir () = (!idlOutputDir)
fun getOrbDir () = (!cOrbOutputDir)
fun getSrcDir () = (!smlSrcDir)
fun getSMLNJ_CDir () = (!smlnj_cDir)

fun getFileName () = (substring((!fileName), 0, 
					(size((!fileName))-4))) 

fun getCORBHeaderName () = ((!cOrbOutputDir) ^ "/" 
				^ (substring((!fileName), 0, 
					(size((!fileName))-4))) ^ ".h")

fun getWrapperName () = ( (!idlOutputDir) ^ "/CORBin_" ^ 
		    		(substring((!fileName), 0, 
					(size((!fileName))-4))) ^ ".c")

fun getMacroName () = ( ((!smlSrcDir) ^ "/src/runtime/c-libs/smlnj-ccalls"
				^ "/CORBin_CFUNCS.h"))
fun getCorbinOS () = ( !corbinOS )

fun getCorbinARCH () = ( !corbinARCH ) 

fun print_env(SOME c) = print (c ^ "\n")
  | print_env(NONE) = print "Not Defined!\n" 

fun setIdlDir(SOME c) = idlOutputDir := c 
  | setIdlDir(NONE) = raise CORBinLibError("CORBin-Idl Output Directory Not Defined")

fun setOrbDir(SOME c) = cOrbOutputDir := c 
  | setOrbDir(NONE) = raise CORBinLibError("C Orb Output Directory Not Defined") 

fun setSrcDir(SOME c) = smlSrcDir := c 
  | setSrcDir(NONE) = raise CORBinLibError("SML-NJ Source Code Directory Not Defined") 

fun setSMLNJ_CDir(SOME c) = smlnj_cDir := c 
  | setSMLNJ_CDir(NONE) = raise CORBinLibError("SML-NJ/C Foreign Function Interface Directory Not Defined") 

fun setOS(SOME os) = corbinOS := os 
  | setOS(NONE) = raise CORBinLibError("Operating System Not Defined") 

fun setARCH(SOME arch) = corbinARCH := arch 
  | setARCH(NONE) = raise CORBinLibError("System Architecture Not Defined") 

fun update() =
		let val dotc = ((!smlSrcDir) ^ "/src/runtime/c-libs/smlnj-ccalls/CORBin-lib.c") 
		    val outc = TextIO.openAppend(dotc)
		in 
		    TextIO.output(outc, "#include \"");
		    TextIO.output(outc, !idlOutputDir );
		    TextIO.output(outc, "/CORBin_"); 
		    TextIO.output(outc, substring((!fileName), 0, 
					(size((!fileName))-4)));
		    TextIO.output(outc, ".c\"\n");

		    TextIO.output(outc, "\n");
		    TextIO.output(outc, "#ifndef CORB_CODE_");
		    TextIO.output(outc, substring((!fileName), 0, 
					(size((!fileName))-4)));
		    TextIO.output(outc, "\n");
		    TextIO.output(outc, "#define CORB_CODE_");
		    TextIO.output(outc, substring((!fileName), 0, 
					(size((!fileName))-4)));
		    TextIO.output(outc, "\n\n");
			
		    TextIO.output(outc, "  #include \"");
		    TextIO.output(outc, !cOrbOutputDir );
		    TextIO.output(outc, "/"); 
		    TextIO.output(outc, substring((!fileName), 0, 
					(size((!fileName))-4)));
		    TextIO.output(outc, "-stubs.c\"\n");

		    TextIO.output(outc, "  #include \"");
		    TextIO.output(outc, !cOrbOutputDir );
		    TextIO.output(outc, "/"); 
		    TextIO.output(outc, substring((!fileName), 0, 
					(size((!fileName))-4)));
		    TextIO.output(outc, "-common.c\"\n\n");

		    TextIO.output(outc, "  #include \"");
		    TextIO.output(outc, !cOrbOutputDir );
		    TextIO.output(outc, "/"); 
		    TextIO.output(outc, substring((!fileName), 0, 
					(size((!fileName))-4)));
		    TextIO.output(outc, "-skels.c\"\n\n");

		    TextIO.output(outc, "#endif\n\n");
		    
		    TextIO.flushOut outc;
		    TextIO.closeOut outc
		end


fun init (file) = 
		let val i = OS.Process.getEnv("CORBIN_IDL_OUTPUT_DIR") 
		    val c = OS.Process.getEnv("C_ORB_OUTPUT_DIR") 
		    val s = OS.Process.getEnv("SML_SRC_DIR") 
		    val sc = OS.Process.getEnv("SMLNJ_C_DIR") 
		    val os = OS.Process.getEnv("CORBIN_OS") 
		    val arch = OS.Process.getEnv("CORBIN_ARCH") 
		    val f = makeFileName file
		in 
			fileName := f;
			setIdlDir i;	
			setOrbDir c;
			setSMLNJ_CDir sc;
			setOS os;
			setARCH arch;
			setSrcDir s
		end
fun error s = ( 
		TextIO.output(TextIO.stdErr, "\n");
		TextIO.output(TextIO.stdErr, s);
		TextIO.output(TextIO.stdErr, "\n");
		TextIO.output(TextIO.stdErr, "Please set the appropriate environment variables.\n");
		TextIO.output(TextIO.stdErr, "\n");
		OS.Process.failure)

fun fileError s = ( 
		TextIO.output(TextIO.stdErr, "\n");
		TextIO.output(TextIO.stdErr, s);
		TextIO.output(TextIO.stdErr, "\n");
		TextIO.output(TextIO.stdErr, "\n"))

fun genCORBcode (file) = 
		let val       _ = 
			print ("Generating C-ORB code via your C ORB's idl compiler...\n") 
		    val cur_dir = OS.FileSys.getDir()
		    val       _ = OS.Process.system(("cp " ^ file ^ " " ^
				    ((!cOrbOutputDir) ^ "/" ^ (!fileName))))
		    val       _ = OS.FileSys.chDir((!cOrbOutputDir))

		in 
		    OS.Process.system(("orbit-idl " ^ (!fileName)));
		    OS.FileSys.chDir(cur_dir)
		end 

fun rebuild () = 
		let val       _ = 
			print ("Rebuilding the SML-NJ Runtime System...\n") 
		    val cur_dir = OS.FileSys.getDir()
		    val       _ = OS.FileSys.chDir(
			((!smlSrcDir) ^ "/src/runtime/c-libs/smlnj-ccalls"))
		    val       _ = OS.Process.system("gmake clean >& /dev/null");
		    val       _ = OS.FileSys.chDir(
					((!smlSrcDir) ^ "/src/runtime/objs"))

		in 
		    OS.Process.system("rm -f *.o");
                    if(getCorbinOS() = "linux") then
                     if(getCorbinARCH() = "x86") then (
		       OS.Process.system("gmake -f mk.x86-linux-ccalls");
		       OS.Process.system("cp run.x86-linux ../../../bin/.run"))
                     else OS.Process.success 
                    else OS.Process.success;
                    if(getCorbinOS() = "solaris") then
                     if(getCorbinARCH() = "sparc") then (
		       OS.Process.system("gmake -f mk.sparc-solaris-ccalls");
		       OS.Process.system("cp run.sparc-solaris ../../../bin/.run"))
                     else OS.Process.success
                    else OS.Process.success;
		    OS.FileSys.chDir(cur_dir)
		end 
		


end

