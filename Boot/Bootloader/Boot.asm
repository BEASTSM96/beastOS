BITS 16
ORG 0x7c00

%include "Bootloader/BIOS.inc"
%include "Bootloader/CommonMacros.inc"

main:
    jmp short start
    nop

start:
    cli
    mov [BootDrive], dl
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    mov si, loading_msg
    call write_string

    mov dl, [BootDrive]
    xor ax, ax
    int 0x13
    jc on_boot_failed


%include "Bootloader/Common.inc"

BOOTLOADER_SEGMENT: equ 0x1000

bootloader_cluster dw 0

bootloader_file     db "KLoaderbin"
loading_msg         db "Loading OS..", CR, LF, 0x0 

times 510-($-$$) db 0
; times 1000-($-$$) db 0

dw 0xAA55