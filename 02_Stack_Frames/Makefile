arm_stack_frames: arm_stack_frames.o
	ld -o arm_stack_frames.out arm_stack_frames.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64

arm_stack_frames.o: arm_stack_frames.asm
	as -g -arch arm64 -o arm_stack_frames.o arm_stack_frames.asm