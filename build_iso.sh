echo "Building OS iso image..."
MYDIR="$(dirname "$(realpath "$0")")"

/bin/bash $MYDIR/build_floppy.sh
mkdir $MYDIR/iso
cp $MYDIR/BeastFloppy.flp $MYDIR/iso/

echo "Building ISO file!"
echo "|      [SETTINGS]                 |"
echo "|=================================|"
echo "|      [beastVolume]              |"
echo "|      [iso8859 (iso8859-1)]      |"
echo "|      [beastfloppy]              |"
echo "|=================================|"

genisoimage -V 'beastVolume' \
            -input-charset iso8859-1 \
            -o $MYDIR/beastiso.iso \
            -b BeastFloppy.flp \
            -hide BeastFloppy.flp $MYDIR/iso
rm $MYDIR/iso/BeastFloppy.flp
rmdir $MYDIR/iso
echo "Done!"

echo "_beast_iso.iso"
