SHELL = /bin/bash

# directory containing this makefile
makefile_directory=$(realpath $(dir $(firstword $(MAKEFILE_LIST))))
$(info $(makefile_directory))


.PHONY: all
all: bin/bison

bin/bison: .dependencies/bison-3.7/src/bison
	cd .dependencies/bison-3.7 && make install

.dependencies/bison-3.7/src/bison: .dependencies/bison-3.7 bin
	cd .dependencies/bison-3.7 && ./configure --prefix="$(makefile_directory)"
	touch .dependencies/bison-3.7/
	cd .dependencies/bison-3.7 && make

.dependencies/bison-3.7: .dependencies bin makefile
	cd .dependencies\
	   && wget -N http://ftp.gnu.org/gnu/bison/bison-3.7.tar.gz\
	   && touch bison-3.7.tar.gz\
	   && tar xzf bison-3.7.tar.gz
	   
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