CC=g++

ICINCHOME=/usr/
ICLIBHOME=/usr/lib/
ICLIBPATH=-L$(ICLIBHOME)
CCINCLUDES=-I$(ICINCHOME)include

THREADLIBS=-lthread
CCLIB=$(ICLIBPATH) -locci -lclntsh $(THREADLIBS)

CCFLAGS=$(CCINCLUDES) -D_REENTRANT -g -xs
LDFLAGS=

all: task_prog

task_prog: main.o dal.o
	$(CC) -o task_prog $(LDFLAGS) main.o dal.o $(CCLIB)

main.o: dal.h
	$(CC) -c -Wall main.cpp

dal.o: dal.h
	$(CC) -c $(CCFLAGS) dal.cpp


ifeq ($(BUILD32),T)
CCFLAGS=$(CCINCLUDES) -DLINUX -D_GNU_SOURCE -D_REENTRANT -g -m32
LDFLAGS=-g -m32
else
CCFLAGS=$(CCINCLUDES) -DLINUX -D_GNU_SOURCE -D_REENTRANT -g
LDFLAGS=-g

#Use libocci_gcc53 library for linux 64 bit, if gcc version 5 and above is used.
GCCVERSION=$(shell expr `$(CC) -dumpversion | cut -f1 -d.`)
ifeq ($(shell test $(GCCVERSION) -gt 4; echo $$?), 0)
CCLIB=$(ICLIBPATH) -locci_gcc53 -lclntsh $(THREADLIBS)
CCFLAGS += -Wno-narrowing
endif
endif

THREADLIBS=-lpthread
