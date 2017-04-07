<style>
.esmall-table table {
  border-width: 1px;
  border-spacing: 2px;
  border-style: dotted;
  border-color: gray;
  border-collapse: collapse;
  font-size: 0.4em;
}

.esmall-table table tr { line-height: 18px; }


.esmall-table table th {
  border-width: 1px;
  padding-left: 2px;
  padding-right: 2px;
  font-weight: bold;
  border-style: dotted;
  border-color: gray;
}

.esmall-table table td {
  border-width: 1px;
  padding-left: 2px;
  padding-right: 2px;
  border-style: dotted;
  border-color: gray;
}
.small-code pre code {
  font-size: .5em;
}

.small-p p{
  font-size: 8;
}

.small {  
    font-size: 8;
}


</style>

Auto gating update
========================================================
author: 
date: 
autosize: true

April 11th, 2017




OpenCyto
========================================================
<a name=cite-Finak_2014></a>[Finak, Frelinger, Jiang, et al. (2014)](https://doi.org/10.1371%2Fjournal.pcbi.1003806)
- Mimics manual gating by focusing on 2 channels at a time
  - can follow traditional gate hierarchy
  - e.g. gate lymph, then single, then live, etc
- Pipeline templates defined in .csv file
  - defines algorithmic approach for each gate to be applied across many samples
  - not "just push go", takes some setup for a decent template
- Results are interpretable and labelled populations 
  - not geared toward detecting novel cell types

OpenCyto
========================================================

> The two top performing gating algorithms - OpenCyto (v. 1.7.4), flowDensity (v. 1.4.0) - in a study run by the FlowCAP consortium aimed at selecting the best performing algorithms for this larger study were chosen for the analysis presented in this paper. ***Standardizing Flow Cytometry Immunophenotyping Analysis from the Human ImmunoPhenotyping Consortium*** <a name=cite-Finak_2016></a>[Finak, Langweiler, Jaimes, et al. (2016)](https://doi.org/10.1038%2Fsrep20686)

- Stole template from above as a start
  - our panel 1 template currently lives [here](https://github.com/PankratzLab/auto-fcs/blob/master/explore/openCyto/lymph.dev.b.csv)
  
Current progres overview 
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-1](rep1-figure/unnamed-chunk-1-1.png)


| N_SAMPS| N_DATA|    RHO|  BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|-----:|-------:|------:|------:|
|     151|   2265| 0.9867| 1.015|  0.0014| 0.9956| 0.9977|
***
![plot of chunk unnamed-chunk-3](rep1-figure/unnamed-chunk-3-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|   2265| 0.9811| 0.9879|  0.0029| 0.9809| 0.9903|

Lymphocytes (SSC-A v FSC-A)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-5](rep1-figure/unnamed-chunk-5-1.png)


| N_SAMPS| N_DATA|    RHO|  BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|-----:|-------:|------:|------:|
|     151|    151| 0.9883| 1.014|  0.0078| 0.9913| 0.9954|
***
![plot of chunk unnamed-chunk-7](rep1-figure/unnamed-chunk-7-1.png)


| N_SAMPS| N_DATA|    RHO|  BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|-----:|-------:|------:|------:|
|     151|    151| 0.9969| 1.038|   0.005| 0.9966| 0.9972|

Single Cells (FSC-H v FSC-W)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-9](rep1-figure/unnamed-chunk-9-1.png)


| N_SAMPS| N_DATA|    RHO|  BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|-----:|-------:|------:|------:|
|     151|    151| 0.9824| 1.018|  0.0087| 0.9893| 0.9935|
***
![plot of chunk unnamed-chunk-11](rep1-figure/unnamed-chunk-11-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|   ICC_1|
|-------:|------:|------:|------:|-------:|------:|-------:|
|     151|    151| 0.0546| 0.0321|  0.0225| 0.0134| -0.0297|


Live cells (PE-)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-13](rep1-figure/unnamed-chunk-13-1.png)


| N_SAMPS| N_DATA|    RHO|  BETA| BETA_SE|    R2|  ICC_1|
|-------:|------:|------:|-----:|-------:|-----:|------:|
|     151|    151| 0.9822| 1.019|  0.0088| 0.989| 0.9933|
***
![plot of chunk unnamed-chunk-15](rep1-figure/unnamed-chunk-15-1.png)


| N_SAMPS| N_DATA|   RHO|  BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|-----:|-----:|-------:|------:|------:|
|     151|    151| 0.679| 1.073|  0.0936| 0.4687| 0.6221|


Tcells (CD3+ CD19-)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-17](rep1-figure/unnamed-chunk-17-1.png)


