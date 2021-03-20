SHELL = /bin/bash

# directory containing this makefile
makefile_directory=$(realpath $(dir $(firstword $(MAKEFILE_LIST))))
$(info $(makefile_directory))




.PHONY: all
all: bin/bison bin/flex lib/libgmp.a


#
# bison
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
# flex
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
# gmp
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