#ifndef EFI_H
#define EFI_H

typedef unsigned char          u8;
typedef unsigned short         u16;
typedef unsigned int           u32;
typedef unsigned long long int u64;

typedef signed   char          s8;
typedef signed   short         s16;
typedef signed   int           s32;
typedef signed long long int   s64;

typedef void                  *efi_handle_t;
typedef unsigned short         efi_char16_t;

#define EFI_SYSTEM_TABLE_SIGNATURE   (0x5453595320494249ULL) 

typedef enum 
  {
  EFI_SUCCESS            = 0,
  EFI_LOAD_ERROR         = 0x8000000000000001,
  EFI_INVALID_PARAMETER  = 0x8000000000000002,
  EFI_UNSUPPORTED        = 0x8000000000000003,
  EFI_BAD_BUFFER_SIZE    = 0x8000000000000004,
  EFI_BUFFER_TOO_SMALL   = 0x8000000000000005,
  EFI_NOT_READY          = 0x8000000000000006,
  EFI_DEVICE_ERROR       = 0x8000000000000007,
  EFI_WRITE_PROTECTED    = 0x8000000000000008,
  EFI_OUT_OF_RESOURCES   = 0x8000000000000009,
  EFI_NOT_FOUND          = 0x8000000000000014,
  EFI_ABORTED            = 0x8000000000000021,
  EFI_SECURITY_VIOLATION = 0x8000000000000026,
} EFI_STATUS;

typedef struct 
  {
  u64 Signature;
  u32 Revision;
  u32 HeaderSize;
  u32 CRC32;
  u32 Reserved;
} efi_table_header_t;


typedef struct
  {
  int _pad;
} efi_runtime_services_t;

typedef struct  
  {
  int _pad;
} efi_boot_services_t;

typedef struct _efi_simple_text_output_protocol_t
  {
  u64 Reset;
  EFI_STATUS (*OutputString)(void*,unsigned short*);
  u64 TestString;
  u64 QueryMode;
  u64 SetMode;
  u64 SetAttribute;
  EFI_STATUS (*ClearScreen)(struct _efi_simple_text_output_protocol_t*);
  u64 SetCursorPosition;
  u64 EnableCursor;
} efi_simple_text_output_protocol_t;

struct efi_system_table_t
  {
  efi_table_header_t                 Header;
  efi_char16_t                      *FirmwareVendor;
  u32                                FirmwareRevision;
  efi_handle_t                       ConsoleInHandle;
  u64                                ConsoleIn;
  efi_handle_t                       ConsoleOutHandle;
  efi_simple_text_output_protocol_t *ConsoleOut;
  efi_handle_t                       StandardErrorHandle;
  u64                                StandardError;
  efi_runtime_services_t            *RuntimeServices;
  efi_boot_services_t               *BootServices;
  u32                                NumberOfTableEntries;
  u32                                ConfigurationTable;
};

#endif 
