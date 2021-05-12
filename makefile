SHELL = /bin/bash

# directory containing this makefile
makefile_directory=$(realpath $(dir $(firstword $(MAKEFILE_LIST))))
$(info $(makefile_directory))

CC:=/usr/bin/gcc
CXX:=/usr/bin/g++
AR:=/usr/bin/ar
RANLIB:=/usr/bin/ranlib
LD:=/usr/bin/ld

#
# For parallel makes
# Set to a number between 1 and the number of CPUs (or cores) on your build machine
#
MAXIMUM_CPUS:=16
#$(info MAXIMUM_CPUS = ${MAXIMUM_CPUS})


.PHONY: all
all: bin/gcc

#
# bison: http://ftp.gnu.org/gnu/bison/bison-3.7.tar.gz
#
bin/bison: .dependencies/bison-3.7/src/bison | bin lib64
	cd .dependencies/bison-3.7 && make install
	touch bin/bison

.dependencies/bison-3.7/src/bison: .dependencies/bison-3.7/Makefile
	cd .dependencies/bison-3.7 && make -j $(MAXIMUM_CPUS) && touch src/bison

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
bin/flex: .dependencies/flex-2.6.3/src/flex | bin lib64
	cd .dependencies/flex-2.6.3 && make install
	touch bin/flex

.dependencies/flex-2.6.3/src/flex: .dependencies/flex-2.6.3/Makefile
	cd .dependencies/flex-2.6.3 && make -j $(MAXIMUM_CPUS) && touch src/flex
	
.dependencies/flex-2.6.3/Makefile: .dependencies/flex-2.6.3/configure
	cd .dependencies/flex-2.6.3 && ./configure --prefix="$(makefile_directory)"
	touch .dependencies/flex-2.6.3/Makefile

.dependencies/flex-2.6.3/configure: .dependencies/flex-2.6.3.tar.gz | bin/automake
	cd .dependencies && tar xzf flex-2.6.3.tar.gz
	#cd .dependencies/flex-2.6.3 && ./autogen.sh
	touch .dependencies/flex-2.6.3/configure

.dependencies/flex-2.6.3.tar.gz: makefile | .dependencies 
	cd .dependencies && wget -N https://github.com/westes/flex/releases/download/v2.6.3/flex-2.6.3.tar.gz && touch flex-2.6.3.tar.gz
	   

#
# gcc: https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.gz
#
bin/gcc: .dependencies/gcc-10.2.0/gcc | bin lib64
	cd .dependencies/gcc-10.2.0 && make install
	touch bin/gcc

.dependencies/gcc-10.2.0/gcc: .dependencies/gcc-10.2.0/Makefile
	cd .dependencies/gcc-10.2.0 && make -j $(MAXIMUM_CPUS) && touch gcc
	
.dependencies/gcc-10.2.0/Makefile: .dependencies/gcc-10.2.0/configure bin/bison bin/flex lib64/libgmp.a bin/ld lib64/libmpc.a lib64/libmpfr.a bin/info
	cd .dependencies/gcc-10.2.0 && ./configure --enable-languages=c,c++,d,fortran --prefix="$(makefile_directory)" --disable-multilib LDFLAGS="-L$(makefile_directory)/lib64" --with-gmp="$(makefile_directory)" --with-mpfr="$(makefile_directory)" --with-mpc="$(makefile_directory)"
	touch .dependencies/gcc-10.2.0/Makefile

.dependencies/gcc-10.2.0/configure: .dependencies/gcc-10.2.0.tar.gz
	cd .dependencies && tar xzf gcc-10.2.0.tar.gz
	touch .dependencies/gcc-10.2.0/configure

.dependencies/gcc-10.2.0.tar.gz: makefile | .dependencies 
	cd .dependencies && wget -N https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.gz && touch gcc-10.2.0.tar.gz


#
# binutils: https://ftp.gnu.org/gnu/binutils/binutils-2.36.tar.gz
#
bin/ld: .dependencies/binutils-2.36/ld | bin lib64
	cd .dependencies/binutils-2.36 && make install
	touch bin/binutils

.dependencies/binutils-2.36/ld: .dependencies/binutils-2.36/Makefile
	cd .dependencies/binutils-2.36 && make -j $(MAXIMUM_CPUS) && touch ld

.dependencies/binutils-2.36/Makefile: .dependencies/binutils-2.36/configure
	cd .dependencies/binutils-2.36 && ./configure --prefix="$(makefile_directory)"
	touch .dependencies/binutils-2.36/Makefile
	   
