Java(tm) Plug-in HTML Converter  Readme

Version:  1.3

*****   BACKUP ALL FILE BEFORE CONVERTING THEM WITH THIS TOOL   *****
*****   CANCELLING A CONVERSION WILL NOT ROLLBACK THE CHANGES.  *****
*****   COMMENTS WITHIN THE APPLET TAG ARE IGNORED	*****

-----
Contents of this file
-----
1)  New Features
2)  Bug Fixes
3)  About Java(tm) Plug-in HTML Converter
4)  The conversion process
5)  Choosing files within folders to convert
6)  Choosing backup folder
7)  Generating a log file
8)  Choosing a conversion template
9)  Converting
10)  More Conversions or Quit
11)  Using the command line interface method of running the converter
12)  Details about templates
13)  Running HTML Converter (Windows & Solaris)

-----
1)  New Features:
-----

	*   Enhanced user interface with Swing 1.1 for i18n support.
	*   Enhanced Advanced Option dialog to support new SmartUpdate and 
	    MimeType template tags.
	*   Enhanced HTML Converter to be used with both Java Plug-in 1.1.x 
	    Java Plug-in 1.2.x and Java Plug-in 1.3.
	*   Enhanced SmartUpdate and MimeType support in all conversion 
	    templates.
	*   Added "scriptable=false" to the OBJECT/EMBED tag in all
	    templates. This is used for disable typelib generation
	    when Java Plug-in is not used for scripting.

	
-----
2)  Bugs Fixed:
-----
	*   Enhanced error handling when properties files are not found.
	*   Enhanced HTML conversion so the result EMBED/OBJECT tag can be 
	    used in AppletViewer in JDK 1.2.x
	*   Eliminated unnecessary files which were left over from HTML 
	    Converter 1.1.x.
	*   Generated EMBED/OBJECT with CODE, CODEBASE, etc attribute names
	    instead of JAVA_CODE, JAVA_CODEBASE, etc. This enabled generated
	    page to be used in JDK 1.2.x AppletViewer.
	*   Support MAYSCRIPT conversion if it is presented in the APPLET tag.


-----
3)  About Java(tm) Plug-in HTML Converter:
-----
  Java(tm) Plug-in HTML Converter is a utility that allows you to convert any 
  HTML page which contains applets to a format that will use the Java(tm) 
  Plug-in.  


-----
4)  The conversion process:
-----
  
  The Java(tm) Plug-in HTML Converter will convert any file(s) containing 
  applets to a form that can be used with the Java(tm) Plug-in.  
  
  The process of converting each file is as follows:
  
  First, HTML that is not part of an applet is transferred from the source 
  file to a temporary file.  When an <APPLET tag is reached, the converter 
  will parse the applet to the first </APPLET tag (not contained in qoutes), 
  and merge the applet data with the template. (See Details about templates, 
  below) If this completes without error, the original html file will be moved 
  to the backup folder and the temporary file will then be renamed to the 
  original file's name.  Thus, your original files will never be removed 
  from disk.
  
  Note that the converter will effectively convert the files in place.  So, 
  once you have run the converter, your files will be setup to use the 
  Java(tm) Plug-in.

  
-----
5)  Choosing files within folders to convert:
-----

To convert all files within a folder, you may type in the path to the folder, 
or choose the browse button to select a folder from a dialog.  Once you have 
chosen a path, you may supply any number to file specifiers in the "Matching 
File Names".  Each specifier must be separated by a comma.  You may use * as 
a wildcard.  If you put a filename with wildcard, only that single file will
be converted. Lastly, select the checkbox "Include Subfolders", if you would 
like all files in nested folders which match the file name to be converted.


-----
6)  Choosing backup folder
-----

The default backup folder path is the source path with an "_BAK" appended 
to the name. i.e.  If the source path is c:/html/applet.html  (converting 
one file) then the backup path would be c:/html_BAK.  If the source path 
is c:/html (converting all files in path) then the backup path would be 
c:/html_BAK. The backup path may be changed by typing a path in the field 
next to "Backup files to folder:", or by browsing for a folder.

Unix(Solaris): 
The default backup folder path is the source path with an "_BAK" appended to 
the name. i.e.  If the source path is /home/user1/html/applet.html (converting
one file) then the backup path would be /home/user1/html_BAK. If the source
path is /home/user1/html (converting all files in path) then the backup path 
would be /home/user1/html_BAK. The backup path may be changed by typing a path
in the field next to "Backup files to folder:", or by browsing for a folder.


