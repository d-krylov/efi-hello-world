OUTPUT_FORMAT("elf64-x86-64", "elf64-x86-64", "elf64-x86-64")

OUTPUT_ARCH(i386:x86-64)

ENTRY(_start)

SECTIONS
  {
  . = 0;
  .header : { *(.header)  }
  . = 0x1000;
  .init :   { * (.init)   }
  .text :   { * (.text)   }
  . = 0x2000;
  .rodata : { *(.rodata)  }
  . = 0x3000;
  .data   : { *(.data)    }
  . = 0x4000;
  .reloc :  { *(.reloc)   }
  } 
