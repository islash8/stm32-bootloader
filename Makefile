# Day 1: bootloader only. Build: make   Run: make run   Debug: make debug (then: make gdb)
CC      := arm-none-eabi-gcc
OBJCOPY := arm-none-eabi-objcopy
CFLAGS  := -mcpu=cortex-m4 -mthumb -Og -g3 -ffreestanding -Wall -Wextra
LDFLAGS := -nostdlib -T boot/linker.ld -Wl,-Map=build/boot.map
QEMU    := qemu-system-arm -M netduinoplus2 -nographic -kernel build/boot.elf

build/boot.elf: boot/startup.c boot/main.c boot/linker.ld
	@mkdir -p build
	$(CC) $(CFLAGS) boot/startup.c boot/main.c $(LDFLAGS) -o $@
	arm-none-eabi-size $@

run: build/boot.elf      # quit QEMU with Ctrl-A then X
	$(QEMU)

debug: build/boot.elf    # waits for GDB on port 1234
	$(QEMU) -s -S

gdb:
	arm-none-eabi-gdb build/boot.elf -ex "target remote :1234"

clean:
	rm -rf build

.PHONY: run debug gdb clean
