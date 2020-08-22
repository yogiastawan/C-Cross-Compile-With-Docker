# make file for x86_64 architecture

CC= gcc
CFLAGS= -Wall -Werror -Wextra -v -std=c99 -lm
DBGCFLAGS= -g

GTKFLAGS=`pkg-config --cflags --libs gtk+-3.0`
SRC = $(wildcard *.c) $(wildcard */*.c)
OBJ = $(SRC:%.c=%-x86_64.o)
EXEC= app-x86_64

BUILDDIR=./build-x86_64
RELBUILDDIR=./build-x86_64/release/
DBGBUILDDIR=./build-x86_64/debug/
RELOBJS=$(addprefix $(RELBUILDDIR)obj/, $(OBJ))
DBGOBJS=$(addprefix $(DBGBUILDDIR)obj/, $(OBJ))
RELEXEC=$(addprefix $(RELBUILDDIR), $(EXEC))
DBGEXEC=$(addprefix $(DBGBUILDDIR), $(EXEC))

release: $(RELEXEC)

debug: $(DBGEXEC)

# release
$(RELEXEC): $(RELOBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(GTKFLAGS)	

$(RELBUILDDIR)obj/%-x86_64.o: %.c	
	@mkdir -p $(RELBUILDDIR)obj
	$(CC) $(CFLAGS) -c $< -o $@ $(GTKFLAGS)


# debug
$(DBGEXEC): $(DBGOBJS)
	$(CC) $(CFLAGS) $(DBGCFLAGS) -o $@ $^ $(GTKFLAGS)	

$(DBGBUILDDIR)obj/%-x86_64.o: %.c	
	@mkdir -p $(DBGBUILDDIR)obj
	$(CC) $(CFLAGS) $(DBGCFLAGS) -c $< -o $@ $(GTKFLAGS)

clean:
	rm -f $(RELOBJS) $(DBGOBJS) $(RELEXEC) $(DBGEXEC)
	rm -rf $(RELBUILDDIR) $(DBGBUILDDIR) $(BUILDDIR) 