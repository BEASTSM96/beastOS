echo "Building OS iso image..."
MYDIR="$(dirname "$(realpath "$0")")"
BINDIR=$MYDIR/bin

/bin/bash $MYDIR/build_floppy.sh

mkdir -p isodir/boot/grub
cp $MYDIR/beastOS.bin isodir/boot/beastOS.bin
cp $MYDIR/grub.cfg isodir/boot/grub/grub.cfg

grub-mkrescue -o $MYDIR/beastiso.iso isodir

echo "_beast_iso.iso"
