#include "efi.h"


typedef struct efi_system_table_t*  _efi_system_table_t;

extern unsigned long long int efi_call(void* function, ...);

struct efi_t
{
unsigned long long int Handle;
_efi_system_table_t    SystemTable;
}__attribute__((packed));


static struct efi_system_table_t  *efi_system_table;                  

void efi_printk(char *string)
  {
  for (unsigned char *source = string;*source;source++)
      {
      unsigned short ch[2] = {0};

      ch[0]=*source;
      if (*source == '\n') 
         {
         unsigned short newline[2] = {'\r',0};
         efi_call(efi_system_table->ConsoleOut->OutputString,efi_system_table->ConsoleOut,newline); 
         }
      efi_call(efi_system_table->ConsoleOut->OutputString,efi_system_table->ConsoleOut,ch);
      }
}

EFI_STATUS efi_initialization(struct efi_t *efi)
  {
  efi_system_table=efi->SystemTable;

  if (efi_system_table->Header.Signature != EFI_SYSTEM_TABLE_SIGNATURE)
     {
     return EFI_LOAD_ERROR;   
     }
      
  efi_call(efi_system_table->ConsoleOut->ClearScreen,efi_system_table->ConsoleOut);  
      
  efi_printk("Hello world\n");

  return EFI_SUCCESS;
} 
