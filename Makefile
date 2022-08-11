EXE	= hpss.gbc

SOURCES	= $(wildcard src/*.asm)
OBJECTS	= $(SOURCES:src/%.asm=obj/%.o)

DIRS	= obj

default:	$(DIRS) $(EXE)

$(DIRS):
	-mkdir -p $@

$(EXE):		$(OBJECTS)
	rgblink -o $@ $^
	rgbfix --color-only \
       --ram-size 0x02 \
       --old-license 0x33 \
       --new-license "69" \
       --mbc-type 0x1B \
       --rom-version 0x00 \
       --non-japanese \
       --title "HARRYPOTTER" \
       --game-id "BHVE" \
       --validate \
       --pad-value 0xFF $@

obj/%.o:	src/%.asm
	rgbasm --halt-without-nop --preserve-ld --export-all --output $@ -M $(EXE).d $^

.PHONY:		clean
clean:
	-rm -rvf $(DIRS) $(EXE) $(EXE).d
