#!/usr/bin/env bash 


scp msi:/home/thyagara/shared/HRS/annotation/r23/panel1/*/*cytotoxic_Tcells-CD8+.png ./


scp msi:/scratch.global/lanej/flow/full/fcs/*F1652726_008* ./

scp msi:/scratch.global/lanej/flow/full/fcs/*F1632228_009* ./




scp msi:/scratch.global/lanej/flow/full/fcs/*F1653116_011* ./
scp msi:/scratch.global/lanej/flow/full/fcs/*F1635759_033* ./
scp msi:/scratch.global/lanej/flow/full/fcs/*F1635741_026* ./
scp msi:/scratch.global/lanej/flow/full/fcs/*F1653141_026* ./


scp msi:/scratch.global/lanej/flow/full/fcs/*F1634262_036* ./
scp msi:/scratch.global/lanej/flow/full/fcs/*F1635738_024* ./
scp msi:/scratch.global/lanej/flow/full/fcs/*F1642545_006* ./


scp msi:/scratch.global/lanej/flow/full/fcs/*F1635689_022* ./
scp msi:/scratch.global/lanej/flow/full/fcs/*F1652389_016* ./
scp msi:/scratch.global/lanej/flow/full/fcs/*F1634341_039* ./

scp msi:/scratch.global/lanej/flow/full/fcs/*F1635792_023* ./
scp msi:/scratch.global/lanej/flow/full/fcs/*F1652236_017* ./
scp msi:/scratch.global/lanej/flow/full/fcs/*F1637970_014* ./

scp msi:/scratch.global/lanej/flow/full/fcs/*F1652417_010* ./
scp msi:/scratch.global/lanej/flow/full/fcs/*F1635796_038* ./


scp msi:/scratch.global/lanej/flow/full/fcs/*F1652417_010* ./

scp msi:/scratch.global/lanej/flow/full/fcs/*F1653150_021* ./

scp msi:/scratch.global/lanej/flow/full/fcs/*F1637121_017* ./
scp msi:/scratch.global/lanej/flow/full/fcs/*F1637106_031* ./
scp msi:/scratch.global/lanej/flow/full/fcs/*F1653165_014* ./

scp msi:/scratch.global/lanej/flow/full/fcs/*F1632269* ./

scp msi:/scratch.global/lanej/flow/full/fcs/*F1634020_019* ./


rev=lymphBcellTest_77_67/
mkdir ./Live_Single_PBMCs__SSC
mkdir ./Tcells__CD3
mkdir ./cytotoxic_Tcells
mkdir ./Lymph

scp msi:/home/thyagara/shared/HRS/annotation/$rev"panel1"/*/*Tcells__CD3+_CD19-_* ./Tcells__CD3

scp msi:/home/thyagara/shared/HRS/annotation/$rev"panel2"/*/*Live_Single_PBMCs__SSC-A_FSC-A* ./Live_Single_PBMCs__SSC
scp msi:/home/thyagara/shared/HRS/annotation/$rev"panel1"/*/*cytotoxic_Tcells-CD8+.png ./cytotoxic_Tcells

scp msi:/home/thyagara/shared/HRS/annotation/$rev"panel1"/*/*Lymph* ./Lymph



