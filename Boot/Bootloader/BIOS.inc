%ifndef _BIOS_INC_
%define _BIOS_INC_

BIOS:
    ; BIOS
    OEMLabel          db "TestOS "
    BytesPerSector    dw 512
    SectorsPerCluster db 1
    SectorsReserved   dw 1
    FATCount          db 2
    RootDirEntries    dw 224
    SectorsCount      dw 2880
    MediaDescriptor   db 0xF0
    FATSize           dw 9
    SectorsPerTrack   dw 18
    NumberOfSides     dw 2
    SectorsHidden     dd 0
    SectorsLarge      dd 0

    ; Extended BIOS
    BootDrive         db 0
    Reserved          db 0
    BootSignature     db 0x29
    VolumeID          dd 0
    VolumeLabel       db "XVolume"
    FileSystem        db "FAT16   "
%endif ; _BIOS_INC_