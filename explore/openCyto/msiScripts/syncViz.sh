#!/usr/bin/env bash 

rev=r23/

baseInDir="/scratch.global/lanej/flow/full/results_"$rev"/FULL/"
outDir=/home/thyagara/shared/HRS/annotation/CD8_IgD_test/
mkdir -p $outDir"panel1/"
mkdir -p $outDir"panel2/"

rsync -rv $baseInDir*/panel1Vis/* $outDir"panel1/"
rsync -rv $baseInDir*/panel2Vis/* $outDir"panel2/"
