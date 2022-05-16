OS := $(shell uname)

ifeq ($(OS), Darwin)
	OSXCPUTEMP_BUILD := cd osx-cpu-temp && $(MAKE) && ln -sf ~/bin/src/thirdparty/osx-cpu-temp/osx-cpu-temp ~/bin
	IPROUTE2MAC_BUILD := ln -sf ~/bin/src/thirdparty/iproute2mac/src/ip.py ~/bin/ip
else
	OSXCPUTEMP_BUILD := @echo "Skipping osxcputemp"
	IPROUTE2MAC_BUILD := @echo "Skipping iproute2mac"
endif

all: checkout htmlparser osxcputemp iproute2mac

checkout:
	git submodule update --init

htmlparser:
	test -x ~/bin/htmlparser || (cd htmlparser && go build && ln -s ~/bin/thirdparty/htmlparser ~/bin)

osxcputemp:
	$(OSXCPUTEMP_BUILD)

iproute2mac:
	$(IPROUTE2MAC_BUILD)

.PHONY: htmlparser sack osxcputemp iproute2mac
