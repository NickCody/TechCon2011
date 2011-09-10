#!/bin/bash

export INFILENAME=$1
export OUTFILENAME=${INFILENAME%.*}.png

nice -n 19 povray +I$INFILENAME +O$OUTFILENAME +W1280 +H960 +Q11 +FN16 +AM2 +A0.01 +J1
if [ -e $OUTFILENAME ]
then
    uuencode $OUTFILENAME $OUTFILENAME | mail -s "$OUTFILENAME" ncodignotto@liquidnet.com
fi    


