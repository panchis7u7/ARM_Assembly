CC = gcc
CFLAGS = -arch arm64 -Wall -Wextra -pedantic -std=c11 -g

linked_list: linked_list.o
	$(CC) $(CFLAGS) $^ -o $@.out

linked_list.o: linked_list.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f linked_list.o linked_list.out 
	rm -r linked_list.o.dSYM