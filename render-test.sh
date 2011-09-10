#!/bin/bash

export INFILENAME=$1
export OUTDIR=png
export OUTFILENAME=${INFILENAME%.*}-test.png

nice -n 19 povray +I$INFILENAME +O$OUTDIR/$OUTFILENAME +W400 +H300 +FN16
if [ -e $OUTDIR/$OUTFILENAME ]
then
    uuencode $OUTDIR/$OUTFILENAME $OUTFILENAME | mail -s "$OUTFILENAME" ncodignotto@liquidnet.com
fi    

