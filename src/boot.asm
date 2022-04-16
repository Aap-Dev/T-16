 org 0x7C00   ; add 0x7C00 to label addresses
 bits 16      ; tell the assembler we want 16 bit code
 
   mov ax, 0  ; set up segments
   mov ds, ax
   mov es, ax
   mov ss, ax     ; setup stack
   mov sp, 0x7C00 ; stack grows downwards from 0x7C00
 
   mov si, welcome
   call print_string
   %include "mainloop.asm" 
 
   times 510-($-$$) db 0
   dw 0AA55h ; some BIOSes require this signature
