#!/usr/bin/env bash 

revIn=r25/
revOut=CD8_sens_Tcells_71_72_69/

baseInDir="/scratch.global/lanej/flow/full/results_"$revIn"/FULL/"
outDir=/home/thyagara/shared/HRS/annotation/$revOut
mkdir -p $outDir"panel1/"
mkdir -p $outDir"panel2/"
rsync -rv $baseInDir*/panel1Vis/* $outDir"panel1/"

rsync -rv $baseInDir*/panel2Vis/* $outDir"panel2/"



