#include <stdio.h>
#include <stdlib.h>

// Compile with "gcc main.c -ggdb -o elf_format.out"
// For llvm gcc main.c -g -o elf_format.out
// For macos, otool -l elf_format.out
// Load to GDB: gdb elf_format.out
int main(int argc, char* argv[]) {
    printf("Hello World!");
    return 0;
}