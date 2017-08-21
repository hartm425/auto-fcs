#!/usr/bin/env bash 
module load java
OUTDIR="/scratch.global/lanej/flow/full/results_r10/"
p1Full=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/lymph.dev.LSR.f.txt
p2Full=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/dc.dev.c.txt

p2=$OUTDIR"p2Trim.txt"
p1=$OUTDIR"p1Trim.txt"


head -n9 $p2Full > $p2
head -n8 $p1Full > $p1

# LOD setup
java -jar /home/pankrat2/lane0212/genvisisOC.jar one.JL.fcs.OpenCyto inputFCS=/scratch.global/lanej/flow/full/fcs/ panel1Map=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/panel1Map.txt panel2Map=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/panel2Map.txt templateLymph=$p1 outDir="$OUTDIR/LOD/" rSource=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/Lymph_monoWithQC_v5.R templateMonocyte=$p2 mapFile=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/fcsMapBlankMap.txt genvisis=/home/pankrat2/lane0212/genvisisOC.jar batch=16 memoryInMb=30000 threads=1 wallTimeInHour=100



# Full setup w/QC 
java -jar /home/pankrat2/lane0212/genvisisOC.jar one.JL.fcs.OpenCyto inputFCS=/scratch.global/lanej/flow/full/fcs/ panel1Map=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/panel1Map.txt panel2Map=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/panel2Map.txt templateLymph=$p1 outDir="$OUTDIR/FULL/" rSource=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/Lymph_monoWithQC_v5.R templateMonocyte=$p2 mapFile=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/fcsMapBlankMap.txt genvisis=/home/pankrat2/lane0212/genvisisOC.jar batch=16 memoryInMb=30000 threads=1 wallTimeInHour=100




cd "$OUTDIR"
#sed -i 's/nodes=1/nodes=cn5601/g' *.pbs
