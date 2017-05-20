OCB_FLAGS = -use-ocamlfind -use-menhir -I src
OCB = ocamlbuild $(OCB_FLAGS)


all: native byte # profile debug

clean:
	$(OCB) -clean

native:  	sanity
	$(OCB) main.native

byte: sanity
	$(OCB) main.byte

profile: 	sanity
	$(OCB) -tag profile main.native

debug: sanity
	$(OCB) -tag debug main.byte

sanity:
	which menhir

test: native
	./test.sh

.PHONY: all clean byte native profile debug sanity test

