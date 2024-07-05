install: all
	mv exitcodes banner ~/bin/ && cd thirdparty && $(MAKE)

all: exitcodes banner

clean:
	$(RM) $(wildcard *.o) exitcodes banner

.PHONY: clean install
