# stm32-bootloader

A bootloader for an STM32 (Cortex-M4) microcontroller, written in C without vendor libraries: hand-written linker script, vector table and startup code. The first target is QEMU's `netduinoplus2` machine (STM32F405), so everything runs without hardware.

**Status: in progress.** This list is updated as each step works.

- [ ] Linker script, vector table, reset handler; "boot" on USART1 in QEMU
- [ ] Second image (application) at a higher flash address; bootloader relocates the vector table and jumps
- [ ] Image header with magic number, size, version and CRC32; bootloader refuses a corrupted image
- [ ] Serial update protocol with framed blocks; Python host tool
- [ ] Automated test script running the cases in QEMU

Planned after that, on a NUCLEO board: real flash erase and write, two image slots with rollback, watchdog, update over CAN FD modelled on the UDS download sequence, and signature check of the image.

## Build and run

Needs `arm-none-eabi-gcc`, `arm-none-eabi-gdb` and `qemu-system-arm`.

```sh
make          # build build/boot.elf
make run      # run in QEMU (quit with Ctrl-A then X)
make debug    # QEMU waits for GDB on port 1234
make gdb      # attach GDB
```

## Layout

- `boot/linker.ld`: memory map and section placement
- `boot/startup.c`: vector table and reset handler
- `boot/main.c`: bootloader entry
