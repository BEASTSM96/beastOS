BITS 16
ORG 0x7c00

CR: equ 0x0D
LF: equ 0x0A

STAGE_TWO_LOAD_SEGMENT: equ 0x1000


main:
    jmp short start
    nop

boot_sector:
    ; BIOS Parameter Block
    OEMLabel          db "beastOS "
    BytesPerSector    dw 512
    SectorsPerCluster db 1
    SectorsReserved   dw 1
    FATCount          db 2
    RootDirEntries    dw 224
    SectorsCount      dw 2880
    MediaDescriptor   db 0xF0 ; gonna pretend we're a 3.5 floppy
    FATSize           dw 9
    SectorsPerTrack   dw 9
    NumberOfSides     dw 2
    SectorsHidden     dd 0
    SectorsLarge      dd 0

    ; Extended BIOS Parameter Block
    BootDrive         db 0
    Reserved          db 0
    BootSignature     db 0x29
    VolumeID          dd 0
    VolumeLabel       db "beastVolume"
    FileSystem        db "FAT16   "

write_string:
    lodsb
    or al, al
    jz .done

    mov ah, 0xE
    mov bx, 9
    int 0x10

    jmp write_string
.done:
    ret

on_boot_failed:
    mov si, disk_error_msg
    call write_string
    call reboot

reboot:
    mov si, reboot_msg
    call write_string
    xor ax, ax
    int 0x16
    jmp word 0xFFFF:0x0000

start:
    cli
    mov [BootDrive], dl
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    mov ax,0x13
	int 0x10

    mov si, loading_msg
    call write_string

    mov dl, [BootDrive]
    xor ax, ax
    int 0x13
    jc on_boot_failed

	mov ah,02
	int 0x10

    ;set x y position to text
	mov ah,0x02
	mov bh,0x00
	mov dh,0x08
	mov dl,0x12
	int 0x10

    mov si, welcome_msg
    call write_string

    jmp _STAGE_TWO_



loading_msg     db "Loading beastOS...", CR, LF, 0x0
welcome_msg     db "Welcome to beastOS.", CR, LF, 0x0
username_msg    db "Enter a Username", CR, LF, 0x0
password_msg    db "Enter a password", CR, LF, 0x0
osinfo_msg      db "beastOS, ver=0.00.0001", CR, LF, 0x0
disk_error_msg  db "Error loading disk.", CR, LF, 0x0
reboot_msg      db "Press any key to reboot.", CR, LF, 0x0

_STAGE_TWO_:
    mov al, 2
	mov ah, 0
	int 0x10

	mov cx, 0

	mov ah, 0x02
	mov bh, 0x00
	mov dh, 0x00
	mov dl, 0x00
	int 0x10

    mov si, username_msg
    call write_string

_getUsernameinput:

	mov ax,0x00             ; get keyboard input
	int 0x16		        ; hold for input

	cmp ah,0x1C             ; compare input is enter(1C) or not
	je .exitinput           ; if enter then jump to exitinput

	cmp ah,0x01             ; compare input is escape(01) or not
;	je _skipLogin           ; jump to _skipLogin

	mov ah,0x0E             ;display input char
	int 0x10

	inc cx                  ; increase counter
	cmp cx,5                ; compare counter reached to 5
	jbe _getUsernameinput   ; yes jump to _getUsernameinput
	jmp .inputdone          ; else jump to inputdone

.inputdone:
	mov cx,0                ; set counter to 0
	jmp _getUsernameinput   ; jump to _getUsernameinput
	ret                     ; return

.exitinput:
	hlt

    jmp _STAGE_3_

_STAGE_3_:

    ;set x y position to text
	mov ah, 0x02
	mov bh, 0x00
	mov dh, 0x08
	mov dl, 0x12
	int 0x10

    mov si, welcome_msg
    call write_string

    mov ah, 0x02
	mov bh, 0x00
	mov dh, 0x08
	mov dl, 0x12
	int 0x10

    mov si, osinfo_msg
    call write_string



times 510-($-$$) db 0

dw 0xAA55