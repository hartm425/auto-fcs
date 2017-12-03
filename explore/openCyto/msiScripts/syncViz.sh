#!/usr/bin/env bash 

revIn=r25/
revOut=CD8_sens_81_Tcells_72/

baseInDir="/scratch.global/lanej/flow/full/results_"$revIn"/FULL/"
outDir=/home/thyagara/shared/HRS/annotation/$revOut
# outDir=/scratch.global/flow/$revOut
mkdir -p $outDir"panel1/"
mkdir -p $outDir"panel2/"
rsync -rv $baseInDir/openCytoBatch_1/panel1Vis/* $outDir"panel1/"
rsync -rv $baseInDir/openCytoBatch_5/panel1Vis/* $outDir"panel1/"
rsync -rv $baseInDir/openCytoBatch_10/panel1Vis/* $outDir"panel1/"
rsync -rv $baseInDir/openCytoBatch_15/panel1Vis/* $outDir"panel1/"
rsync -rv $baseInDir/openCytoBatch_20/panel1Vis/* $outDir"panel1/"
rsync -rv $baseInDir/openCytoBatch_25/panel1Vis/* $outDir"panel1/"
rsync -rv $baseInDir/openCytoBatch_30/panel1Vis/* $outDir"panel1/"

rsync -rv $baseInDir*/panel2Vis/* $outDir"panel2/"





#sync fcs 
