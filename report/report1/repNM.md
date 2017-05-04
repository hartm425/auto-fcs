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
 
ICC
========================================================

From [Wikipedia](https://en.wikipedia.org/wiki/Intraclass_correlation)

<a name=cite-Cicchetti_1994></a>[Cicchetti (1994)](https://doi.org/10.1037%2F1040-3590.6.4.284) gives the following often quoted guidelines for interpretation for kappa or ICC inter-rater agreement measures:

- Less than 0.40—poor.
- Between 0.40 and 0.59—Fair.
- Between 0.60 and 0.74—Good.
- Between 0.75 and 1.00—Excellent.
  
Current progress overview 
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-1](repNM-figure/unnamed-chunk-1-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|      71|    852| 0.8747| 0.9456|  0.0167| 0.7905| 0.8821|
***
![plot of chunk unnamed-chunk-3](repNM-figure/unnamed-chunk-3-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|      71|    852| 0.9408| 0.9914|   0.011| 0.9052| 0.9489|

Example OpenCyto gates
========================================================
class: esmall-table

![](./ex/1.png)

***
![](./ex/2.png)

Next few slides
========================================================
class: esmall-table

- For each gate
  - a good-ish example of an auto gate
  - a bad example/common problems
  - overview of gate performance
 
Lymphocytes (SSC-A v FSC-A)
========================================================
class: esmall-table

![](./ex/Lymphocytes__SSC-A_v_FSC-A_/F1632338_Lymphocytes__SSC-A_v_FSC-A_.png)


|     |   FN|     TN|    TP| FP|    ACC|   SENS| SPEC| PREC|
|:----|----:|------:|-----:|--:|------:|------:|----:|----:|
|Freq | 1490| 142572| 28420|  0| 0.9914| 0.9502|    1|    1|
***

![](./ex/Lymphocytes__SSC-A_v_FSC-A_/F1636819_Lymphocytes__SSC-A_v_FSC-A_.png)


|     |   FN|    FP|     TN|    TP|    ACC|   SENS|   SPEC|   PREC|
|:----|----:|-----:|------:|-----:|------:|------:|------:|------:|
|Freq | 2849| 22579| 778949| 38211| 0.9698| 0.9306| 0.9718| 0.6286|

- may decrease the quantile of lymph cluster from 95% back to 90%


Lymphocytes (SSC-A v FSC-A)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-7](repNM-figure/unnamed-chunk-7-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|    R2|  ICC_1|
|-------:|------:|------:|------:|-------:|-----:|------:|
|      71|     71| 0.8415| 0.8147|  0.0665| 0.685| 0.8232|
***
![plot of chunk unnamed-chunk-9](repNM-figure/unnamed-chunk-9-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|    R2|  ICC_1|
|-------:|------:|------:|------:|-------:|-----:|------:|
|      71|     71| 0.7261| 0.8481|  0.0784| 0.629| 0.7792|


Single Cells (FSC-H v FSC-W)
========================================================
class: esmall-table

![](./ex/Single_Cells__FSC-H_v_FSC-W_/F1631960_Single_Cells__FSC-H_v_FSC-W_.png)



|     |  FN|    FP|      TN|    TP|    ACC|   SENS|   SPEC|   PREC|
|:----|---:|-----:|-------:|-----:|------:|------:|------:|------:|
|Freq | 224| 10743| 1096246| 84062| 0.9908| 0.9973| 0.9903| 0.8867|

***

![](./ex/Single_Cells__FSC-H_v_FSC-W_/F1632353_Single_Cells__FSC-H_v_FSC-W_.png)


|     |    FN|     TN|     TP| FP|   ACC|  SENS| SPEC| PREC|
|:----|-----:|------:|------:|--:|-----:|-----:|----:|----:|
|Freq | 20389| 869379| 181526|  0| 0.981| 0.899|    1|    1|

- Force FSC-W+ to have a minimum cutoff or make more inclusive ? What is the manual strategy?

Single Cells (FSC-H v FSC-W)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-13](repNM-figure/unnamed-chunk-13-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|      71|     71| 0.7862| 0.8146|  0.0708| 0.6575| 0.7959|
***
![plot of chunk unnamed-chunk-15](repNM-figure/unnamed-chunk-15-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|   ICC_1|
|-------:|------:|------:|------:|-------:|------:|-------:|
|      71|     71| 0.2338| 0.0195|  0.0075| 0.0894| -0.1613|


Live cells (PE-)
========================================================
class: esmall-table

![](./ex/Live_cells__PE-_/F1631960_Live_cells__PE-_.png)


|     |  FN|    FP|      TN|    TP|    ACC|   SENS|   SPEC|   PREC|
|:----|---:|-----:|-------:|-----:|------:|------:|------:|------:|
|Freq | 213| 10668| 1096940| 83454| 0.9909| 0.9975| 0.9904| 0.8867|


***

![](./ex/Live_cells__PE-_/F1636856_Live_cells__PE-_.png)


|     |    FN|   FP|     TN|     TP|   ACC|   SENS|   SPEC|   PREC|
|:----|-----:|----:|------:|------:|-----:|------:|------:|------:|
|Freq | 17050| 7378| 476522| 178534| 0.964| 0.9128| 0.9848| 0.9603|

- victim of singlet gate

Live cells (PE-)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-19](repNM-figure/unnamed-chunk-19-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|    R2|  ICC_1|
|-------:|------:|------:|------:|-------:|-----:|------:|
|      71|     71| 0.7882| 0.8202|   0.071| 0.659| 0.7961|
***
![plot of chunk unnamed-chunk-21](repNM-figure/unnamed-chunk-21-1.png)


| N_SAMPS| N_DATA|   RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|-----:|------:|-------:|------:|------:|
|      71|     71| 0.479| 0.5307|  0.0803| 0.3877| 0.5986|


Tcells (CD3+ CD19-)
========================================================
class: esmall-table

![](./ex/Tcells__CD3+_CD19-_/F1636774_Tcells__CD3+_CD19-_.png)


|     |   FN|  FP|      TN|     TP|    ACC|   SENS|   SPEC|  PREC|
|:----|----:|---:|-------:|------:|------:|------:|------:|-----:|
|Freq | 4244| 273| 1454088| 136130| 0.9972| 0.9698| 0.9998| 0.998|

***

![](./ex/Tcells__CD3+_CD19-_/F1632006_Tcells__CD3+_CD19-_.png)


|     |   FN|   FP|     TN|    TP|    ACC|   SENS|  SPEC|   PREC|
|:----|----:|----:|------:|-----:|------:|------:|-----:|------:|
|Freq | 1393| 3028| 603276| 43658| 0.9932| 0.9691| 0.995| 0.9351|
    
- can trim sides (and a bit less on left side)

Tcells (CD3+ CD19-)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-25](repNM-figure/unnamed-chunk-25-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|      71|     71| 0.5721| 0.7552|  0.0722| 0.6133| 0.7546|
***
![plot of chunk unnamed-chunk-27](repNM-figure/unnamed-chunk-27-1.png)


| N_SAMPS| N_DATA|    RHO|  BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|-----:|-------:|------:|------:|
|      71|     71| 0.7501| 0.217|  0.0393| 0.3063| 0.2738|


Helper Tcells-CD4+
========================================================
class: esmall-table


![](./ex/Helper_Tcells-CD4+/F1632278_Helper_Tcells-CD4+.png )


|     |  FN|  FP|     TN|   TP|    ACC|   SENS|   SPEC|   PREC|
|:----|---:|---:|------:|----:|------:|------:|------:|------:|
|Freq | 880| 104| 524259| 6874| 0.9982| 0.8865| 0.9998| 0.9851|


***

![](./ex/Helper_Tcells-CD4+/F1632353_Helper_Tcells-CD4+.png)


|     |   FN|   FP|     TN|    TP|    ACC|  SENS|   SPEC|   PREC|
|:----|----:|----:|------:|-----:|------:|-----:|------:|------:|
|Freq | 5807| 7577| 963616| 94294| 0.9875| 0.942| 0.9922| 0.9256|

Helper Tcells-CD4+
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-31](repNM-figure/unnamed-chunk-31-1.png)


| N_SAMPS| N_DATA|   RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|-----:|------:|-------:|------:|------:|
|      71|     71| 0.568| 0.7347|  0.0868| 0.5097| 0.6772|
***
![plot of chunk unnamed-chunk-33](repNM-figure/unnamed-chunk-33-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|      71|     71| 0.8793| 0.7288|  0.0618| 0.6684| 0.7932|

central memory helper Tcells (CCR7+ CD45RA-)
========================================================
class: esmall-table

![](./ex/central_memory_helper_Tcells__CCR7+_CD45RA-_/F1632098_central_memory_helper_Tcells__CCR7+_CD45RA-_.png)
 

|     |   FN|  FP|     TN|    TP|    ACC|   SENS|   SPEC|   PREC|
|:----|----:|---:|------:|-----:|------:|------:|------:|------:|
|Freq | 9690| 660| 764298| 53145| 0.9875| 0.8458| 0.9991| 0.9877|


***

![](./ex/central_memory_helper_Tcells__CCR7+_CD45RA-_/F1632235_central_memory_helper_Tcells__CCR7+_CD45RA-_.png)


|     |   FN|    FP|      TN|    TP|    ACC|   SENS|   SPEC|  PREC|
|:----|----:|-----:|-------:|-----:|------:|------:|------:|-----:|
|Freq | 1069| 11497| 1698781| 28289| 0.9928| 0.9636| 0.9933| 0.711|

 



central memory helper Tcells (CCR7+ CD45RA-)
========================================================
class: esmall-table






























































































```
Error in `$<-.data.frame`(`*tmp*`, "Example", value = "ANY") : 
  replacement has 1 row, data has 0
```
