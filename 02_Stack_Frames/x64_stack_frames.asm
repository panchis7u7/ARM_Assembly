; x64 assembler program for viewing the stack frames usage.

; Generate the object code file:
; yasm -f elf64 -g dwarf2 x64_stack_frames.asm -l x64_stack_frames.lst

; Generate an executable file within an object file:
; ld -o x64_stack_frames.out x64_stack_frames.o

section .data
    func_1_string: db "Function 1",0xA,0
    func_1_string_len: equ $-func_1_string
    func_2_string: db "Function 2",0xA,0
    func_2_string_len: equ $-func_2_string_len

section .text
global _start

_start:

    mov rdi, 1          ; Pass a parameter to the func_1 function.
    call func_1         ; Call the function.

    mov rax, 60
    mov rdi, 0x0
    syscall

ret

func_1:
    
    ; Function prologue.
    ; --------------------------------------------

    push rbp                    ; Save previous stack pointer to the stack.
    mov rbp, rsp                ; Move the current stack position (return address) to rbp.

    sub rsp, 8                  ; Calculate the offset from RBP (frame pointer) for the parameter.
    mov rax, rdi                ; Move the parameter value from the appropriate register to a general-purpose register (e.g., RAX).

    mov qword [rbp-16], rax     ; Assuming parameter offset is -16 from RBP.

    mov rax, 1                  ; Use the write syscall.
    mov rdi, 1                  ; Use stdout (standard output stream) default 
                                ; output channel that displays the output of a command or program.
    mov rsi, func_1_string      ; Address of the string (char *)
    mov rdx, func_1_string_len  ; Size of the displayed string.

    syscall

    ; Function epilogue.
    ; --------------------------------------------

    leave   ; Similar to:
            ; mov rsp,rbp
            ; pop rbp
    ret

