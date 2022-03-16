.loop:
    lodsb
    or al,al
    jz halt
    or eax,0x0200

    mov word [ebx], ax      
    add ebx,2
    jmp .loop
halt:
    cli
    hlt
hello: db "TiMPLEST bootloader...",0
