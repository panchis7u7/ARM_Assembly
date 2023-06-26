; x64 assembler program for viewing the stack frames usage.

; Generate the object code file:
; yasm -f elf64 -g dwarf2 x64_stack_frames.asm -l x64_stack_frames.lst

; Generate an executable file within an object file:
; ld -o x64_stack_frames.out x64_stack_frames.o

section .data
    out_string: db "Hello World!",0xA,0
    out_string_len: equ $-out_string

section .text
global _start

_start:

    call hello_world

    mov rax, 60
    mov rdi, 0x0
    syscall

ret

hello_world:
    
    ; Function prologue.
    ; --------------------------------------------

    push rbp                    ; Save previous stack pointer to the stack.
    mov rbp, rsp                ; Move the current stack position (return address) to rbp.

    mov rax, 1                  ; Use the write syscall.
    mov rdi, 1                  ; Use stdout (standard output stream) default 
                                ; output channel that displays the output of a command or program.
    mov rsi, out_string         ; Address of the string (char *)
    mov rdx, out_string_len     ; Size of the displayed string.
    syscall

    ; Function epilogue.
    ; --------------------------------------------

    leave   ; Similar to:
            ; mov rsp,rbp
            ; pop rbp
    ret