-----
7)  Generating a log file
-----

If you would like a log file to be generated, choose the checkbox 
"Generate Log File". Type in a path or browse to choose a folder.  The 
log file contains basic information related to the converting process.

-----
8)  Choosing a conversion template
-----

If a default template will be used if none is chosen.  This template will 
produce converted html files that will work with IE and Netscape.  If you 
would like to use a different template, you may choose it from the menu on 
the main screen.  If you choose other, you will be allowed to choose a file 
that will be used as the template.  If you choose a file, BE SURE THAT IT 
IS A TEMPLATE.

-----
9)  Converting
-----

Click the "Convert..." button to begin the conversion process.  A process 
dialog will show the files being processed, the number for files process, 
the number of applets found, and number of errors found.

-----
10)  More Conversions or Quit
-----
 
When the conversion is complete, the button in the process dialog will change 
from "Cancel" to "Done".  You may choose "Done" to close the dialog.  At this 
point, choose "Quit" to close the Java(tm) Plug-in HTML Converter, or selected
another set of files to convert and choose "Convert..." again.


-----
11)  Using the command line interface method of running the converter
-----
COMMAND LINE INTERFACE:

	The converted now supports a command line interface. From a command 
line, you may type:

java HTMLConverter [ filespecs ] [-simulate] [-options1 value1 [-option2 value2 [...]]]

If only "java HTMLConverter" is specified (no filespecs or options) the GUI version 
of the converter will be launched.  Otherwise, the GUI will be suppressed.

filespecs:  space delimited list of file specs, * wildcard.  (*.html *.htm)

Options:
	source:	    Path to files.  (c:\htmldocs in Windows, 
		    /home/user1/htmldocs in Unix) Default: <userdir>
			If the path is relative, it is assumed to be relative to the 
			directory that HTMLConverter was launched.

	backup:	    Path to write backup files.  Default: <userdir>/<source>_bak
			If the path is relative, it is assumed to be relative to the 
			directory that HTMLConverter was launched.

	subdirs:    Should files in subdirectories be processed.  Default:  FALSE

	template:   Name of template file.  Default:  default.tpl-Standard (IE & Navigator) 
			for Windows & Solaris Only.  USE DEFAULT IF UNSURE.

	log:  	    Path and filename to write log.  (Default <userdir>/convert.log)

	progress:   Display standard out progress while converting.  Default: true

	simulate:   Display the specifics to the conversion without converting.
			USE THIS OPTION IF UNSURE ABOUT CONVERTING.  YOU WILL BE GIVEN
			A LIST OF DETAILS SPECIFIC TO THE CONVERSION.

-----
12)  Details about templates
-----

The template file is the basis behind converting applets.  It is simply a text 
file containing tag the represent parts of the original applet.  By 
add/removing/moving the tags in a template file, you can alter the output 
of the converted file.

Supported Tags:

$OriginalApplet$    This tag is substituted with the complete text of the 
		    original applet.

$AppletAttributes$  This tag is substituted with all of the applets attributes.
		    (code, codebase, width, height, etc.)

$ObjectAttributes$  This tag is substituted with all the attributes required by
		    the object tag.

$EmbedAttributes$   This tag is substituted with all the attributes required by
		    the embed tag.

$AppletParams$  This tag is substituted with all the applet's <param ...> tags

$ObjectParams$  This tag is substituted with all the <param...> tags required 
		by the object tag.

$EmbedParams$	This tag is substituted with all the <param...> tags required by
		the embed tag in the form  NAME=VALUE

$AlternateHTML$	    This tag is substituted with the text in the No support for 
		    applets area of the original applet
				
$CabFileLocation$   This is the URL of the cab file that should be used in each
		    template that targets IE.
					
$NSFileLocation$    This is the URL of the Netscape plugin that be used in each
		    template that targets Netscape

$SmartUpdate$	    This is the URL of the Netscape SmartUpdate that be used in 
		    each template that targets Netscape Navigator 4.0 or later.

$MimeType$	    This is the MIME type of the Java object


/*************************/
default.tpl is the default template for the converter. The converted page can 
be used in IE and Navigator on Windows 95 or Windows NT to invoke Java(TM) 
Plug-in. This template can also be used with Netscape on Unix(Solaris)

