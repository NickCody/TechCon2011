#!/bin/bash

export INFILENAME=$1
export OUTDIR=png
export OUTFILENAME=${INFILENAME%.*}-hqmax.png

nice -n 19 povray +I$INFILENAME +O$OUTDIR/$OUTFILENAME +W5120 +H3840 +Q11 +FN16 +AM2 +A0.01 +J1




