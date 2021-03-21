SHELL = /bin/bash

directory_containing_this_makefile=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: full incremental
full incremental: .cache/graalvm-ce-java8-19.3.2/
	@printf "\nExecuting target: all\n"

.cache/graalvm-ce-java8-19.3.2/: .cache/graalvm-ce-java8-linux-amd64-19.3.2.tar.gz
	cd .cache; tar xfz .cache/graalvm-ce-java8-linux-amd64-19.3.2.tar.gz
	rm -rf .cache/graalvm-ce-java8-19.3.2/samples

.cache/:
	mkdir .cache

.cache/graalvm-ce-java8-linux-amd64-19.3.2.tar.gz: .cache/     # need a dependency here for https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-19.3.2/graalvm-ce-java8-linux-amd64-19.3.2.tar.gz
	cd .cache\
	   && wget -N https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-19.3.2/graalvm-ce-java8-linux-amd64-19.3.2.tar.gz\
	   && touch graalvm-ce-java8-linux-amd64-19.3.2.tar.gz

.PHONY: clean
clean: $(subdirs)
	rm -rf lib/*
	rm -rf src/.deps/
	rm -rf src/.libs/
	rm -rf src/autom4te.cache/
	rm -rf src/config/
	rm -rf src/m4/
	rm -f src/Makefile
	rm -f src/Makefile.in
	rm -f src/aclocal.m4
	rm -f src/config.log
	rm -f src/config.status
	rm -f src/configure
	rm -f src/*.la
	rm -f src/*.lo
	rm -f src/*.o
	rm -f src/libtool

