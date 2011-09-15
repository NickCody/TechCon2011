#!/bin/bash

export INFILENAME=$1
export OUTDIR=png
export OUTFILENAME=${INFILENAME%.*}-hq.png

nice -n 19 povray +I$INFILENAME +O$OUTDIR/$OUTFILENAME +W2560 +H1920 +Q11 +FN16 +AM2 +A0.01 +J1



