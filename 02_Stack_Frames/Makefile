ARCH := $(shell uname -m)
CC = gcc
CFLAGS = -Wall -Wextra -pedantic -std=c11 -g

ifeq ($(ARCH), arm64)
	AS := as -g -arch arm64
	LD := ld -o arm_stack_frames.out -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64
	OBJECTS := arm_stack_frames.o
	CLEAN_TARGET := arm_clean
else
	AS := yasm -f elf64 -g dwarf2
	LD := ld -o x64_stack_frames.out
	OBJECTS := x64_stack_frames.o
	CLEAN_TARGET := x64_clean
endif

all: arm_stack_frames x64_stack_frames c_stack_frames

arm_stack_frames: $(OBJECTS)
	$(LD) $(OBJECTS)

arm_stack_frames.o: arm_stack_frames.asm
	$(AS) -o arm_stack_frames.o arm_stack_frames.asm

x64_stack_frames: $(OBJECTS)
	$(LD) $(OBJECTS)

x64_stack_frames.o: x64_stack_frames.asm
	$(AS) -o x64_stack_frames.o x64_stack_frames.asm

c_stack_frames: c_stack_frames.o
	$(CC) $(CFLAGS) -o $@.out $<

c_stack_frames.o: c_stack_frames.c
	$(CC) $(CFLAGS) -o $@ $<

clean: $(CLEAN_TARGET)
	rm -f c_stack_frames.o c_stack_frames.out 
	rm -r c_stack_frames.o.dSYM

arm_clean:
	rm -f arm_stack_frames.out arm_stack_frames.o 
	
x64_clean:
	rm -f x64_stack_frames.out x64_stack_frames.o x64_stack_frames.lst 