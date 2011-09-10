#!/bin/bash

export INFILENAME=$1
export OUTFILENAME=${INFILENAME%.*}-test.png

nice -n 19 povray +I$INFILENAME +O$OUTFILENAME +W400 +H300 +FN16
if [ -e $OUTFILENAME ]
then
    uuencode $OUTFILENAME $OUTFILENAME | mail -s "$OUTFILENAME" ncodignotto@liquidnet.com
fi    

