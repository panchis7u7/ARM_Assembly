CC = gcc
CFLAGS = -arch arm64 -Wall -Wextra -pedantic -std=c11 -g

formats: formats.o
	$(CC) $(CFLAGS) $^ -o $@.out

formats.o: formats.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f formats.o formats.out 
	rm -r formats.o.dSYM