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

![plot of chunk unnamed-chunk-1](rep1-figure/unnamed-chunk-1-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|    R2|  ICC_1|
|-------:|------:|------:|------:|-------:|-----:|------:|
|     151|   3171| 0.9609| 0.9815|  0.0029| 0.973| 0.9863|
***
![plot of chunk unnamed-chunk-3](rep1-figure/unnamed-chunk-3-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2| ICC_1|
|-------:|------:|------:|------:|-------:|------:|-----:|
|     151|   3171| 0.9468| 0.9751|  0.0044| 0.9392| 0.969|

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

![plot of chunk unnamed-chunk-7](rep1-figure/unnamed-chunk-7-1.png)


| N_SAMPS| N_DATA|    RHO|  BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|-----:|-------:|------:|------:|
|     151|    151| 0.9078| 0.969|  0.0269| 0.8971| 0.9457|
***
![plot of chunk unnamed-chunk-9](rep1-figure/unnamed-chunk-9-1.png)


| N_SAMPS| N_DATA|    RHO|  BETA| BETA_SE|     R2| ICC_1|
|-------:|------:|------:|-----:|-------:|------:|-----:|
|     151|    151| 0.9447| 1.035|   0.019| 0.9524| 0.974|


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

![plot of chunk unnamed-chunk-13](rep1-figure/unnamed-chunk-13-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|    R2|  ICC_1|
|-------:|------:|------:|------:|-------:|-----:|------:|
|     151|    151| 0.9061| 0.9759|  0.0274| 0.895| 0.9454|
***
![plot of chunk unnamed-chunk-15](rep1-figure/unnamed-chunk-15-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|   ICC_1|
|-------:|------:|------:|------:|-------:|------:|-------:|
|     151|    151| 0.1402| 0.0683|  0.0331| 0.0278| -0.0332|


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

![plot of chunk unnamed-chunk-19](rep1-figure/unnamed-chunk-19-1.png)


| N_SAMPS| N_DATA|    RHO|  BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|-----:|-------:|------:|------:|
|     151|    151| 0.9105| 0.988|  0.0251| 0.9124| 0.9548|
***
![plot of chunk unnamed-chunk-21](rep1-figure/unnamed-chunk-21-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.6048| 0.0486|  0.0094| 0.1511| 0.0774|


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

![plot of chunk unnamed-chunk-25](rep1-figure/unnamed-chunk-25-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.9811| 0.9967|  0.0121| 0.9784| 0.9887|
***
![plot of chunk unnamed-chunk-27](rep1-figure/unnamed-chunk-27-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.9698| 0.8094|  0.0203| 0.9144| 0.9414|


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

![plot of chunk unnamed-chunk-31](rep1-figure/unnamed-chunk-31-1.png)


| N_SAMPS| N_DATA|    RHO|  BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|-----:|-------:|------:|------:|
|     151|    151| 0.9945| 0.996|   0.008| 0.9904| 0.9942|
***
![plot of chunk unnamed-chunk-33](rep1-figure/unnamed-chunk-33-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.9912| 0.9926|  0.0105| 0.9836| 0.9895|

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

![plot of chunk unnamed-chunk-37](rep1-figure/unnamed-chunk-37-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2| ICC_1|
|-------:|------:|------:|------:|-------:|------:|-----:|
|     151|    151| 0.9708| 0.9251|  0.0216| 0.9249| 0.961|
***
![plot of chunk unnamed-chunk-39](rep1-figure/unnamed-chunk-39-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.8531| 0.7354|  0.0416| 0.6768| 0.8183|


effector helper Tcells (CCR7- CD45RA+)
========================================================
class: esmall-table

![](./ex/effector_helper_Tcells__CCR7-_CD45RA+_/F1631920_effector_helper_Tcells__CCR7-_CD45RA+_.png)


|     |   FN|   FP|      TN|    TP|    ACC|  SENS|   SPEC|   PREC|
|:----|----:|----:|-------:|-----:|------:|-----:|------:|------:|
|Freq | 3307| 1114| 2113444| 22741| 0.9979| 0.873| 0.9995| 0.9533|

***

![](./ex/effector_helper_Tcells__CCR7-_CD45RA+_/F1631974_effector_helper_Tcells__CCR7-_CD45RA+_.png)


|     |    FN|  FP|      TN| TP|    ACC|   SENS|   SPEC|   PREC|
|:----|-----:|---:|-------:|--:|------:|------:|------:|------:|
|Freq | 14718| 427| 1414249| 68| 0.9894| 0.0046| 0.9997| 0.1374|
 

effector helper Tcells (CCR7- CD45RA+)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-43](rep1-figure/unnamed-chunk-43-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.7584| 0.5688|  0.0314| 0.6879| 0.7751|
***
![plot of chunk unnamed-chunk-45](rep1-figure/unnamed-chunk-45-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.7004| 0.6306|  0.0581| 0.4412| 0.6607|

effector memory helper Tcells (CCR7- CD45RA-)
========================================================
class: esmall-table

![]( ./ex/effector_memory_helper_Tcells__CCR7-_CD45RA-_/F1632091_effector_memory_helper_Tcells__CCR7-_CD45RA-_.png)


|     |   FN|  FP|      TN|   TP|    ACC|   SENS|   SPEC|  PREC|
|:----|----:|---:|-------:|----:|------:|------:|------:|-----:|
|Freq | 1509| 240| 1382591| 6821| 0.9987| 0.8188| 0.9998| 0.966|

***

![](./ex/effector_memory_helper_Tcells__CCR7-_CD45RA-_/F1632134_effector_memory_helper_Tcells__CCR7-_CD45RA-_.png)


|     |  FN|   FP|     TN|    TP|    ACC|   SENS|  SPEC|   PREC|
|:----|---:|----:|------:|-----:|------:|------:|-----:|------:|
|Freq | 974| 6718| 948445| 12272| 0.9921| 0.9265| 0.993| 0.6462|


effector memory helper Tcells (CCR7- CD45RA-)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-49](rep1-figure/unnamed-chunk-49-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.8772| 0.7078|  0.0289| 0.8013| 0.8459|
***
![plot of chunk unnamed-chunk-51](rep1-figure/unnamed-chunk-51-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|   R2|  ICC_1|
|-------:|------:|------:|------:|-------:|----:|------:|
|     151|    151| 0.7775| 0.7035|  0.0442| 0.63| 0.7765|


naive helper Tcells (CCR7+ CD45RA+)
========================================================
class: esmall-table

![](./ex/naive_helper_Tcells__CCR7+_CD45RA+_/F1632002_naive_helper_Tcells__CCR7+_CD45RA+_.png)


|     |  FN|  FP|     TN|    TP|    ACC|   SENS|   SPEC|  PREC|
|:----|---:|---:|------:|-----:|------:|------:|------:|-----:|
|Freq | 827| 244| 926060| 26892| 0.9989| 0.9702| 0.9997| 0.991|

***

![](./ex/naive_helper_Tcells__CCR7+_CD45RA+_/F1632098_naive_helper_Tcells__CCR7+_CD45RA+_.png)


|     |    FN|  FP|     TN|    TP|    ACC|   SENS|   SPEC|   PREC|
|:----|-----:|---:|------:|-----:|------:|------:|------:|------:|
|Freq | 18678| 251| 789709| 19155| 0.9771| 0.5063| 0.9997| 0.9871|

naive helper Tcells (CCR7+ CD45RA+)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-55](rep1-figure/unnamed-chunk-55-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|    R2|  ICC_1|
|-------:|------:|------:|------:|-------:|-----:|------:|
|     151|    151| 0.9683| 0.9663|  0.0134| 0.972| 0.9856|
***
![plot of chunk unnamed-chunk-57](rep1-figure/unnamed-chunk-57-1.png)


| N_SAMPS| N_DATA|    RHO|  BETA| BETA_SE|     R2| ICC_1|
|-------:|------:|------:|-----:|-------:|------:|-----:|
|     151|    151| 0.9178| 0.738|  0.0381| 0.7162| 0.838|

cytotoxic Tcells-CD8+
========================================================
class: esmall-table

![](./ex/cytotoxic_Tcells-CD8+/F1631273_cytotoxic_Tcells-CD8+.png)


|     |   FN|   FP|      TN|    TP|    ACC|   SENS|   SPEC|   PREC|
|:----|----:|----:|-------:|-----:|------:|------:|------:|------:|
|Freq | 2478| 2311| 1665944| 30763| 0.9972| 0.9255| 0.9986| 0.9301|


***

![]( ./ex/cytotoxic_Tcells-CD8+/F1632134_cytotoxic_Tcells-CD8+.png)


|     |   FN|   FP|     TN|    TP|    ACC|   SENS|   SPEC|   PREC|
|:----|----:|----:|------:|-----:|------:|------:|------:|------:|
|Freq | 2892| 5308| 926823| 33386| 0.9915| 0.9203| 0.9943| 0.8628|

cytotoxic Tcells-CD8+
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-61](rep1-figure/unnamed-chunk-61-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.9786| 0.9468|   0.022| 0.9256| 0.9611|
***
![plot of chunk unnamed-chunk-63](rep1-figure/unnamed-chunk-63-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.9505| 0.9599|  0.0327| 0.8524| 0.9221|

cytotoxic Tcells-CD8+
========================================================
class: esmall-table

- under-called

![](./ex/7b1bd1f4-192d-11e7-82be-472ea9c4c588.png)


activated cytotoxic Tcells (CD8+ HLA-DR+)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-65](rep1-figure/unnamed-chunk-65-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.6857| 0.4096|   0.047| 0.3376| 0.2755|
***
![plot of chunk unnamed-chunk-67](rep1-figure/unnamed-chunk-67-1.png)


| N_SAMPS| N_DATA|    RHO| BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|----:|-------:|------:|------:|
|     151|    151| 0.0558| 42.4|   20.96| 0.0267| -0.548|


central memory cytotoxic Tcells (CCR7+ , CD45RA-)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-69](rep1-figure/unnamed-chunk-69-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.4222| 0.5092|  0.0724| 0.2491| 0.4988|
***
![plot of chunk unnamed-chunk-71](rep1-figure/unnamed-chunk-71-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.5344| 0.3619|  0.0789| 0.1236| 0.3473|


effector cytotoxic Tcells  (CCR7-  CD45RA+)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-73](rep1-figure/unnamed-chunk-73-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.9009| 0.9028|  0.0462| 0.7196| 0.8391|
***
![plot of chunk unnamed-chunk-75](rep1-figure/unnamed-chunk-75-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2| ICC_1|
|-------:|------:|------:|------:|-------:|------:|-----:|
|     151|    151| 0.7775| 0.6369|  0.0433| 0.5923| 0.692|

effector memory cytotoxic Tcells (CCR7- , CD45RA-)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-77](rep1-figure/unnamed-chunk-77-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     151|    151| 0.8575| 0.2053|  0.0307| 0.2307| 0.3077|
***
![plot of chunk unnamed-chunk-79](rep1-figure/unnamed-chunk-79-1.png)

EM3 cytotoxic Tcells (CD27- CD28-)
========================================================
class: esmall-table






















































```
Error in `$<-.data.frame`(`*tmp*`, Example, value = "ANY") : 
  replacement has 1 row, data has 0
```
