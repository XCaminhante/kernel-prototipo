#@+leo-ver=5-thin
#@+node:caminhante.20210502143700.1: * @file Makefile
#@@language Makefile
#@@tabwidth 5
all: emulate

kernel: kernel.asm
	fasm $<

emulate: kernel
	qemu-system-i386 -kernel kernel

.PHONY: emulate
#@-leo
