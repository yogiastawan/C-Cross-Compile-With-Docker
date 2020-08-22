# make file for raspbian stretch

CC= gcc
CFLAGS= -Wall -Werror -Wextra -v -std=c99 -lm
DBGCFLAGS= -g

GTKFLAGS=`pkg-config --cflags --libs gtk+-3.0`
SRC = $(wildcard *.c) $(wildcard */*.c)
OBJ = $(SRC:%.c=%-raspi.o)
EXEC= app-raspi

BUILDDIR=./build-raspi
RELBUILDDIR=./build-raspi/release/
DBGBUILDDIR=./build-raspi/debug/
RELOBJS=$(addprefix $(RELBUILDDIR)obj/, $(OBJ))
DBGOBJS=$(addprefix $(DBGBUILDDIR)obj/, $(OBJ))
RELEXEC=$(addprefix $(RELBUILDDIR), $(EXEC))
DBGEXEC=$(addprefix $(DBGBUILDDIR), $(EXEC))

release: $(RELEXEC)

debug: $(DBGEXEC)

# release
$(RELEXEC): $(RELOBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(GTKFLAGS)	

$(RELBUILDDIR)obj/%-raspi.o: %.c	
	@mkdir -p $(RELBUILDDIR)obj
	$(CC) $(CFLAGS) -c $< -o $@ $(GTKFLAGS)

# debug
$(DBGEXEC): $(DBGOBJS)
	$(CC) $(CFLAGS) $(DBGCFLAGS) -o $@ $^ $(GTKFLAGS)	

$(DBGBUILDDIR)obj/%-raspi.o: %.c	
	@mkdir -p $(DBGBUILDDIR)obj
	$(CC) $(CFLAGS) $(DBGCFLAGS) -c $< -o $@ $(GTKFLAGS)

clean:
	rm -f $(RELOBJS) $(DBGOBJS) $(RELEXEC) $(DBGEXEC)
	rm -rf $(RELBUILDDIR) $(DBGBUILDDIR) $(BUILDDIR) 