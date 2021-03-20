SHELL = /bin/bash

# directory containing this makefile
makefile_directory=$(realpath $(dir $(firstword $(MAKEFILE_LIST))))
$(info $(makefile_directory))




.PHONY: all
all: bin/bison bin/flex lib/libgmp.a lib/libmpfr.a bin/texinfo

#
# binutils: https://ftp.gnu.org/gnu/binutils/binutils-2.36.tar.gz
#
bin/ld: .dependencies/binutils-2.36/ld | bin
	cd .dependencies/binutils-2.36 && make install
	touch bin/binutils

.dependencies/binutils-2.36/ld: .dependencies/binutils-2.36/Makefile
	cd .dependencies/binutils-2.36 && make && touch ld

.dependencies/binutils-2.36/Makefile: .dependencies/binutils-2.36/configure
	cd .dependencies/binutils-2.36 && ./configure --prefix="$(makefile_directory)" 
	touch .dependencies/binutils-2.36/Makefile
	   
.dependencies/binutils-2.36/configure: .dependencies/binutils-2.36.tar.gz
	cd .dependencies && tar xzf binutils-2.36.tar.gz && touch binutils-2.36/configure
	
.dependencies/binutils-3.7.tar.gz: makefile | .dependencies
	cd .dependencies && wget -N https://ftp.gnu.org/gnu/binutils/binutils-2.36.tar.gz && touch binutils-3.7.tar.gz

	   


#
# bison: http://ftp.gnu.org/gnu/bison/bison-3.7.tar.gz
#
bin/bison: .dependencies/bison-3.7/src/bison | bin
	cd .dependencies/bison-3.7 && make install
	touch bin/bison

.dependencies/bison-3.7/src/bison: .dependencies/bison-3.7/Makefile
	cd .dependencies/bison-3.7 && make && touch src/bison

.dependencies/bison-3.7/Makefile: .dependencies/bison-3.7/configure
	cd .dependencies/bison-3.7 && ./configure --prefix="$(makefile_directory)" 
	touch .dependencies/bison-3.7/Makefile
	   
.dependencies/bison-3.7/configure: .dependencies/bison-3.7.tar.gz
	cd .dependencies && tar xzf bison-3.7.tar.gz && touch bison-3.7/configure
	
.dependencies/bison-3.7.tar.gz: makefile | .dependencies
	cd .dependencies && wget -N http://ftp.gnu.org/gnu/bison/bison-3.7.tar.gz && touch bison-3.7.tar.gz

	   
#
# flex: https://github.com/westes/flex/releases/download/v2.6.3/flex-2.6.3.tar.gz
#
bin/flex: .dependencies/flex-2.6.3/src/flex | bin
	cd .dependencies/flex-2.6.3 && make install
	touch bin/flex

.dependencies/flex-2.6.3/src/flex: .dependencies/flex-2.6.3/Makefile
	cd .dependencies/flex-2.6.3 && make && touch src/flex
	
.dependencies/flex-2.6.3/Makefile: .dependencies/flex-2.6.3/configure
	cd .dependencies/flex-2.6.3 && ./configure --prefix="$(makefile_directory)"
	touch .dependencies/flex-2.6.3/Makefile

.dependencies/flex-2.6.3/configure: .dependencies/flex-2.6.3.tar.gz
	cd .dependencies && tar xzf flex-2.6.3.tar.gz
	cd .dependencies/flex-2.6.3 && ./autogen.sh
	touch .dependencies/flex-2.6.3/configure

.dependencies/flex-2.6.3.tar.gz: makefile | .dependencies 
	cd .dependencies && wget -N https://github.com/westes/flex/releases/download/v2.6.3/flex-2.6.3.tar.gz && touch flex-2.6.3.tar.gz
	   

#
# gmp: https://gmplib.org/download/gmp/gmp-6.2.1.tar.xz
#
lib/libgmp.a: .dependencies/gmp-6.2.1/libgmp.la | lib include
	cd .dependencies/gmp-6.2.1 && make install
	touch lib/libgmp.a

.dependencies/gmp-6.2.1/libgmp.la: .dependencies/gmp-6.2.1/Makefile
	cd .dependencies/gmp-6.2.1 && make && touch libgmp.la
	
.dependencies/gmp-6.2.1/Makefile: .dependencies/gmp-6.2.1/configure
	cd .dependencies/gmp-6.2.1 && ./configure --prefix="$(makefile_directory)"
	touch .dependencies/gmp-6.2.1/Makefile

