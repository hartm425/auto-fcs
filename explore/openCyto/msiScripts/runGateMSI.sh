#!/usr/bin/env bash 
module load java
OUTDIR="/scratch.global/lanej/flow/full/results_r20/"
p1Full=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/lymph.dev.LSR.f.txt
p2Full=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/dc.dev.LSR.c.txt

p2=$OUTDIR"p2Trim.txt"
p1=$OUTDIR"p1Trim.txt"
batch=16


head -n9 $p2Full > $p2
head -n8 $p1Full > $p1

# LOD setup
java -jar /home/pankrat2/lane0212/genvisisOC.jar one.JL.fcs.OpenCyto inputFCS=/scratch.global/lanej/flow/full/lodFCS/ panel1Map=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/panel1Map.txt panel2Map=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/panel2Map.txt templateLymph=$p1Full outDir="$OUTDIR/LOD/" rSource=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/Lymph_monoWithQC_v5.R templateMonocyte=$p2Full mapFile=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/fcsMapBlankMap.txt genvisis=/home/pankrat2/lane0212/genvisisOC.jar batch=1 memoryInMb=100000 threads=1 wallTimeInHour=12



# Full setup w/QC 
java -jar /home/pankrat2/lane0212/genvisisOC.jar one.JL.fcs.OpenCyto inputFCS=/scratch.global/lanej/flow/full/fcs/ panel1Map=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/panel1Map.txt panel2Map=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/panel2Map.txt templateLymph=$p1Full outDir="$OUTDIR/FULL/" rSource=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/Lymph_monoWithQC_v5.R templateMonocyte=$p2Full mapFile=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/fcsMapBlankMap.txt genvisis=/home/pankrat2/lane0212/genvisisOC.jar batch=$batch memoryInMb=52000 threads=1 wallTimeInHour=30




cd "$OUTDIR"
#sed -i 's/nodes=1/nodes=cn5601/g' *.pbs
