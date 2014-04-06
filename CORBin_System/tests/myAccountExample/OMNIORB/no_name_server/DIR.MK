
CXXSRCS = account_i.cc account_client.cc 

DIR_CPPFLAGS = $(CORBA_CPPFLAGS)

CORBA_INTERFACES = account 


account_i   = $(patsubst %,$(BinPattern),account_i)
account_client    = $(patsubst %,$(BinPattern),account_client)


all:: $(account_client) $(account_i) 

clean::
	$(RM) $(account_client) $(account_i)

export:: $(account_client) $(account_i)
	@(module="accountexamples"; $(ExportExecutable))

$(account_client): account_client.o $(CORBA_STATIC_STUB_OBJS) $(CORBA_LIB_DEPEND)
	@(libs="$(CORBA_LIB_NODYN)"; $(CXXExecutable))

$(account_i): account_i.o $(CORBA_STATIC_STUB_OBJS) $(CORBA_LIB_DEPEND)
	@(libs="$(CORBA_LIB_NODYN)"; $(CXXExecutable))

