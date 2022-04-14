OS := $(shell uname)

ifeq ($(OS), Darwin)
	OSXCPUTEMP_BUILD := cd osx-cpu-temp && $(MAKE) && ln -sf ~/bin/src/thirdparty/osx-cpu-temp/osx-cpu-temp ~/bin
else
	OSXCPUTEMP_BUILD := @echo "Skipping osxcputemp"
endif

all: checkout htmlparser osxcputemp

checkout:
	git submodule update --init

htmlparser:
	test -x ~/bin/htmlparser || (cd htmlparser && go build && ln -s ~/bin/thirdparty/htmlparser ~/bin)

osxcputemp:
	$(OSXCPUTEMP_BUILD)

.PHONY: htmlparser sack osxcputemp