| N_SAMPS| N_DATA|    RHO|  BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|-----:|-------:|------:|------:|
|     151|    151| 0.9958| 0.998|  0.0054| 0.9957| 0.9978|
***
![plot of chunk unnamed-chunk-19](rep1-figure/unnamed-chunk-19-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.9781| 0.9063|  0.0135| 0.9682| 0.9709|

Helper Tcells-CD4+
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-21](rep1-figure/unnamed-chunk-21-1.png)


| N_SAMPS| N_DATA|    RHO|  BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|-----:|-------:|------:|------:|
|     151|    151| 0.9987| 1.004|   0.004| 0.9977| 0.9988|
***
![plot of chunk unnamed-chunk-23](rep1-figure/unnamed-chunk-23-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.9933| 0.9647|  0.0128| 0.9744| 0.9868|

central memory helper Tcells (CCR7+ CD45RA-)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-25](rep1-figure/unnamed-chunk-25-1.png)


| N_SAMPS| N_DATA|  RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|----:|------:|-------:|------:|------:|
|     151|    151| 0.98| 0.9237|  0.0204| 0.9323| 0.9649|
***
![plot of chunk unnamed-chunk-27](rep1-figure/unnamed-chunk-27-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.9154| 0.8088|  0.0318| 0.8131| 0.8969|

effector helper Tcells (CCR7- CD45RA+)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-29](rep1-figure/unnamed-chunk-29-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.7922| 0.8244|  0.0381| 0.7587| 0.8653|
***
![plot of chunk unnamed-chunk-31](rep1-figure/unnamed-chunk-31-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.7467| 0.8182|  0.0695| 0.4816| 0.6677|

effector memory helper Tcells (CCR7- CD45RA-)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-33](rep1-figure/unnamed-chunk-33-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.8791| 0.7816|  0.0312| 0.8082| 0.8757|
***
![plot of chunk unnamed-chunk-35](rep1-figure/unnamed-chunk-35-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.8012| 0.7023|  0.0402| 0.6721| 0.7977|

naive helper Tcells (CCR7+ CD45RA+)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-37](rep1-figure/unnamed-chunk-37-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.9711| 0.9695|  0.0129| 0.9743| 0.9861|
***
![plot of chunk unnamed-chunk-39](rep1-figure/unnamed-chunk-39-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.9516| 0.7982|  0.0315| 0.8119| 0.8931|


cytotoxic Tcells-CD8+
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-41](rep1-figure/unnamed-chunk-41-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|    R2|  ICC_1|
|-------:|------:|------:|------:|-------:|-----:|------:|
|     151|    151| 0.9866| 0.9615|  0.0192| 0.944| 0.9712|
***
![plot of chunk unnamed-chunk-43](rep1-figure/unnamed-chunk-43-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.9688| 0.9794|  0.0226| 0.9268| 0.9612|


B cells (CD3- CD19+) 
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-45](rep1-figure/unnamed-chunk-45-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.9379| 0.9252|  0.0296| 0.8676| 0.9261|
***
![plot of chunk unnamed-chunk-47](rep1-figure/unnamed-chunk-47-1.png)


| N_SAMPS| N_DATA|    RHO|  BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|-----:|-------:|------:|------:|
|     151|    151| 0.8811| 1.002|  0.0429| 0.7858| 0.8715|

Summary
========================================================

- OpenCyto seems to work
- Lots of room for improvement
- Iterative process

ICC
========================================================

From [Wikipedia](https://en.wikipedia.org/wiki/Intraclass_correlation)

<a name=cite-Cicchetti_1994></a>[Cicchetti (1994)](https://doi.org/10.1037%2F1040-3590.6.4.284) gives the following often quoted guidelines for interpretation for kappa or ICC inter-rater agreement measures:

- Less than 0.40—poor.
- Between 0.40 and 0.59—Fair.
- Between 0.60 and 0.74—Good.
- Between 0.75 and 1.00—Excellent.

