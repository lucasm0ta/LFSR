LIBS=-lm
CC=gcc
.PHONY: all main asm_io.o LFSR.o clean # Sempre recompila quando executa o comando make.

main: asm_io.o LFSR.o # Compila o programa em C ligando todas as dependencias
	gcc -m32 main.c asm_io.o LFSR.o -o main $(LIBS)

asm_io.o: # Compila a biblioteca de entrada e saída do Paul Carter
	nasm -f elf32 -d ELF_TYPE asm_io.asm

LFSR.o: # Compila o LFSR desenvolvido em nasm
	nasm -f elf32 -d ELF_TYPE LFSR.asm
