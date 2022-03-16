; initial 16 bit boot code
bits 16
org 0x7c00

boot:
    ; enable A20 bit
    mov ax, 0x2401
    int 0x15

    ; set vga to be normal mode
    mov ax, 0x3
    int 0x10

    cli                                     ; Clear interrupt flag;
    lgdt [gdt_pointer]              ; Load Global/Interrupt Descriptor Table Register

    mov eax, cr0                    ; CR0 has various control flags that modify the basic operation of the processor
    or eax,0x1                              ; EAX |= 0x01 set the protected mode bit on special CPU reg cr0
    mov cr0, eax                    ;
    jmp CODE_SEG:boot2              ; jump to CODE_SEG boot2
gdt_start:
    dq 0x0
gdt_code:
    dw 0xFFFF
    dw 0x0
    db 0x0
    db 10011010b
    db 11001111b
    db 0x0
gdt_data:
    dw 0xFFFF
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0
gdt_end:
gdt_pointer:
    dw gdt_end - gdt_start-1
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

bits 32

boot2:
    ; now, initial stack to data segment
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esi,hello
    mov ebx,0xb8000



%include "app/print.asm"

times 510 - ($-$$) db 0
dw 0xaa55
