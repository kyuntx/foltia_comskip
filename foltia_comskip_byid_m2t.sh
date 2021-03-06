#!/bin/sh
# foltia_comskip.sh
#  Commercial detect and create chapters for HD Encoded MP4 files.

COMSKIP_PATH=/home/foltia/perl/tool/comskip
COMSKIP_BIN=$COMSKIP_PATH/comskip.exe
COMSKIP_WORK=$COMSKIP_PATH/work
#COMSKIP_ARG="-t -d 255 -v 2 --zpcut --zpchapter --videoredo --csvout --quality --plist --ini=$COMSKIP_PATH/comskip.ini --output=$COMSKIP_WORK/"
COMSKIP_ARG="-t -v 2 --zpcut --zpchapter --videoredo --csvout --quality --plist --ini=$COMSKIP_PATH/comskip.ini --output=$COMSKIP_WORK/"

MP4BOX=/home/foltia/perl/tool/MP4Box

WINE=/usr/bin/wine

M2T_PATH=/home/foltia/php/tv

if [ $# -eq 0 ]; then

	echo "usage: foltia_comskip.sh [convertfile]"
	exit 1

fi

videofile_basename=$1
videofile_m2t=$M2T_PATH/$videofile_basename.m2t
progname=`echo $videofile_basename | awk -F- '{print $1}'`
videofile_mp4=$M2T_PATH/$progname.localized/mp4/MHD-$videofile_basename.MP4

if [ ! -f $videofile_m2t ]; then

	echo "M2T file not found: $videofile_m2t"
	exit 1
fi

if [ ! -f $videofile_mp4 ]; then

        echo "MP4 file not found: $videofile_mp4"
        exit 1
fi

$WINE $COMSKIP_BIN $COMSKIP_ARG $videofile_m2t

vdrchapfile=$COMSKIP_WORK/$videofile_basename.vdr
chapfile=$M2T_PATH/$progname.localized/mp4/MHD-$videofile_basename.chapters.txt
chapfile_qt=$M2T_PATH/$progname.localized/mp4/MHD-$videofile_basename.chapters_quicktime.ttxt

if [ ! -f $vdrchapfile ]; then

        echo "vdr file not found: $vdrchapfile"
	echo "comskip failed ?"
        exit 1
fi

echo "00:00:00.000 Chapter.0" > $chapfile
grep end $vdrchapfile | awk '{i++; print "0" $1 "0 Chapter." i}' | sed -e '$d' >> $chapfile

cat << __EOM__ >> $chapfile_qt 2>&1
<?xml version="1.0" encoding="UTF-8" ?>
<TextStream version="1.1">
<TextStreamHeader>
<TextSampleDescription>
</TextSampleDescription>
</TextStreamHeader>
__EOM__
cat $chapfile | awk '{print "<TextSample sampleTime=""\""$1"\">"$2"</TextSample>"}' >> $chapfile_qt
echo "</TextStream>" >> $chapfile_qt

$MP4BOX -tmp $M2T_PATH/$progname.localized/mp4/ -add $chapfile_qt:chap -chap $chapfile $videofile_mp4

rm -f $COMSKIP_WORK/$videofile_basename.*

