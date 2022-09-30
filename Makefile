CC=g++

ifndef mode
mode = orig
endif

ifeq ($(mode), orig)
$(info original mode)
ICINCHOME=/usr/
ICLIBHOME=/usr/lib
LDPATH=
else
$(info ValkoVesi mode)
ICINCHOME=/opt/instantclient_21_5/sdk/
ICLIBHOME=/opt/instantclient_21_5
LDPATH=-Wl,-rpath=$(ICLIBHOME)
endif

ICLIBPATH=-L$(ICLIBHOME)
CCINCLUDES=-I$(ICINCHOME)include

THREADLIBS=-lthread
CCLIB=$(ICLIBPATH) -locci -lclntsh $(THREADLIBS)

CCFLAGS=$(CCINCLUDES) -D_REENTRANT -g -xs
LDFLAGS=

all: task_prog

task_prog: main.o dal.o
	$(CC) -o task_prog $(LDFLAGS) main.o dal.o $(CCLIB)

main.o:
	$(CC) -c $(CCFLAGS) -Wall main.cpp

dal.o: dal.h
	$(CC) -c $(CCFLAGS) dal.cpp

clean:
	rm -f *.o task_prog


ifeq ($(BUILD32),T)
CCFLAGS=$(CCINCLUDES) -DLINUX -D_GNU_SOURCE -D_REENTRANT -g -m32
LDFLAGS=$(LDPATH) -g -m32
else
CCFLAGS=$(CCINCLUDES) -DLINUX -D_GNU_SOURCE -D_REENTRANT -g
LDFLAGS=$(LDPATH) -g

#Use libocci_gcc53 library for linux 64 bit, if gcc version 5 and above is used.
GCCVERSION=$(shell expr `$(CC) -dumpversion | cut -f1 -d.`)
ifeq ($(shell test $(GCCVERSION) -gt 4; echo $$?), 0)
CCLIB=$(ICLIBPATH) -locci_gcc53 -lclntsh $(THREADLIBS)
CCFLAGS += -Wno-narrowing
endif
endif

THREADLIBS=-lpthread

#---------------------------
# Use:
# export LD_LIBRARY_PATH=/opt/instantclient_21_5/
# Before run the target in ValkoVesi mode
#---------------------------
