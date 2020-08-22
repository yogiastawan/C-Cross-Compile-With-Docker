# make file for arm32 architecture

CC= gcc
CFLAGS= -Wall -Werror -Wextra -v -std=c99 -lm
DBGCFLAGS= -g

GTKFLAGS=`pkg-config --cflags --libs gtk+-3.0`
SRC = $(wildcard *.c) $(wildcard */*.c)
OBJ = $(SRC:%.c=%-arm32.o)
EXEC= app-arm32

BUILDDIR=./build-arm32
RELBUILDDIR=./build-arm32/release/
DBGBUILDDIR=./build-arm32/debug/
RELOBJS=$(addprefix $(RELBUILDDIR)obj/, $(OBJ))
DBGOBJS=$(addprefix $(DBGBUILDDIR)obj/, $(OBJ))
RELEXEC=$(addprefix $(RELBUILDDIR), $(EXEC))
DBGEXEC=$(addprefix $(DBGBUILDDIR), $(EXEC))

release: $(RELEXEC)

debug: $(EXEC)

# release
$(RELEXEC): $(RELOBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(GTKFLAGS)	

$(RELBUILDDIR)obj/%-arm32.o: %.c
	@mkdir -p $(RELBUILDDIR)obj
	$(CC) $(CFLAGS) -c $< -o $@ $(GTKFLAGS)

# debug
$(DBGEXEC): $(DBGOBJS)
	$(CC) $(CFLAGS) $(DBGCFLAGS) -o $@ $^ $(GTKFLAGS)	

$(DBGBUILDDIR)obj/%-arm32.o: %.c	
	@mkdir -p $(DBGBUILDDIR)obj
	$(CC) $(CFLAGS) $(DBGCFLAGS) -c $< -o $@ $(GTKFLAGS)

clean:
	rm -f $(RELOBJS) $(DBGOBJS) $(RELEXEC) $(DBGEXEC)
	rm -rf $(RELBUILDDIR) $(DBGBUILDDIR) $(BUILDDIR) 