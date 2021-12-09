YEAR=2021

DAYS = \
  01 \
  02 \
  03 \

define RUNDAY
	./$(1).1
	./$(1).2

endef

.PHONY: all clean

all: $(foreach day, $(DAYS), $(day).1 $(day).2 $(day).input)
	$(foreach day, $(DAYS), $(call RUNDAY,$(day)))

clean:
	rm -f *.hi *.cf *.o *.1 *.2

%.input: .session-cookie
	curl -s --compressed "https://adventofcode.com/$(YEAR)/day/$$(echo $* | sed 's/^0//')/input" -H "Cookie: session=$$(cat .session-cookie)" > "$@"

01.%: 01.%.hs
	 ghc -dynamic "$<" -o "$@"

02.%: 02.%.asm
	nasm -f elf64 "$<"
	ld "$@.o" -o "$@"

03.%: 03.%.vhdl
	ghdl -a --std=08 --work=aoc_03_1 "$<"
	ghdl -e --std=08 --work=aoc_03_1 -o "$@" aoc_03_1