<!-- CONVERTER VERSION 1.3 -->
<OBJECT classid="clsid:8AD9C840-044E-11D1-B3E9-00805F499D93"
$ObjectAttributes$ codebase="$CabFileLocation$">
$ObjectParams$
<PARAM NAME="type" VALUE="$MimeType$">
<PARAM NAME="scriptable" VALUE="false">
$AppletParams$<COMMENT>
<EMBED type="$MimeType$" $EmbedAttributes$
$EmbedParams$ scriptable=false pluginspage="$NSFileLocation$"><NOEMBED></COMMENT>
		$AlternateHTML$
	</NOEMBED></EMBED>
</OBJECT>

<!--
$ORIGINALAPPLET$
-->
/*************************/


/*************************/
ieonly.tpl -- the converted page can be used to invoke Java(TM) Plug-in in IE 
on Windows only.

<!-- CONVERTER VERSION 1.3 -->
<OBJECT classid="clsid:8AD9C840-044E-11D1-B3E9-00805F499D93"
$ObjectAttributes$ codebase="$CabFileLocation$">
$ObjectParams$
<PARAM NAME="type" VALUE="$MimeType$">
<PARAM NAME="scriptable" VALUE="false">
$AppletParams$
$AlternateHTML$
</OBJECT>

<!--
$ORIGINALAPPLET$
-->
/*************************/


/*************************/
nsonly.tpl -- the converted page can be used to invoke Java(TM) Plug-in in 
Navigator on Windows and Solaris.

<!-- CONVERTER VERSION 1.3 -->
<EMBED type="$MimeType$" $EmbedAttributes$
$EmbedParams$ scriptable=false pluginspage="$NSFileLocation$"><NOEMBED>
$AlternateHTML$
</NOEMBED></EMBED>

<!--
$ORIGINALAPPLET$
-->
/*************************/


/*************************/
extend.tpl -- the converted page can be used in any browser and any platform. 
If the browser is IE or Navigator on Windows (Navigator only on Solaris), 
Java(TM) Plug-in will be invoked. Otherwise, the browser's default JVM is used.


<!-- CONVERTER VERSION 1.3 -->
<SCRIPT LANGUAGE="JavaScript"><!--
    var _info = navigator.userAgent; var _ns = false;
    var _ie = (_info.indexOf("MSIE") > 0 && _info.indexOf("Win") > 0 &&
_info.indexOf("Windows 3.1") < 0);
//--></SCRIPT>
<COMMENT><SCRIPT LANGUAGE="JavaScript1.1"><!--
    var _ns = (navigator.appName.indexOf("Netscape") >= 0 &&
((_info.indexOf("Win") > 0 && _info.indexOf("Win16") < 0 &&
java.lang.System.getProperty("os.version").indexOf("3.5") < 0) ||
_info.indexOf("Sun") > 0));
//--></SCRIPT></COMMENT>

<SCRIPT LANGUAGE="JavaScript"><!--
    if (_ie == true) document.writeln('<OBJECT
classid="clsid:8AD9C840-044E-11D1-B3E9-00805F499D93" $ObjectAttributes$
codebase="$CabFileLocation$"><NOEMBED><XMP>');
    else if (_ns == true) document.writeln('<EMBED
type="$MimeType$" $EmbedAttributes$
$EmbedParams$ scriptable=false 
pluginspage="$NSFileLocation$"><NOEMBED><XMP>');
//--></SCRIPT>
<APPLET $AppletAttributes$></XMP>
$ObjectParams$
<PARAM NAME="type" VALUE="$MimeType$">
<PARAM NAME="scriptable" VALUE="false">
$AppletParams$
</APPLET>
$AlternateHTML$
</NOEMBED></EMBED></OBJECT>


<!--
$ORIGINALAPPLET$
-->
/*************************/


13)  Running HTML Converter:

    Once the installation is done, change directory to the install folder, 
and do the following for your specific platform:

Set the classpath to  %CLASSPATH%;.;

(Note:  .'s and /'s are UNIX specific.  Be sure to use your platforms 
specific file and path separators.)

Launch the main class:  HTMLConverter

For example, on Windows:

> cd <HTML Converter Directory>
> set CLASSPATH=%CLASSPATH%;.;
> java HTMLConverter

On Unix(Solaris):

%cd <HTML Converter Directory>
%java HTMLConverter

You can also invoke the shell script HTMLConverter.sh by typing 
%sh HTMLConverter.sh  (or)  just HTMLConverter.sh
This will start the HTMLConverter(GUI version)
In Windows you can invoke HTMLConverter.bat

