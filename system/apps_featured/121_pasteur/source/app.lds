MEMORY
{
  rom (rx) : ORIGIN = 0x08020400, LENGTH = 20K
/*  ram (rwx) : ORIGIN = 0x20005000, LENGTH = 10K */
  ram (rwx) : ORIGIN = 0x20004800, LENGTH = 16K

  null (rwx): ORIGIN = 0x00001000, LENGTH = 4K
}

/* _estack = ORIGIN(ram)+LENGTH(ram)-0x100; */

SECTIONS
  {
    .text : {
      *(.entry)
      *(.text*)        /* Program code */
      *(.rodata*)      /* Read only data */
    } >rom

    .data : {
      *(.data)        /* Data memory */
      *(.data*)        /* Data memory */
    } >ram AT >rom

  .bss : {
    *(.bss*)         /* Zero-filled run time allocate data memory */
    } >ram

  .rel.plt : { *(.rel.plt)  } > rom
  .plt : { *(.plt) } > rom
  .got : { *(.got.plt) *(.got) } > ram /* relocation fixed by memory write! */
  .dynsym : { *(.dynsym) } > null
  .dynstr : { *(.dynstr) } > null

  }  

