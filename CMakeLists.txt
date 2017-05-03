cmake_minimum_required(VERSION 3.1.0)
project(LFSR)

message(STATUS "${CMAKE_MODULE_PATH}")
#Add NASM
enable_language(ASM_NASM)
#set(CMAKE_ASM_NASM_LINK_EXECUTABLE "ld <FLAGS> <CMAKE_ASM_NASM_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  -o <TARGET> <LINK_LIBRARIES>")

#Set executable
#add_executable(main main.c LFSR.asm) Fix nasm
add_executable(main main.c)

target_link_libraries (main m)
