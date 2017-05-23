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


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     127|   2413| 0.9687| 0.9919|  0.0033| 0.9735| 0.9866|
***
![plot of chunk unnamed-chunk-3](rep1-figure/unnamed-chunk-3-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     127|   2413| 0.9507| 0.9679|  0.0055| 0.9267| 0.9626|

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


| N_SAMPS| N_DATA|    RHO|  BETA| BETA_SE|    R2|  ICC_1|
|-------:|------:|------:|-----:|-------:|-----:|------:|
|     127|    127| 0.9152| 0.988|  0.0306| 0.893| 0.9434|
***
![plot of chunk unnamed-chunk-9](rep1-figure/unnamed-chunk-9-1.png)


| N_SAMPS| N_DATA|    RHO|  BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|-----:|-------:|------:|------:|
|     127|    127| 0.9533| 1.042|    0.02| 0.9559| 0.9756|


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
|     127|    127| 0.9125| 0.9998|  0.0311| 0.892| 0.9432|
***
![plot of chunk unnamed-chunk-15](rep1-figure/unnamed-chunk-15-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|   ICC_1|
|-------:|------:|------:|------:|-------:|------:|-------:|
|     127|    127| 0.1358| 0.1072|  0.0608| 0.0243| -0.1657|


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
|     127|    127| 0.9173| 1.007|  0.0286| 0.9081| 0.9519|
***
![plot of chunk unnamed-chunk-21](rep1-figure/unnamed-chunk-21-1.png)


| N_SAMPS| N_DATA|   RHO|   BETA| BETA_SE|    R2|  ICC_1|
|-------:|------:|-----:|------:|-------:|-----:|------:|
|     127|    127| 0.612| 0.0431|  0.0101| 0.128| 0.0678|


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


| N_SAMPS| N_DATA|  RHO|  BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|----:|-----:|-------:|------:|------:|
|     127|    127| 0.99| 1.019|  0.0098| 0.9886| 0.9939|
***
![plot of chunk unnamed-chunk-27](rep1-figure/unnamed-chunk-27-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     127|    127| 0.9716| 0.7951|  0.0226| 0.9085| 0.9358|


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


| N_SAMPS| N_DATA|    RHO|  BETA| BETA_SE|    R2|  ICC_1|
|-------:|------:|------:|-----:|-------:|-----:|------:|
|     127|    127| 0.9958| 1.018|  0.0077| 0.993| 0.9962|
***
![plot of chunk unnamed-chunk-33](rep1-figure/unnamed-chunk-33-1.png)


| N_SAMPS| N_DATA|    RHO| BETA| BETA_SE|     R2| ICC_1|
|-------:|------:|------:|----:|-------:|------:|-----:|
|     127|    127| 0.9954| 0.99|  0.0089| 0.9899| 0.995|

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


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     127|    127| 0.9757| 0.9187|  0.0227| 0.9288| 0.9629|
***
![plot of chunk unnamed-chunk-39](rep1-figure/unnamed-chunk-39-1.png)


| N_SAMPS| N_DATA|    RHO|  BETA| BETA_SE|    R2|  ICC_1|
|-------:|------:|------:|-----:|-------:|-----:|------:|
|     127|    127| 0.9124| 0.826|   0.035| 0.817| 0.9009|


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


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|    R2|  ICC_1|
|-------:|------:|------:|------:|-------:|-----:|------:|
|     127|    127| 0.8189| 0.7817|  0.0345| 0.804| 0.8859|
***
![plot of chunk unnamed-chunk-45](rep1-figure/unnamed-chunk-45-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     127|    127| 0.7972| 0.8281|  0.0453| 0.7273| 0.8395|

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
|     127|    127| 0.8547| 0.7655|   0.035| 0.7932| 0.8594|
***
![plot of chunk unnamed-chunk-51](rep1-figure/unnamed-chunk-51-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|   R2| ICC_1|
|-------:|------:|------:|------:|-------:|----:|-----:|
|     127|    127| 0.7676| 0.7263|  0.0542| 0.59| 0.753|


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


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2| ICC_1|
|-------:|------:|------:|------:|-------:|------:|-----:|
|     127|    127| 0.9651| 0.9806|  0.0175| 0.9617|  0.98|
***
![plot of chunk unnamed-chunk-57](rep1-figure/unnamed-chunk-57-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|    R2|  ICC_1|
|-------:|------:|------:|------:|-------:|-----:|------:|
|     127|    127| 0.9432| 0.7872|  0.0388| 0.767| 0.8699|

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


| N_SAMPS| N_DATA|   RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|-----:|------:|-------:|------:|------:|
|     127|    127| 0.978| 0.9849|  0.0255| 0.9227| 0.9596|
***
![plot of chunk unnamed-chunk-63](rep1-figure/unnamed-chunk-63-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     127|    127| 0.9663| 0.9786|  0.0271| 0.9122| 0.9534|

cytotoxic Tcells-CD8+
========================================================
class: esmall-table

- under-called

![](./ex/7b1bd1f4-192d-11e7-82be-472ea9c4c588.png)


central memory cytotoxic Tcells (CCR7+ , CD45RA-)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-65](rep1-figure/unnamed-chunk-65-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     127|    127| 0.3908| 0.5399|  0.0655| 0.3525| 0.5883|
***
![plot of chunk unnamed-chunk-67](rep1-figure/unnamed-chunk-67-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     127|    127| 0.4827| 0.3845|  0.0596| 0.2497| 0.4688|


effector cytotoxic Tcells  (CCR7-  CD45RA+)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-69](rep1-figure/unnamed-chunk-69-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2| ICC_1|
|-------:|------:|------:|------:|-------:|------:|-----:|
|     127|    127| 0.8426| 0.9377|  0.0731| 0.5685| 0.712|
***
![plot of chunk unnamed-chunk-71](rep1-figure/unnamed-chunk-71-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     127|    127| 0.6353| 0.5174|  0.0536| 0.4268| 0.5305|

effector memory cytotoxic Tcells (CCR7- , CD45RA-)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-73](rep1-figure/unnamed-chunk-73-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|    R2|  ICC_1|
|-------:|------:|------:|------:|-------:|-----:|------:|
|     127|    127| 0.8469| 0.1947|  0.0295| 0.258| 0.2916|
***
![plot of chunk unnamed-chunk-75](rep1-figure/unnamed-chunk-75-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|    R2|  ICC_1|
|-------:|------:|------:|------:|-------:|-----:|------:|
|     127|    127| 0.6971| 0.3061|  0.0395| 0.324| 0.3865|


naive cytotoxic Tcells (CCR7+ , CD45RA+)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-77](rep1-figure/unnamed-chunk-77-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     127|    127| 0.6942| 0.2695|  0.0375| 0.2922| 0.4165|
***
![plot of chunk unnamed-chunk-79](rep1-figure/unnamed-chunk-79-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     127|    127| 0.6381| 0.5458|  0.0596| 0.4019| 0.6202|






B cells (CD3- CD19+)
========================================================
class: esmall-table

![](./ex/B_cells__CD3-_CD19+_/F1632002_B_cells__CD3-_CD19+_.png)


|     |  FN|  FP|     TN|    TP|    ACC|   SENS|  SPEC|   PREC|
|:----|---:|---:|------:|-----:|------:|------:|-----:|------:|
|Freq | 531| 895| 937430| 15167| 0.9985| 0.9662| 0.999| 0.9443|


***

![](./ex/B_cells__CD3-_CD19+_/F1636835_B_cells__CD3-_CD19+_.png)


|     |  FN|   FP|      TN|    TP|    ACC|   SENS|   SPEC|   PREC|
|:----|---:|----:|-------:|-----:|------:|------:|------:|------:|
|Freq | 521| 8506| 2738594| 23528| 0.9967| 0.9783| 0.9969| 0.7345|

- typically over- or under-calling the sneaky Bcells on CD19 dimension

B cells (CD3- CD19+) 
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-83](rep1-figure/unnamed-chunk-83-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     127|    127| 0.9252| 0.8768|  0.0355| 0.8297| 0.8984|
***
![plot of chunk unnamed-chunk-85](rep1-figure/unnamed-chunk-85-1.png)


| N_SAMPS| N_DATA|    RHO|  BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|-----:|-------:|------:|------:|
|     127|    127| 0.8603| 1.021|  0.0497| 0.7715| 0.8614|

naive Bcells (CD27- IgD+)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-87](rep1-figure/unnamed-chunk-87-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     127|    127| 0.9056| 0.7306|  0.0458| 0.6706| 0.7855|
***
![plot of chunk unnamed-chunk-89](rep1-figure/unnamed-chunk-89-1.png)


| N_SAMPS| N_DATA|    RHO|  BETA| BETA_SE|     R2| ICC_1|
|-------:|------:|------:|-----:|-------:|------:|-----:|
|     127|    127| 0.9221| 0.911|  0.0369| 0.8298| 0.887|

IgD- memory Bcells (CD27+)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-91](rep1-figure/unnamed-chunk-91-1.png)


| N_SAMPS| N_DATA|   RHO| BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|-----:|----:|-------:|------:|------:|
|     127|    127| 0.801| 1.17|  0.0487| 0.8217| 0.8746|
***
![plot of chunk unnamed-chunk-93](rep1-figure/unnamed-chunk-93-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     127|    127| 0.8227| 0.5115|  0.0535| 0.4228| 0.6083|

IgD+ memory Bcells (CD27+)
========================================================
class: esmall-table

![plot of chunk unnamed-chunk-95](rep1-figure/unnamed-chunk-95-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|   R2|  ICC_1|
|-------:|------:|------:|------:|-------:|----:|------:|
|     127|    127| 0.8974| 0.7109|   0.013| 0.96| 0.9207|
***
![plot of chunk unnamed-chunk-97](rep1-figure/unnamed-chunk-97-1.png)


| N_SAMPS| N_DATA|    RHO|   BETA| BETA_SE|     R2|  ICC_1|
|-------:|------:|------:|------:|-------:|------:|------:|
|     127|    127| 0.8815| 0.7369|  0.0372| 0.7584| 0.8468|


OpenCyto Summary
========================================================

- Seems to work
- Lots of room for improvement
- Iterative process

 
Data QC ?
========================================================
Tested FlowAI
> ... consists of three key steps to check and remove suspected anomalies that derive from (i) abrupt changes in the flow rate, (ii) instability of signal acquisition and (iii) outliers in the lower limit and margin events in the upper limit of the dynamic range. ***flowAI: automatic and interactive anomaly discerning tools for flow cytometry data.*** <a name=cite-Monaco_2016></a>[Monaco, Chen, Poidinger, et al. (2016)](https://doi.org/10.1093%2Fbioinformatics%2Fbtw191)

[Strange Flowrate Example](http://htmlpreview.github.io/?https://github.com/PankratzLab/auto-fcs/blob/master/explore/openCyto/QC/qcReview/2016-07-27_PANEL%201_ZF_Group%20one_F1632384_007_QC.html)

[Normal Flowrate Example](http://htmlpreview.github.io/?https://github.com/PankratzLab/auto-fcs/blob/master/explore/openCyto/QC/qcReview/2016-05-13_PANEL%201_ZF_panel%20one_F1632233_004_QC.html)


TSNE
========================================================
Neat, TODO is to generate for manual and OpenCyto gates

![](./ex/plot7-1.png)

- manual (Panel2)
  
***

![](./ex/plot6-1.png)

- phenograph populations (Panel2) <a name=cite-Levine_2015></a>[Levine, Simonds, Bendall, et al. (2015)](https://doi.org/10.1016%2Fj.cell.2015.05.047)
