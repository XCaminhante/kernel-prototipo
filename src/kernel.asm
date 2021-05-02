;@+leo-ver=5-thin
;@+node:caminhante.20210502143746.1: * @file kernel.asm
;@@nocolor
;@@language assembly_x86
;@@tabwidth -2
;@+others
;@+node:caminhante.20210502144450.1: ** estruturas de dados
;@+node:caminhante.20210502144658.1: *3* Multiboot
multiboot:
  .header_magic = 0x1BADB002
  .page_aligned_modules = (1 shl 0)
  .prefered_graphics_mode = (1 shl 1)
  .alternative_binary_format =  (1 shl 15)
  .graphic_linear = 0
  .graphic_EGA_text = 1
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
;@+node:caminhante.20210502170522.1: *4* struc multiboot_header_graphics _mode, _width, _height, _depth
struc multiboot_header_graphics _mode, _width, _height, _depth {
  ; 0 = modo linear (pixels), 1 = modo de texto EGA
  .mode_type  dd _mode
  ; largura sugerida em colunas
  .width      dd _width
  ; altura sugerida em linhas
  .height     dd _height
  ; profundidade de bits
  .depth      dd _depth
}
;@+node:caminhante.20210502172406.1: *4* struc multiboot_information_data
struc multiboot_information_data {
}
;@+node:caminhante.20210502191722.1: *3* Texto EGA
ega:
  .ram = 0xb8000
  .color.black = 0
  .color.blue = 1
  .color.green = 2
  .color.cyan = 3
  .color.red = 4
  .color.magenta = 5
  .color.brown = 6
  .color.light_gray = 7
  .color.gray = 8
  .color.light_blue = 9
  .color.light_green = 10
  .color.light_cyan = 11
  .color.light_red = 12
  .color.light_magenta = 13
  .color.light_brown = 14
  .color.white = 15
;@+node:caminhante.20210502144350.1: ** format elf
format elf executable
entry start
;@+node:caminhante.20210502190537.1: *3* multiboot headers
align 4
mhm multiboot_header_magic multiboot.page_aligned_modules+multiboot.prefered_graphics_mode
mha multiboot_header_addr 0,0,0,0,0
mhg multiboot_header_graphics multiboot.graphic_EGA_text, 80, 43, 0
;@+node:caminhante.20210502144403.1: *3* segment executable
segment executable
org 0x00100000
;@+node:caminhante.20210502192022.1: *4* start
start:
mov esp, kernel_stack
push 0
popf
push ebx eax
;@+node:caminhante.20210502192501.1: *4* stop
stop:
hlt
jmp stop
;@+node:caminhante.20210502190934.1: *3* segment readable writeable
segment readable writeable
;@+node:caminhante.20210502192008.1: *4* kernel stack
rd 1024
kernel_stack:
;@-others
;@-leo
