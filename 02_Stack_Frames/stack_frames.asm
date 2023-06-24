// Assembler program for viewing the stack frames usage.
// X0-X2 - parameters to Unix system calls.
// X16 - Mach System Call function number.

// Generate object code: 
// as -arch arm64 -o stack_frames.o stack_frames.s

// Generate an executable file within an object file: 
// ld -o stack_frames stack_frames.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64

.global _start
.align 4

_start:

    bl hello_world

    // Setup the parameters to exit the program
    // and then call the Kernel to do it.

	mov X0, #0      // Use 0 return code.
    mov X16, #1     // System call number 1 terminates.
    svc #0x80       // Call kernel to terminate the program.

hello_world:

    // Function prologue.
    // --------------------------------------------
    stp fp, lr, [sp, #-16]! // Save previous frame pointer and link register.
    mov fp, sp              // Set the frame pointer to the current stack pointer.
    // sub sp, sp, #<stack_size> // Allocate space on the stack for local variables.

    mov	X0, #1		    // 1 = StdOut.
	adr	X1, helloworld 	// string to print.
	mov	X2, #13	    	// length of our string.
	mov	X16, #4		    // Unix write system call.
	svc	#0x80		    // Call kernel to output the string.

    // Function epilogue.
    // --------------------------------------------

    mov sp, fp              // Restore the stack pointer.
    ldp fp, lr, [sp], #16   // Restore the frame pointer and link register.
    ret                     // Return from the function.


helloworld:      .ascii  "Hello World!\n"