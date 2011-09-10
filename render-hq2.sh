#!/bin/bash

export INFILENAME=$1
export OUTDIR=png
export OUTFILENAME=${INFILENAME%.*}-test.png

nice -n 19 povray +I$INFILENAME +O$OUTDIR/$OUTFILENAME +W3840 +H2880 +Q11 +FN16 +AM2 +A0.01 +J1
if [ -e $OUTDIR/$OUTFILENAME ]
then
    uuencode $OUTDIR/$OUTFILENAME $OUTFILENAME | mail -s "$OUTFILENAME" ncodignotto@liquidnet.com
fi    