.dependencies/gmp-6.2.1/configure: .dependencies/gmp-6.2.1.tar.xz
	cd .dependencies && tar xJf gmp-6.2.1.tar.xz
	touch .dependencies/gmp-6.2.1/configure

.dependencies/gmp-6.2.1.tar.xz: makefile | .dependencies 
	cd .dependencies && wget -N https://gmplib.org/download/gmp/gmp-6.2.1.tar.xz && touch gmp-6.2.1.tar.xz
	   

#
# mpfr: https://www.mpfr.org/mpfr-current/mpfr-4.1.0.tar.gz
#
lib/libmpfr.a: lib/libgmp.a .dependencies/mpfr-4.1.0/libmpfr.la | lib include
	cd .dependencies/mpfr-4.1.0 && make install
	touch lib/libmpfr.a

.dependencies/mpfr-4.1.0/libmpfr.la: .dependencies/mpfr-4.1.0/Makefile
	cd .dependencies/mpfr-4.1.0 && make && touch libmpfr.la
	
.dependencies/mpfr-4.1.0/Makefile: .dependencies/mpfr-4.1.0/configure
	cd .dependencies/mpfr-4.1.0 && ./configure --prefix="$(makefile_directory)" CFLAGS="-I$(makefile_directory)/include" LDFLAGS="-L$(makefile_directory)/lib"
	touch .dependencies/mpfr-4.1.0/Makefile

.dependencies/mpfr-4.1.0/configure: .dependencies/mpfr-4.1.0.tar.gz
	cd .dependencies && tar xzf mpfr-4.1.0.tar.gz
	touch .dependencies/mpfr-4.1.0/configure

.dependencies/mpfr-4.1.0.tar.gz: makefile | .dependencies 
	cd .dependencies && wget -N https://www.mpfr.org/mpfr-current/mpfr-4.1.0.tar.gz && touch mpfr-4.1.0.tar.gz
	   
	   
#
# texinfo: http://ftp.gnu.org/gnu/texinfo/texinfo-6.7.tar.gz
#
bin/info: .dependencies/texinfo-6.7/info | bin
	cd .dependencies/texinfo-6.7 && make install
	touch bin/info

.dependencies/texinfo-6.7/info: .dependencies/texinfo-6.7/Makefile
	cd .dependencies/texinfo-6.7 && make && touch info

.dependencies/texinfo-6.7/Makefile: .dependencies/texinfo-6.7/configure
	cd .dependencies/texinfo-6.7 && ./configure --prefix="$(makefile_directory)" 
	touch .dependencies/texinfo-6.7/Makefile
	   
.dependencies/texinfo-6.7/configure: .dependencies/texinfo-6.7.tar.gz
	cd .dependencies && tar xzf texinfo-6.7.tar.gz && touch texinfo-6.7/configure
	
.dependencies/texinfo-6.7.tar.gz: makefile | .dependencies
	cd .dependencies && wget -N http://ftp.gnu.org/gnu/texinfo/texinfo-6.7.tar.gz && touch texinfo-6.7.tar.gz

	   
#
# isl: http://isl.gforge.inria.fr/isl-0.23.tar.gz
#
lib/libisl.a: lib/libgmp.a .dependencies/isl-0.23/libisl.la | lib include
	cd .dependencies/isl-0.23 && make install
	touch lib/libisl.a

.dependencies/isl-0.23/libisl.la: .dependencies/isl-0.23/Makefile
	cd .dependencies/isl-0.23 && make && touch libisl.la
	
.dependencies/isl-0.23/Makefile: .dependencies/isl-0.23/configure
	cd .dependencies/isl-0.23 && ./configure --prefix="$(makefile_directory)" CPPFLAGS="-I$(makefile_directory)/include" LDFLAGS="-L$(makefile_directory)/lib"
	touch .dependencies/isl-0.23/Makefile

.dependencies/isl-0.23/configure: .dependencies/isl-0.23.tar.gz
	cd .dependencies && tar xzf isl-0.23.tar.gz
	touch .dependencies/isl-0.23/configure

.dependencies/isl-0.23.tar.gz: makefile | .dependencies 
	cd .dependencies && wget -N http://isl.gforge.inria.fr/isl-0.23.tar.gz && touch isl-0.23.tar.gz
	   


#
# Directories
#
.dependencies:
	@-mkdir .dependencies

bin:
	@-mkdir -p bin
	
doc:
	@-mkdir -p doc
	
include:
	@-mkdir -p include
	
lib:
	@-mkdir -p lib

src:
	@-mkdir -p src


clean:
	rm -rf .dependencies