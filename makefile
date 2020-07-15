.EXPORT_ALL_VARIABLES:
.SUFFIXES:
MAKEFLAGS += --no-builtin-variables

NAME     := b3s
CC       := clang
LD       := ld

SRC      := $(PWD)/src
INC      := $(PWD)/inc
BUILD    := $(PWD)/build
OUT      := $(BUILD)/$(NAME)

CC_INCS  := -I $(SRC) -I $(INC)
CC_FLAGS := -std=c99 -pedantic -Wall -Wextra -nostdlib -nodefaultlibs -ffreestanding -fuse-ld=$(LD) -fno-stack-protector
CC_DEBUG := -g -g3 -ggdb -DDEBUG
CC_OPTIM := -s -Os -O3 -Werror -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables -fdata-sections -ffunction-sections -Wl,--gc-sections -Wl,--build-id=none
CC_NOPIE := -no-pie -fno-pie

IN_C     := $(SRC)/main.c $(SRC)/mem.c $(SRC)/blake3.c $(SRC)/blake3_dispatch.c $(SRC)/blake3_portable.c
IN_ASM   := $(BUILD)/start.S $(SRC)/blake3_sse41_x86-64_unix.S $(SRC)/blake3_avx2_x86-64_unix.S $(SRC)/blake3_avx512_x86-64_unix.S

.DEFAULT_GOAL := debug

clean:
	mkdir -p $(BUILD)
	if [[ -f $(BUILD)/start.S ]]; then rm $(BUILD)/start.S; fi
	if [[ -f $(BUILD)/$(NAME).S ]]; then rm $(BUILD)/$(NAME).S; fi
	if [[ -f $(OUT) ]]; then rm $(OUT); fi

start:
	$(CC) -E $(SRC)/start.S > $(BUILD)/start.S

debug: clean start
	$(CC) $(CC_FLAGS) $(CC_DEBUG) $(CC_INCS) -o $(OUT) $(IN_C) $(IN_ASM)

release: clean start
	$(CC) $(CC_FLAGS) $(CC_OPTIM) $(CC_INCS) -o $(OUT) $(IN_C) $(IN_ASM)
	strip -R .comment $(OUT)

size:
	wc $(OUT)
	size --format=sysv $(OUT)

run:
	$(OUT)

analyze:
	scan-build $(CC) $(CC_FLAGS) $(CC_DEBUG) $(CC_INCS) -o $(OUT) $(IN_C) $(IN_ASM)

dump:
	objdump -D $(OUT) -l > $(BUILD)/$(NAME).S

install:
	sudo cp $(OUT) /usr/local/bin/$(NAME)
	sudo chmod a+x /usr/local/bin/$(NAME)

remove:
	sudo rm /usr/local/bin/$(NAME)

