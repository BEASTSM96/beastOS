CURRDIR="$(dirname "$(realpath "$0")")"
BASEDIR=$CURRDIR/Base
BOOTDIR=$BASEDIR/Boot
KRNLDIR=$BASEDIR/krnl
BINDIR=$CURRDIR/bin

i686-elf-gcc -c $KRNLDIR/kernel.cpp -o $BINDIR/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -fno-rtti
##i686-elf-gcc -c $KRNLDIR/VGA.cpp -o $BINDIR/VGA.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
##i686-elf-gcc -c $KRNLDIR/kernel.cpp -o $BINDIR/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra