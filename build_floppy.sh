echo "Building OS floppy image..."
echo "Setting env vars for build!"
CURRDIR="$(dirname "$(realpath "$0")")"
BASEDIR=$CURRDIR/Base
BOOTDIR=$BASEDIR/Boot
KRNLDIR=$BASEDIR/krnl
echo "Compile [0/base/boot]"
nasm $BOOTDIR/Boot.asm -o $CURRDIR/Boot.bin
##echo "Compile [0/base/krnl]"
##gcc -o Kernel.bin -c $KRNLDIR/kernel.c -Wall -Wextra -nostdlib -nostartfiles -nodefaultlibs
##
echo "Building Floppy [1/boot]"
dd status=noxfer conv=notrunc if=$CURRDIR/Boot.bin of=$CURRDIR/BeastFloppy.flp
dd if=/dev/zero of=$CURRDIR/beastFloppy.flp bs=1024 count=1440
dd if=$CURRDIR/Boot.bin of=$CURRDIR/beastFloppy.flp seek=0 count=1 conv=notrunc
echo "Done!"