echo "Building OS iso image..."
MYDIR="$(dirname "$(realpath "$0")")"

/bin/bash $MYDIR/build_floppy.sh
genisoimage -V 'XVolume' \
            -input-charset iso8859-1 \
            -o $MYDIR/Disk.iso \
            -b Floppy.floppy \
            -hide Floppy.floppy $MYDIR
echo "Done!"
