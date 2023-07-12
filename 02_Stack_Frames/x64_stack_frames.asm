; x64 assembler program for viewing the stack frames usage.

; Generate the object code file:
; yasm -f elf64 -g dwarf2 x64_stack_frames.asm -l x64_stack_frames.lst

; Generate an executable file within an object file:
; ld -o x64_stack_frames.out x64_stack_frames.o

// #######################################################################################
// Data section, initialized variables.
// #######################################################################################

section .data
    func_1_string: db "Function 1", 0xA, 0
    func_1_string_len: equ $-func_1_string
    func_2_string: db "Function 2", 0xA, 0
    func_2_string_len: equ $-func_2_string_len

// #######################################################################################
// _start (int agrc, char* argv[]) -> Entrypoint.
// #######################################################################################

section .text
global _start
_start:
    ; Function prologue
    push rbp
    mov rbp, rsp

    mov edi, 1
    call func_1

    ; Function epilogue.
    ; --------------------------------------------
    
    mov rsp, rbp
    pop rbp

    ; Perform a gracefull exit with the exit syscall
    ; --------------------------------------------

    mov eax, 60 ; exit system call
    xor edi, edi ; exit status code 0
    syscall

// #######################################################################################
// func_1 (int num1)
// #######################################################################################

func_1:
    ; Function prologue
    push rbp
    mov rbp, rsp
    sub rsp, 16

    ; Save parameter registers
    mov QWORD [rbp - 8], rdi

    mov rax, 1                  ; Use the write syscall.
    mov rdi, 1                  ; Use stdout (standard output stream) default 
                                ; output channel that displays the output of a command or program.
    mov rsi, func_1_string      ; Address of the string (char *)
    mov rdx, func_1_string_len  ; Size of the displayed string.

    ; Parameters needed to be passed to the following function
    mov rdi, 2
    mov rsi, 3
    call func_2

    ; Function epilogue
    ; Restore parameter registers
    mov rdi, QWORD [rbp - 8]
    add rsp, 16

    ; Function epilogue
    leave   ; Similar to:
            ; mov rsp,rbp
            ; pop rbp
    ret

// #######################################################################################
// func_2 (int num1, int num2)
// #######################################################################################

func_2:
    ; Function prologue
    push rbp
    mov rbp, rsp
    sub rsp, 16

    ; Save parameter registers
    mov QWORD [rbp - 16], rdi
    mov QWORD [rbp - 8], rsi

    ; Access function parameters
    mov rdi, QWORD [rbp + 16] ; Load the first parameter.
    mov rsi, QWORD [rbp + 24] ; Load the second parameter.

    mov rax, 1                  ; Use the write syscall.
    mov rdi, 1                  ; Use stdout (standard output stream) default 
                                ; output channel that displays the output of a command or program.
    mov rsi, func_2_string      ; Address of the string (char *)
    mov rdx, func_2_string_len  ; Size of the displayed string.

    ; Function epilogue
    ; Restore parameter registers
    mov rdi, QWORD [rbp - 16]
    mov rsi, QWORD [rbp - 8]
    add rsp, 16

    ; Function epilogue
    leave
    ret