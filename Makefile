LIBS=-lm
CC=gcc
.PHONY: all main asm_io.o LFSR.o clean

main: asm_io.o LFSR.o
	gcc -m32 main.c asm_io.o LFSR.o -o main $(LIBS)

asm_io.o:
	nasm -f elf32 -d ELF_TYPE asm_io.asm

LFSR.o:
	nasm -f elf32 -d ELF_TYPE LFSR.asm
