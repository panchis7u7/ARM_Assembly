#include <stdio.h>
#include <stdlib.h>

// Compile with "gcc main.c -ggdb -o elf_format.out"
// For llvm gcc formats.c -g -o formats.out
// For macos, otool -l formats.out
// Load to GDB: gdb formats.out
int main(int argc, char* argv[]) {
    printf("Hello World!");
    return 0;
}