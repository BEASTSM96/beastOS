echo "Building OS floppy image..."
echo "Setting env vars for build!"
CURRDIR="$(dirname "$(realpath "$0")")"
BASEDIR=$CURRDIR/Base
BOOTDIR=$BASEDIR/Boot
KRNLDIR=$BASEDIR/krnl

mkdir -p $CURRDIR/bin
BINDIR=$CURRDIR/bin

echo "Compile [0/base/boot]"
i686-elf-as $BOOTDIR/boot.s -o $BINDIR/boot.o
echo "=======================[0/base/boot]======================="
echo "Compile [0/base/krnl]"
bash $CURRDIR/compile_c_cpp.sh
echo "=======================[0/base/krnl]======================="
echo "Linking [0.5/krnl]"
i686-elf-gcc -fno-rtti -fno-exceptions -T $KRNLDIR/linker.ld -o beastOS.bin -ffreestanding -O2 -nostdlib $BINDIR/boot.o $BINDIR/kernel.o -lgcc -fno-rtti -fno-exceptions
echo "=======================[0.5/krnl]=========================="
bash grub_check.sh
echo "Done!"