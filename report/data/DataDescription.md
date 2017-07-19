# OpenCyto
JL  
7/19/2017  

Almost Documentation ? 



## Running OpenCyto

1. Set up batches with genvisis

```bash
OUTDIR="/scratch.global/lanej/flow/full/results_r6/"

java -jar /home/pankrat2/lane0212/genvisisOC.jar one.JL.fcs.OpenCyto inputFCS=/scratch.global/lanej/flow/full/fcs/ panel1Map=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/panel1Map.txt panel2Map=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/panel2Map.txt templateLymph=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/lymph.dev.e.csv outDir=$OUTDIR rSource=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/Lymph_monoWithQC_v5.R templateMonocyte=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/dc.dev.c.csv mapFile=/home/pankrat2/shared/bin/auto-fcs/explore/openCyto/fcsMapBlankMap.txt genvisis=/home/pankrat2/lane0212/genvisisOC.jar batch=16 memoryInMb=30000 threads=1 wallTimeInHour=50

cd $OUTDIR
#sed -i 's/nodes=1/nodes=cn5601/g' *.pbs

```
  - Result directories will be created in `$OUTDIR` that correspond to each batch
    - e.g `$OUTDIR/openCytoBatch_0/` ,`$OUTDIR/openCytoBatch_1/`, etc
2. Submit all .pbs scripts in `$OUTDIR`
    - e.g `qp *.pbs`
    - Current run-time on for 16 batches on 2 pankrat q nodes is ~7hrs without QC, 37hrs with QC
    
## OpenCyto results

Each batch output directory (as an example, `$OUTDIR/openCytoBatch_0/`) should contain the following:

- `gates/`: **directory containing .wsp files for each successfully gated sample**
    - each sample will have 2 .wsp files, `sampleName_panelX.wsp`, and `sampleName_panelXRename.wsp`
        - `sampleName_panelXRename.wsp` contains gates named according to the manual hierarchy
- `gatesQC/`: **directory containing .wsp files for each successfully gated sample, after QC processing**
     - also will have 2 .wsp files per sample, `sampleName_panelX.wsp`, and `sampleName_panelXRename.wsp`

- `fcsQC/`: **directory containing .fcs files representing HQ events and QC summaries, currently according to FlowAI**
     - **sampleName.fcs** : in order to reproduce the counts listed in gatesQC .wsp files, the fcs files should be used 
     - **sampleName.fcs mini.txt** : basic QC report
     - **sampleName_QC.html** : html QC report with diagnostic plots

- `gate_plotsXX.pdf`: **Plots of each OpenCyto gate**



- `metrics.totalCellCounts.txt`: **File containing total cell counts for all samples**
    - **FILE** : fcs file
    - **TOTAL_COUNTS**: total number of events in the fcs file
    - **QC** : whether QC was performed prior to counting
    - **PANEL** :  panel analyzed
    
- `metrics.txt`: **Gate metrics for each succesfully gated sample**
    - **name**         : fcs file
    - **Population**   : Cell population
    - **Parent**       : Parent population
    - **Count**        : Event count for  population
    - **ParentCount**  : Event count for parent population
    - **METRIC**       : should be always counts
    - **GATE**         : Whether we are currently reporting automatic (openCyto) or manual gating results
    - **QC**           : Whether QC was applied prior to gating
    - **Panel**           : panel1 or panel2
    - **PDF**           : name of the pdf containing plots for this sample
    - **FlaggedSample**           : placeholder to flag problematic samples for review

- `freq.metrics.txt`: **Similar to `metrics.txt`, but with additional columns, and subset to only populations of interest (intermediate gates etc are removed)**
     - **RealAutoParent** : when the `Parent` gate is actually an intermediate step, this lists the actual parent population
      - **Manual**   : Gate name in manual nomenclature
      - **Merge**   : Data key of **population_sample**
      - **freq_lymph**   : for panel1 samples, the frequency of the population relative to lymphocytes, and `NA` for panel2 samples
      - **freqParent**   : for panel1 and panel2 samples, the frequency of the population relative to the `RealAutoParent` population
      - **freq_PBMC**   : for panel2 samples, the frequency of the population relative to PBMCs, and `NA` for panel1 samples
      
      
To assemble results files from each batch, run the following from within `$OUTDIR`:

```bash

head -n 1 ./openCytoBatch_10/metrics.txt >all.metrics.txt
tail -n+2 ./openCytoBatch_*/metrics.txt |grep -v "==>">>all.metrics.txt


head -n 1 ./openCytoBatch_10/metrics.totalCellCounts.txt >all.totalCellCounts.metrics.txt
tail -n+2 ./openCytoBatch_*/metrics.totalCellCounts.txt |grep -v "==>">>all.totalCellCounts.metrics.txt

head -n 1 ./openCytoBatch_10/freq.metrics.txt >all.freq.metrics.txt
tail -n+2 ./openCytoBatch_*/freq.metrics.txt |grep -v "==>">>all.freq.metrics.txt
```
