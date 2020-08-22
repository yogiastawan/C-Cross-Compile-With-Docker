CC= gcc
CFLAGS= -Wall -Werror -Wextra -v -std=c99 -lm
DBGCFLAGS= -g

GTKFLAGS=`pkg-config --cflags --libs gtk+-3.0`
SRC = $(wildcard *.c) $(wildcard */*.c)
OBJ = $(SRC:%.c=%.o)
EXEC= app

DOCKER_UBUNTU_X6_64=sudo docker run --rm -it -v /home/yogiastawan/Programming/Docker/test3-cross-compile/:/src:z -w /src ubuntu-x86_64:gtk3
DOCKER_UBUNTU_ARM_64V8=sudo docker run --rm -it -v /home/yogiastawan/Programming/Docker/test3-cross-compile/:/src:z -w /src ubuntu-arm64v8:gtk3
DOCKER_UBUNTU_ARM_32V7=sudo docker run --rm -it -v /home/yogiastawan/Programming/Docker/test3-cross-compile/:/src:z -w /src ubuntu-arm32v7:gtk3
DOCKER_RASPI=sudo docker run --rm -it -v /home/yogiastawan/Programming/Docker/test3-cross-compile/:/src:z -w /src raspi-stretch:gtk3

BUILDDIR=./build
RELBUILDDIR=./build/release/
DBGBUILDDIR=./build/debug/
RELOBJS=$(addprefix $(RELBUILDDIR)obj/, $(OBJ))
DBGOBJS=$(addprefix $(DBGBUILDDIR)obj/, $(OBJ))
RELEXEC=$(addprefix $(RELBUILDDIR), $(EXEC))
DBGEXEC=$(addprefix $(DBGBUILDDIR), $(EXEC))

release: $(RELEXEC)

debug: $(DBGEXEC)

all: $(RELEXEC) release-x86_64 release-arm64v8 release-arm32v7 release-raspberrypi

debug-all: $(DBGEXEC) debug-x86_64 debug-arm64v8 debug-arm32v7 debug-raspberrypi

release-x86_64:
	$(DOCKER_UBUNTU_X6_64) make -f arch-x86_64.mk release
	
debug-x86_64:
	$(DOCKER_UBUNTU_X6_64) make -f arch-x86_64.mk debug

release-arm64v8:
	$(DOCKER_UBUNTU_ARM_64V8) make -f arch-arm64v8.mk release

debug-arm64v8:
	$(DOCKER_UBUNTU_ARM_64V8) make -f arch-arm64v8.mk debug

release-arm32v7:
	$(DOCKER_UBUNTU_ARM_32V7) make -f arch-arm32v7.mk release	

debug-arm32v7:
	$(DOCKER_UBUNTU_ARM_32V7) make -f arch-arm32v7.mk debug	

release-raspberrypi:
	$(DOCKER_RASPI) make -f arch-es-armv7.mk release

debug-raspberrypi:
	$(DOCKER_RASPI) make -f arch-es-armv7.mk debug

# release

$(RELEXEC): $(RELOBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(GTKFLAGS)	

$(RELBUILDDIR)obj/%.o: %.c
	@mkdir -p $(RELBUILDDIR)obj
	$(CC) $(CFLAGS) -c $< -o $@ $(GTKFLAGS)

# debug
$(DBGEXEC): $(DBGOBJS)
	$(CC) $(CFLAGS) $(DBGCFLAGS) -o $@ $^ $(GTKFLAGS)	

$(DBGBUILDDIR)obj/%.o: %.c	
	@mkdir -p $(DBGBUILDDIR)obj
	$(CC) $(CFLAGS) $(DBGCFLAGS) -c $< -o $@ $(GTKFLAGS)

clean:
	rm -f $(RELOBJS) $(DBGOBJS) $(RELEXEC) $(DBGEXEC)
	rm -rf $(RELBUILDDIR) $(DBGBUILDDIR) $(BUILDDIR)
	make -f arch-x86_64.mk clean
	make -f arch-arm64v8.mk clean
	make -f arch-arm32v7.mk clean
	make -f arch-es-armv7.mk clean