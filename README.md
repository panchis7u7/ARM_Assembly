# C and Assembly Training - x64 and ARM
This repository provides training materials for learning C and Assembly programming for x64 and ARM architectures. It covers fundamental concepts, coding examples, and debugging techniques using GDB (for x64) and LLDB (for ARM).

Prerequisites
Before starting this training, make sure you have the following prerequisites:

* Basic knowledge of the C programming language.
* Familiarity with computer architecture concepts.
* A system running an x64 or ARM-based processor (MacOS)(depending on the architecture you want to learn)
* GDB installed for x64 architecture.
* LLDB installed for ARM architecture.
Contents

This training repository consists of the following components:

+ **C Programming:** Introduction to C programming language, data types, control flow, functions, and memory management.

+ **Assembly Language:** Introduction to Assembly language for x64 and ARM architectures, including instruction sets, registers, memory access, and function calling conventions.

+ **Debugging with GDB:** A comprehensive guide on using GDB (GNU Debugger) for x64 architecture. It covers setting breakpoints, examining variables and memory, stepping through code, and handling common debugging scenarios.

+ **Debugging with LLDB:** A detailed tutorial on using LLDB (LLVM Debugger) for ARM architecture. It covers similar topics as GDB, tailored specifically for ARM-based systems.

## Getting Started
To get started with this training, follow these steps:

Clone this repository to your local machine:

```bash
git clone https://github.com/your-username/c-assembly-training.git
```

#### For MacOS:
Install the homebrew package manager: https://brew.sh/
Install binutils from the terminal: 
```bash
brew update && brew install binutils
```

If you need to have binutils first in your PATH, run:
```bash
echo 'export PATH="/opt/homebrew/opt/binutils/bin:$PATH"' >> ~/{.zshrc|.bashrc}
````

For compilers to find binutils you may need to set:
```bash
export LDFLAGS="-L/opt/homebrew/opt/binutils/lib”
export CPPFLAGS="-I/opt/homebrew/opt/binutils/include"
```

#### For Windows:
Install mingw64: https://sourceforge.net/projects/mingw-w64/, this contains some unix executables (grep) and compiler toolchains (gcc, g++)

Practice the coding examples and exercises provided in the repository to reinforce your understanding.

## Resources
+ [GNU AS Assembler Guide.](https://ftp.gnu.org/old-gnu/Manuals/gas-2.9.1/html_chapter/as_toc.html)
+ [Armv8-A Instruction Set Architecture.](https://developer.arm.com/-/media/Arm%20Developer%20Community/PDF/Learn%20the%20Architecture/Armv8-A%20Instruction%20Set%20Architecture.pdf?revision=ebf53406-04fd-4c67-a485-1b329febfb3e)
+ [Arm Architecture Reference Manual for A-profile architecture.](https://developer.arm.com/documentation/ddi0487/ja/?lang=en)
+ [LLDB Tutorial.](https://lldb.llvm.org/use/tutorial.html)
+ [LLDB TUI (Text User Interface) Guide.](http://peeterjoot.com/2019/08/26/the-lldb-tui-text-user-interface/)
+ [GDB to LLDB command map.](https://lldb.llvm.org/use/map.html)
+ [Microsoft x64 Calling Convention.](https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention?view=msvc-170)
+ [Compiler Explorer.](https://godbolt.org/)


Contributions
Contributions to this training repository are welcome. If you find any issues, have suggestions for improvements, or would like to contribute additional materials, please feel free to submit a pull request.