OS := $(shell uname)

ifeq ($(OS), Darwin)
	OSX_SMCTEMP_BUILD := cd smctemp && $(MAKE) && ln -sf ~/bin/src/thirdparty/smctemp/smctemp ~/bin
else
	OSX_SMCTEMP_BUILD := @echo "Skipping smctemp"
endif

all: checkout smctemp sack

checkout:
	git submodule update --init

smctemp:
	$(OSX_SMCTEMP_BUILD)

sack:
	for binary in sag sack sgrep srg ; do \
		cd ~/bin; ln -sf ./src/thirdparty/sack/$$binary . ; cd - ; \
	done

.PHONY: sack smctemp
