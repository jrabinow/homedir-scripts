all: exitcodes banner

install:
	mv exitcodes banner ~/bin/ && cd thirdparty && $(MAKE)

clean:
	$(RM) $(wildcard *.o) exitcodes banner

.PHONY: clean install
