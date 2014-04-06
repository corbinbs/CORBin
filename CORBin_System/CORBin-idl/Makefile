
all:	idl.lex idl.grm CORBin-idl.sml build.sml
	sml < build.sml

test:	idl.lex idl.grm CORBin-idl.sml tester.sml
	sml < tester.sml

maze:	idl.lex idl.grm CORBin-idl.sml maze.sml
	sml < maze.sml

clean :

	rm -f idl.grm.sml idl.grm.sig idl.lex.sml corbin_idl.* 
	rm -Rf CM