.dependencies/binutils-2.36/configure: .dependencies/binutils-2.36.tar.gz
	cd .dependencies && tar xzf binutils-2.36.tar.gz && touch binutils-2.36/configure
	
.dependencies/binutils-2.36.tar.gz: makefile | .dependencies
	cd .dependencies && wget -N https://ftp.gnu.org/gnu/binutils/binutils-2.36.tar.gz && touch binutils-2.36.tar.gz


#
# gmp: https://gmplib.org/download/gmp/gmp-6.2.1.tar.xz
#
lib64/libgmp.a: .dependencies/gmp-6.2.1/libgmp.la | lib64 include
	cd .dependencies/gmp-6.2.1 && make install
	touch lib64/libgmp.a

.dependencies/gmp-6.2.1/libgmp.la: .dependencies/gmp-6.2.1/Makefile
	cd .dependencies/gmp-6.2.1 && make -j $(MAXIMUM_CPUS) && touch libgmp.la
	
.dependencies/gmp-6.2.1/Makefile: .dependencies/gmp-6.2.1/configure
	cd .dependencies/gmp-6.2.1 && ./configure --prefix="$(makefile_directory)"
	touch .dependencies/gmp-6.2.1/Makefile

.dependencies/gmp-6.2.1/configure: .dependencies/gmp-6.2.1.tar.xz
	cd .dependencies && tar xJf gmp-6.2.1.tar.xz
	touch .dependencies/gmp-6.2.1/configure

.dependencies/gmp-6.2.1.tar.xz: makefile | .dependencies 
	cd .dependencies && wget -N https://gmplib.org/download/gmp/gmp-6.2.1.tar.xz && touch gmp-6.2.1.tar.xz
	   
#
# mpc: http://www.multiprecision.org/downloads/mpc-1.2.0.tar.gz
#
lib64/libmpc.a: .dependencies/mpc-1.2.0/libmpc.la | lib64 include
	cd .dependencies/mpc-1.2.0 && make install
	touch lib64/libmpc.a

.dependencies/mpc-1.2.0/libmpc.la: .dependencies/mpc-1.2.0/Makefile
	cd .dependencies/mpc-1.2.0 && make -j $(MAXIMUM_CPUS) && touch libmpc.la
	
.dependencies/mpc-1.2.0/Makefile: .dependencies/mpc-1.2.0/configure lib64/libmpfr.a
	cd .dependencies/mpc-1.2.0 && ./configure --prefix="$(makefile_directory)" CFLAGS="-I$(makefile_directory)/include" LDFLAGS="-L$(makefile_directory)/lib64"
	touch .dependencies/mpc-1.2.0/Makefile

.dependencies/mpc-1.2.0/configure: .dependencies/mpc-1.2.0.tar.gz
	cd .dependencies && tar xzf mpc-1.2.0.tar.gz
	touch .dependencies/mpc-1.2.0/configure

.dependencies/mpc-1.2.0.tar.gz: makefile | .dependencies 
	cd .dependencies && wget -N http://www.multiprecision.org/downloads/mpc-1.2.0.tar.gz && touch mpc-1.2.0.tar.gz


#
# mpfr: https://www.mpfr.org/mpfr-current/mpfr-4.1.0.tar.gz
#
lib64/libmpfr.a: .dependencies/mpfr-4.1.0/libmpfr.la | lib64 include
	cd .dependencies/mpfr-4.1.0 && make install
	touch lib64/libmpfr.a

.dependencies/mpfr-4.1.0/libmpfr.la: .dependencies/mpfr-4.1.0/Makefile
	cd .dependencies/mpfr-4.1.0 && make -j $(MAXIMUM_CPUS) && touch libmpfr.la
	
.dependencies/mpfr-4.1.0/Makefile: .dependencies/mpfr-4.1.0/configure lib64/libgmp.a 
	cd .dependencies/mpfr-4.1.0 && ./configure --prefix="$(makefile_directory)" CFLAGS="-I$(makefile_directory)/include" LDFLAGS="-L$(makefile_directory)/lib64"
	touch .dependencies/mpfr-4.1.0/Makefile

.dependencies/mpfr-4.1.0/configure: .dependencies/mpfr-4.1.0.tar.gz
	cd .dependencies && tar xzf mpfr-4.1.0.tar.gz
	touch .dependencies/mpfr-4.1.0/configure

