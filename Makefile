EMACSHEADERS = ../../../emacs-25/src
CC      = gcc
LD      = gcc
CFLAGS  = -g -ggdb3 -Wall -fPIC
LDFLAGS = -shared -Wl,--image-base -Wl,0x10000000
CMAKEFLAGS =  -DBUILD_SHARED_LIBS=OFF -DCMAKE_LEGACY_CYGWIN_WIN32=0 -DTHREADSAFE=ON -DBUILD_CLAR=OFF -DCMAKE_C_FLAGS=-fPIC -DCMAKE_BUILD_TYPE="RelWithDebInfo"
LIBVTERMHEADERS = libvterm/include
LIBVTERMFILES = libvterm/.libs/libvterm.a
LDLIBS = $(LIBVTERMFILES)

ifeq ($(OS),Windows_NT)
TARGET = libvterm-core.dll
else
TARGET = libvterm-core.so
endif

ifeq ($(shell uname),Darwin)
LIBTOOL ?= glibtool
else
LIBTOOL ?= libtool
endif

.ONESHELL:

all: $(TARGET)

# make shared library out of the object file
%.so %.dll: %.o $(LIBVTERMFILES)
	$(LD) $(LDFLAGS) -o $@ $< $(LDLIBS)

# compile source file to object file
%.o: %.c
	$(CC) $(CFLAGS) -I$(EMACSHEADERS) -I$(LIBVTERMHEADERS) -c $<

$(LIBVTERMFILES): libvterm

.PHONY: libvterm
libvterm:
	cd libvterm
	VERBOSE=1 LDFLAGS="-all-static -no-undefined"  make

clean:
	rm -rf *.so *.dll libgit2/build
