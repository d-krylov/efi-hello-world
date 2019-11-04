.section ".header","a"

.byte 'M'
.byte 'Z'

.org   0x3c
.long  pe_header

pe_header:

.byte 'P'
.byte 'E'

.word  0x0000
.word  0x8664                                #machine

.word  0x0004                                #number sections

.long  0x00000000
.long  0x00000000
.long  0x00000000


.word  section_table-optional_header         #size of optional header

.word  0x202e 


optional_header:

.word  0x020b                                #PE32+ format

.byte  0x01
.byte  0x49

.long  0x00001000                            #size of code (summ all sections with code)
.long  0x00001000                            #size of the initialized data section
.long  0x00000000

.long  0x00001000                            #address of entry point
.long  0x00001000                            #base of code
.quad  0x0000000000400000                    #image base
.long  0x00001000                            #section alignment >= file alignment
.long  0x00001000                            #file alignment

.word  0x0001
.word  0x0000
.word  0x0000
.word  0x0000
.word  0x0005
.word  0x0000
.long  0x0000
.long  0x00004000                            #size of image
.long  0x00001000                            #size of headers (offset from begin file to data first section)
.long  0x00000000                            #checksum
.word  0x000a                                #EFI application
.word  0x0040
.quad  0x0000000000001000
.quad  0x0000000000001000
.quad  0x0000000000010000
.quad  0x0000000000000000
.long  0x00000000
.long  0x00000000                            #numbers catalog

section_table:

.byte  '.','t','e','x','t',0x00,0x00,0x00
.long  0x00001000                            #size section in memory
.long  0x00001000                            #rva section in memory
.long  0x00001000                            #size section in file
.long  0x00001000                            #offset data section in file

.long  0x00000000
.long  0x00000000
.word  0x0000
.word  0x0000

.long  0x60000020

.byte  '.','r','d','a','t','a',0x00,0x00
.long  0x00001000 
.long  0x00002000 
.long  0x00002000
.long  0x00002000

.long  0x00000000
.long  0x00000000
.word  0x0000
.word  0x0000

.long  0xc0000040

.byte  '.','d','a','t','a',0x00,0x00,0x00
.long  0x00001000 
.long  0x00003000 
.long  0x00001000
.long  0x00003000

.long  0x00000000
.long  0x00000000
.word  0x0000
.word  0x0000

.long  0xc0000040



.byte  '.','r','e','l','o','c',0x00,0x00
.long  0x00000000  
.long  0x00004000 
.long  0x00000000
.long  0x00004000

.long  0x00000000
.long  0x00000000
.word  0x0000
.word  0x0000

.long  0x02000040



.code64

.section ".init","ax"

.global _start

_start:
  
  movq  %rcx,efi+0x0(%rip)                    /* %rcx - handle*/
  movq  %rdx,efi+0x8(%rip)                    /* %rdx - efi system table pointer*/
  
  leaq  efi(%rip),%rdi
  call  efi_initialization
 
exit:

  retq

.data

efi:
.quad      0x9090909090909090                /*handle*/  
.quad      0x9090909090909090                /*efi system table pointer*/

.org       0xff8
.quad      0

.section ".reloc","a"

 
