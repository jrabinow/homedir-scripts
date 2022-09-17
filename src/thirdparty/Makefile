OS := $(shell uname)

ifeq ($(OS), Darwin)
	OSXCPUTEMP_BUILD := cd osx-cpu-temp && $(MAKE) && ln -sf ~/bin/src/thirdparty/osx-cpu-temp/osx-cpu-temp ~/bin
else
	OSXCPUTEMP_BUILD := @echo "Skipping osxcputemp"
endif

all: checkout osxcputemp sack

checkout:
	git submodule update --init

osxcputemp:
	$(OSXCPUTEMP_BUILD)

sack:
	for binary in sag sack sgrep srg ; do \
		cd ~/bin; ln -sf ./src/thirdparty/sack/$$binary . ; cd - ; \
	done

.PHONY: sack osxcputemp
