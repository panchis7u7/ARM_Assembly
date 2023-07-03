// ARM assembler program for viewing the stack frames usage.
// X0-X2 - parameters to Unix system calls.
// X16 - Mach System Call function number.

// Generate object code: 
// as -g -arch arm64 -o arm_stack_frames.o arm_stack_frames.asm

// Generate an executable file within an object file: 
// ld -o arm_stack_frames.out arm_stack_frames.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64

// #######################################################################################
// _start (int agrc, char* argv[]) -> Entrypoint.
// #######################################################################################

.global _start
.align 8

_start:

    // Function prologue.
    // --------------------------------------------
    stp fp, lr, [sp, #-16]!         // Save previous frame pointer and link register.
    mov fp, sp                      // Set the frame pointer to the current stack pointer.

    mov x0, #1
    bl func_1

    // Function epilogue.
    // --------------------------------------------

    mov sp, fp              // Restore the stack pointer.
    ldp fp, lr, [sp], #16   // Restore the frame pointer and link register.
    ret                     // Return from the function.

    // Gracefull exit.
    // --------------------------------------------

    // Setup the parameters to exit the program
    // and then call the Kernel to do it.

    mov X0, #0      // Use 0 return code.
    mov X16, #1     // System call number 1 terminates.
    svc #0x80       // Call kernel to terminate the program.

// #######################################################################################
// func_1 (int num1)
// #######################################################################################

.align 8
func_1:

    // Function prologue.
    // --------------------------------------------
    stp fp, lr, [sp, #-16]!         // Save previous frame pointer and link register.
    mov fp, sp                      // Set the frame pointer to the current stack pointer.
    sub sp, sp, #16                 // Allocate space on the stack for local variables.

    // Save parameter registers.
    str x0, [sp, #8]

    mov	X0, #1		                // 1 = StdOut.
	adr	X1, func_1_string           // string to print.
	mov	X2, #13	    	            // length of our string.
	mov	X16, #4		                // Unix write system call.
	svc	#0x80		                // Call kernel to output the string.

    // Parameters needed to be passed to the following function.
    mov x0, #2
    mov x1, #3 
    bl func_2

    // Function epilogue.
    // --------------------------------------------

    // Restore parameter registers.
    ldr x0, [sp, #-16]        // Restore x0 (first parameter)
    add sp, sp, #16          // Restore stack pointer for parameter registers

    mov sp, fp              // Restore the stack pointer.
    ldp fp, lr, [sp], #16   // Restore the frame pointer and link register.
    ret                     // Return from the function.

// #######################################################################################
// func_2 (int num1, int num2)
// #######################################################################################

.align 8
func_2:

    // Function prologue.
    // --------------------------------------------
    stp fp, lr, [sp, #-16]! // Save previous frame pointer and link register.
    mov fp, sp              // Set the frame pointer to the current stack pointer.
    sub sp, sp, #16         // Allocate space on the stack for local variables. <parameter_offset>

    // The function parameters are accessed using ldr instructions to load the values from 
    // the stack based on their offsets from the frame pointer (x29).
    // Replace <parameter_offset> with the appropriate offset values to access the function parameters. The offset value depends on the order and size of the parameters passed to the function.

    // Save parameter registers.
    // Why not start at 0? Because there was an empty (espacio sobrante) from the previous memory allocation,
    // since the sp need to be 16 bit aligned, this addresses for 2 availabe memory locations.
    str x0, [sp, #0]
    str x1, [sp, #8]

    // Access function parameters
    ldr x0, [fp, #0]        // Load the first parameter.
    ldr x1, [fp, #8]       // Load the second parameter.

    mov	X0, #1		                // 1 = StdOut.
	adr	X1, func_2_string           // string to print.
	mov	X2, #13	    	            // length of our string.
	mov	X16, #4		                // Unix write system call.
	svc	#0x80		                // Call kernel to output the string.

    // Function epilogue.
    // --------------------------------------------

    // Restore parameter registers.
    ldr x0, [sp, #0]                // Restore x0 (first parameter)
    ldr x1, [sp, #8]                // Restore x1 (second parameter)
    add sp, sp, #16                 // Restore stack pointer for parameter registers

    mov sp, fp              // Restore the stack pointer.
    ldp fp, lr, [sp], #16   // Restore the frame pointer and link register.
    ret                     // Return from the function.

.align 8
func_1_string:     .ascii  "Function 1\n"
.align 8
func_2_string:     .ascii  "Function 2\n"