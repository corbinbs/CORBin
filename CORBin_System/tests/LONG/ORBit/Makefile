PROJECT = passlong
 
CC = gcc
ORBIT_IDL = orbit-idl
ORBIT_CFLAGS = -I/usr/lib/glib/include -I/usr/include
ORBIT_LIBS = -L/usr/lib -lORBit -lIIOP -lORBitutil -lglib -lm -lnsl
CFLAGS = $(ORBIT_CFLAGS)
LFLAGS = $(ORBIT_LIBS)

all : idltargets $(PROJECT)-client $(PROJECT)-server

$(PROJECT)-client : $(PROJECT)-client.o $(PROJECT)-common.o $(PROJECT)-stubs.o
	$(CC) -o $(PROJECT)-client $(PROJECT)-client.o $(PROJECT)-stubs.o $(PROJECT)-common.o  -lIIOP -lORBit -lORBitutil $(LFLAGS)

$(PROJECT)-server : $(PROJECT)-server.o $(PROJECT)-skels.o $(PROJECT)-common.o 
	$(CC) -o $(PROJECT)-server $(PROJECT)-server.o $(PROJECT)-skels.o $(PROJECT)-common.o  -lIIOP -lORBit -lORBitutil $(LFLAGS)


clean :
	rm *.[oa] $(PROJECT)-client $(PROJECT)-server

real-clean : clean
	rm -f $(PROJECT)-stubs.[oc] $(PROJECT)-skels.[oc] $(PROJECT).h $(PROJECT)-common.[oc]
 
idltargets : $(PROJECT).idl
	$(ORBIT_IDL) $(PROJECT).idl

# individual rules

$(PROJECT)-stubs.c : $(PROJECT).idl
	$(ORBIT_IDL) $(PROJECT).idl

$(PROJECT)-common.c : $(PROJECT).idl
	$(ORBIT_IDL) $(PROJECT).idl

$(PROJECT)-skels.c : $(PROJECT).idl
	$(ORBIT_IDL) $(PROJECT).idl

$(PROJECT)-client.c : $(PROJECT).h

$(PROJECT)-server.c : $(PROJECT).h

$(PROJECT).h : $(PROJECT).idl
	$(ORBIT_IDL) $(PROJECT).idl

