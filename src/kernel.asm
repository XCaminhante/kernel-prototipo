;@+leo-ver=5-thin
;@+node:caminhante.20210502143746.1: * @file kernel.asm
;@@nocolor
;@@language assembly_x86
;@@tabwidth -2
;@+others
;@+node:caminhante.20210502144450.1: ** tipos de dados
;@+node:caminhante.20210502144658.1: *3* Multiboot
multiboot:
  .header_magic = 0x1BADB002
  .flags:
    .page_aligned_modules = (1 shl 0)
    .prefered_graphics_mode = (1 shl 1)
    .alternative_binary_format =  (1 shl 15)
  .graphics_mode:
    .linear = 0
    .EGA_text = 1
;@+node:caminhante.20210502170507.1: *4* struc multiboot_header_magic _flags
struc multiboot_header_magic _flags {
  align 4
  .magic dd multiboot.header_magic
  .flags dd _flags
  .checksum dd -(multiboot.header_magic + _flags)
}
;@+node:caminhante.20210502170515.1: *4* struc multiboot_header_addr _header, _load, _load_end, _bss_end, _entry
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
;@+node:caminhante.20210502170522.1: *4* struc multiboot_header_graphics
struc multiboot_header_graphics {
  ; 0 = modo linear (pixels), 1 = modo de texto EGA
  .mode_type  rd 1
  ; largura sugerida em colunas
  .width      rd 1
  ; altura sugerida em linhas
  .height     rd 1
  ; profundidade de bits
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
