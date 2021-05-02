;@+leo-ver=5-thin
;@+node:caminhante.20210502143746.1: * @file kernel.asm
;@@nocolor
;@@language assembly_x86
;@@tabwidth -2
;@+others
;@+node:caminhante.20210502144450.1: ** structs
;@+node:caminhante.20210502144658.1: *3* Multiboot
multiboot:
  .header_magic = 0x1BADB002
  .flags:
    .page_aligned = (1 shr 0)
    .aout_kludge =  (1 shr 16)
struc multiboot_header_magic _flags {
  align 4
  .magic dd multiboot.header_magic
  .flags dd _flags
  .checksum dd -(multiboot.header_magic + _flags)
}
struc multiboot_header_addr _header, _load, _load_end, _bss_end, _entry {
  ; deve apontar para multiboot_header_magic
  .header_addr    dd _header
  ; início do segmento .text (rx) e .rodata (r)
  ; igual ou menor que .header_addr
  .load_addr      dd _load
  ; final do segmento .text (rx) e .rodata (r)
  ; devem ser contíguos na memória, 0 significa que o binário inteiro é rx+r
  .load_end_addr  dd _load_end
  ; final do segmento .bss (rw, zero-inicializado)
  ; deve ser contíguo à .rodata (r)
  .bss_end_addr   dd _bss_end
  ; endereço físico de salto para o código do kernel
  .entry_addr     dd _entry
}
struc multiboot_header_graphics {
  .mode_type  rd 1
  .width      rd 1
  .height     rd 1
  .depth      rd 1
}
;@+node:caminhante.20210502144350.1: ** ELF
format elf executable
entry start
;@+node:caminhante.20210502144403.1: *3* segment executable
segment executable
org 0x00100000
start:
;@-others
;@-leo
