OS := $(shell uname)

ifeq ($(OS), Darwin)
	OSXCPUTEMP_BUILD := cd osx-cpu-temp && $(MAKE) && ln -sf ~/bin/thirdparty/osx-cpu-temp/osx-cpu-temp ~/bin
	IPROUTE2MAC_BUILD := ln -sf ~/bin/thirdparty/iproute2mac/src/ip.py ~/bin/ip
else
	OSXCPUTEMP_BUILD := echo "Skipping osxcputemp"
	IPROUTE2MAC_BUILD := echo "Skipping iproute2mac"
endif

all: htmlparser osxcputemp iproute2mac

htmlparser:
	cd htmlparser && go build

osxcputemp:
	$(OSXCPUTEMP_BUILD)

iproute2mac:
	$(IPROUTE2MAC_BUILD)

.PHONY: htmlparser sack osxcputemp iproute2mac
