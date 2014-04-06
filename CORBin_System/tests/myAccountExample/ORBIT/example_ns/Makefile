# Makefile for the ORBitEx NameServer example


# Compilation tools and flags
CC = gcc
ORBIT_IDL = /usr/bin/orbit-idl
ORBIT_CFLAGS = -I/usr/lib/glib/include -I/usr/include
ORBIT_LIBS = -L/usr/lib -lORBit -lIIOP -lORBitutil -lglib -lm
CFLAGS = $(ORBIT_CFLAGS)
LFLAGS = $(ORBIT_LIBS)

LDLIBS		= $(LFLAGS)

CSOURCES	= factory-skels.c factory-stubs.c \
	        factory-common.c account-skels.c \
		account-stubs.c account-common.c name.c \
		CosNaming-stubs.c CosNaming-common.c
SOURCES		= $(CSOURCES) 
COBJECTS	= $(CSOURCES:.c=.o)
OBJECTS		= $(COBJECTS) 

all: factory-server factory-client

factory-client: $(OBJECTS) factory-client.o
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

factory-server: $(OBJECTS) factory-server.o factory-imp.o account-imp.o 
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

clean : 
	rm -fr *.o factory-client factory-server

real-clean : clean
	rm factory-stubs.c factory-skels.c factory.h factory-common.c

