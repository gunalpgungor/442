# Makefile for B-minor scanner

# Compiler and tools
CC = gcc
FLEX = win_flex

# Output executable
TARGET = bminor

# Flex generated source file
LEX_SRC = lex.yy.c

# Source files
SRCS = scanner.c $(LEX_SRC)

# Clean files
CLEAN_FILES = $(TARGET) $(LEX_SRC) scanner.o lex.yy.o

# Default rule: build the target
all: $(TARGET)

# Rule to build the target executable
$(TARGET): scanner.o lex.yy.o
	$(CC) -o $(TARGET) scanner.o lex.yy.o

# Rule to compile scanner.c
scanner.o: scanner.c
	$(CC) -c scanner.c

# Rule to compile lex.yy.c
lex.yy.o: lex.yy.c
	$(CC) -c lex.yy.c

# Rule to generate the flex source file
$(LEX_SRC): scanner.l
	$(FLEX) scanner.l

# Rule to clean generated files
clean:
	rm -f $(CLEAN_FILES)

# Phony targets
.PHONY: all clean
