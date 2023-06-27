# ARM MacOS:
<hr />

Compile the program (Generate Object code):
```zsh
as -g -arch arm64 -o arm_stack_frames.o arm_stack_frames.asm
```

Combine object code with required supporting code to make an executable program. (Linking):
```zsh
ld -o arm_stack_frames.out arm_stack_frames.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64
``` 

If you have the Make utility installed you can perform the compilation and linking stages with one command:
```zsh
make
```

Load the program into LLDB.
```zsh
lldb ./arm_stack_frames.out
```

##  LLDB setup
Prepare for debugging.

Load the executable binary:
```lldb
target create arm_stack_frames.out
````

Set the breakpoints:
```lldb
b start
b func_1
b func_2
````

Run the debugging:
```lldb
run
```

You can print the general purpose registers with:
```lldb
register read
```

Get the location of the current frame in code:
```lldb
frame info
```

To next step the debugger:
```lldb
n
```

Get a glimpse of the source code:
```
list
```

Read the contents of a particular memory address:
```lldb
 memory read -s<grouping_bytes> -f<format> -c<byte_count> <address> {--force}
```

+ -s for bytes grouping so use 1 for uint8 for example and 4 for int
+ -f for format. I inherently forget the right symbol. Just put the statement with -f and it will snap back at you and give you the list of all the options
+ -c is for count of bytes
+ if you are printing more than 1024 bytes, append with --force

To specify the desired format, you can use the following options:

* Hexadecimal format: x
* Decimal format: d
* Floating-point format: f
* Character format: c
* Binary format: b
* ASCII format: s

To read the value for a set of registers
```lldb
(lldb) register read <reg1 reg2 ...>
```

To print the disassembled code of a function from a hexadecimal address in LLDB, you can use the disassemble command with the address range of the function.
```lldb
(lldb) disassemble --start-address <start_address> --end-address <end_address>
```

If you have a specific function address, you can disassemble the function by providing the start address and an appropriate end address. One way to determine the end address is by examining the symbol table. This command will display information about the symbol at the given address, including the symbol name and the end address.
```lldb
(lldb) image lookup --address <start_address>
```

With the start and end addresses known, you can then disassemble the function using the disassemble command. LLDB will then print the disassembled code of the function, showing the assembly instructions at the specified address range.
```lldb
(lldb) disassemble --start-address <start_address> --end-address <end_address>
```