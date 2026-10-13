/* Memory map for the QEMU STM32F405 target */

MEMORY
{
	/* 1 MB flash, starts at 0x0800.0000 */
	FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 1M
	/* 128 KB SRAM, starts at 0x2000.0000 */
	RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 128K
}

/* Initial stack pointer: top of SRAM */
_estack = ORIGIN(RAM) + LENGTH(RAM);
