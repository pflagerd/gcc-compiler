SHELL = /bin/bash

# directory containing this makefile
makefile_directory=$(realpath $(dir $(firstword $(MAKEFILE_LIST))))
$(info $(makefile_directory))




.PHONY: all
all: bin/flex

bin/flex: bin/bison



#
# bison
#
bin/bison: .dependencies/bison-3.7/src/bison bin
	cd .dependencies/bison-3.7 && make install
	touch bin/bison

.dependencies/bison-3.7/src/bison: .dependencies/bison-3.7/Makefile
	cd .dependencies/bison-3.7 && make

.dependencies/bison-3.7/Makefile: .dependencies/bison-3.7/configure
	cd .dependencies/bison-3.7 && ./configure --prefix="$(makefile_directory)" 
	   
.dependencies/bison-3.7/configure: .dependencies/bison-3.7.tar.gz
	cd .dependencies && tar xzf bison-3.7.tar.gz && touch bison-3.7 && touch bison-3.7/configure
	

.dependencies/bison-3.7.tar.gz: .dependencies makefile
	cd .dependencies && wget -N http://ftp.gnu.org/gnu/bison/bison-3.7.tar.gz && touch bison-3.7.tar.gz

	   
#
# flex
#
bin/flex: .dependencies/flex-2.6.3/src/flex bin
	cd .dependencies/flex-2.6.3 && make install

.dependencies/flex-2.6.3/src/flex: .dependencies/flex-2.6.3/Makefile
	cd .dependencies/flex-2.6.3 && make
	
.dependencies/flex-2.6.3/Makefile: .dependencies/flex-2.6.3/configure
	cd .dependencies/flex-2.6.3 && ./configure --prefix="$(makefile_directory)" && touch Makefile

.dependencies/flex-2.6.3/configure: .dependencies/flex-2.6.3
	cd .dependencies/flex-2.6.3 && ./autogen.sh && touch configure

.dependencies/flex-2.6.3: .dependencies/flex-2.6.3.tar.gz
	cd .dependencies && tar xzf flex-2.6.3.tar.gz && touch flex-2.6.3/

.dependencies/flex-2.6.3.tar.gz: .dependencies makefile
	cd .dependencies && wget -N https://github.com/westes/flex/releases/download/v2.6.3/flex-2.6.3.tar.gz && touch flex-2.6.3.tar.gz
	   



#
# Directories
#
.dependencies:
	@-mkdir .dependencies

bin:
	@-mkdir -p bin
	
doc:
	@-mkdir -p doc
	
lib:
	@-mkdir -p lib

src:
	@-mkdir -p src


clean:
	rm -rf .dependencies