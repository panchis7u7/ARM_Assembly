#include <stdio.h>
#include <stdlib.h> 

void func_1(long num);
void func_2(long num1, long num2);

int main(int argc, char* argv[]) { // -> Start.
    (void)argc;
    (void)argv;

    func_1(1);

    // Gracefull exit.
    // --------------------------------------------
    return 0;
}

void func_1(long num1) {
    (void)num1;
    printf("Function 1\n");
    func_2(2,3);
}

void func_2(long num1, long num2) {
    (void)num1;
    (void)num2;
    printf("Function 2\n");
}