.dependencies/mpfr-4.1.0.tar.gz: makefile | .dependencies 
	cd .dependencies && wget -N https://ftp.gnu.org/gnu/mpfr/mpfr-4.1.0.tar.gz && touch mpfr-4.1.0.tar.gz
	   
	   
#
# texinfo: http://ftp.gnu.org/gnu/texinfo/texinfo-6.7.tar.gz
#
bin/info: .dependencies/texinfo-6.7/info | bin lib64
	cd .dependencies/texinfo-6.7 && make install
	touch bin/info

.dependencies/texinfo-6.7/info: .dependencies/texinfo-6.7/Makefile
	cd .dependencies/texinfo-6.7 && make -j $(MAXIMUM_CPUS) && touch info

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
lib64/libisl.a: .dependencies/isl-0.23/libisl.la | lib64 include
	cd .dependencies/isl-0.23 && make install
	touch lib64/libisl.a

.dependencies/isl-0.23/libisl.la: .dependencies/isl-0.23/Makefile
	cd .dependencies/isl-0.23 && make -j $(MAXIMUM_CPUS) && touch libisl.la
	
.dependencies/isl-0.23/Makefile: .dependencies/isl-0.23/configure lib64/libgmp.a
	cd .dependencies/isl-0.23 && ./configure --prefix="$(makefile_directory)" CPPFLAGS="-I$(makefile_directory)/include" LDFLAGS="-L$(makefile_directory)/lib64"
	touch .dependencies/isl-0.23/Makefile

.dependencies/isl-0.23/configure: .dependencies/isl-0.23.tar.gz
	cd .dependencies && tar xzf isl-0.23.tar.gz
	touch .dependencies/isl-0.23/configure

.dependencies/isl-0.23.tar.gz: makefile | .dependencies 
	cd .dependencies && wget -N http://isl.gforge.inria.fr/isl-0.23.tar.gz && touch isl-0.23.tar.gz
	   

#
# automake: http://ftp.gnu.org/gnu/automake/automake-1.5.tar.gz
#
bin/automake: .dependencies/automake-1.5/automake | bin
	cd .dependencies/automake-1.5 && make install
	touch bin/automake
	hash -r

.dependencies/automake-1.5/automake: .dependencies/automake-1.5/Makefile
	cd .dependencies/automake-1.5 && make -j $(MAXIMUM_CPUS) && touch info

.dependencies/automake-1.5/Makefile: .dependencies/automake-1.5/configure
	cd .dependencies/automake-1.5 && ./configure --prefix="$(makefile_directory)" 
	touch .dependencies/automake-1.5/Makefile
	   
.dependencies/automake-1.5/configure: .dependencies/automake-1.5.tar.gz # bin/libtool
	cd .dependencies && tar xzf automake-1.5.tar.gz && touch automake-1.5/configure
	
.dependencies/automake-1.5.tar.gz: makefile | .dependencies
	cd .dependencies && wget -N http://ftp.gnu.org/gnu/automake/automake-1.5.tar.gz && touch automake-1.5.tar.gz
	   


#
# libtool: http://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.gz
#
bin/libtool: .dependencies/libtool-2.4.6/libtool | bin
	cd .dependencies/libtool-2.4.6 && make install
	touch bin/libtool
	hash -r

.dependencies/libtool-2.4.6/libtool: .dependencies/libtool-2.4.6/Makefile
	cd .dependencies/libtool-2.4.6 && make -j $(MAXIMUM_CPUS) && touch info

.dependencies/libtool-2.4.6/Makefile: .dependencies/libtool-2.4.6/configure
	cd .dependencies/libtool-2.4.6 && ./configure --prefix="$(makefile_directory)" 
	touch .dependencies/libtool-2.4.6/Makefile
	   
.dependencies/libtool-2.4.6/configure: .dependencies/libtool-2.4.6.tar.gz bin/libtool
	cd .dependencies && tar xzf libtool-2.4.6.tar.gz && touch libtool-2.4.6/configure
	
.dependencies/libtool-2.4.6.tar.gz: makefile | .dependencies
	cd .dependencies && wget -N http://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.gz && touch libtool-2.4.6.tar.gz
	   


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
	
lib64:
	@-mkdir -p lib64
	@-ln -s lib64 lib

src:
	@-mkdir -p src


clean:
	rm -rf .dependencies bin include info lib libexec lib64 share x86_64-pc-linux-gnu
