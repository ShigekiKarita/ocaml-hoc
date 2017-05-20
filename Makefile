OCB_FLAGS   = -use-ocamlfind -use-menhir -I src

# -I src -I lib # uses menhir

OCB = 		ocamlbuild $(OCB_FLAGS)

all: 		native byte # profile debug

clean:
			$(OCB) -clean

native:  	sanity
			$(OCB) main.native

byte: 		sanity
			$(OCB) main.byte

profile: 	sanity
			$(OCB) -tag profile main.native

debug: 		sanity
			$(OCB) -tag debug main.byte

sanity:
			# check that menhir is installed, use "opam install menhir"
			which menhir

test: 		native
			./main.native "2 + 3 * 3"
			./test.sh

.PHONY: all clean byte native profile debug sanity test

