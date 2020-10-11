echo "Building OS floppy image..."
CURRDIR="$(dirname "$(realpath "$0")")"
nasm $CURRDIR/Bootloader/Boot.asm -o $CURRDIR/Boot.bin
nasm $CURRDIR/Bootloader/KLoader.asm -o $CURRDIR/KLoader.bin
dd if=/dev/zero of=$CURRDIR/Floppy.floppy bs=1024 count=1440
dd if=$CURRDIR/Boot.bin of=$CURRDIR/Floppy.floppy seek=0 count=1 conv=notrunc 
dd if=$CURRDIR/KLoader.bin of=$CURRDIR/Floppy.floppy seek=1 count=1 conv=notrunc
echo "Done!"