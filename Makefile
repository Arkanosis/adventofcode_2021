YEAR=2021

DAYS = \
  01 \
  02 \

define RUNDAY
	./$(1).1
	./$(1).2

endef

.PHONY: all

all: $(foreach day, $(DAYS), $(day).1 $(day).2 $(day).input)
	$(foreach day, $(DAYS), $(call RUNDAY,$(day)))

%.input: .session-cookie
	curl -s --compressed "https://adventofcode.com/$(YEAR)/day/$$(echo $* | sed 's/^0//')/input" -H "Cookie: session=$$(cat .session-cookie)" > "$@"

01.%: 01.%.hs
	 ghc -dynamic "$<" -o "$@"

02.%: 02.%.asm
	nasm -f elf64 "$<"
	ld "$@.o" -o "$@"
