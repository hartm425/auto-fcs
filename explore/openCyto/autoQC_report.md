---
title: "autoQC report"
author: "SIgN_GM"
output: html_document
---




## FCS file information

> Input file name: 2016-05-06_PANEL 1_ZF_panel one_F1631950_006    
> Number of events: 782527





## Quality control analysis 

### Summary

> The anomalies were removed from:  Flow Rate, Flow Signal and Flow Margin  
> Anomalies detected in total: **31.41** %  
> Number of high quality events: 536717  


### Flow rate check

> **2.97** % anomalies detected in the flow rate check.

<img src="figure/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" width="750px" style="display: block; margin: auto;" />



The plot reconstructs the flow rate with a resolution of 1/10 of a second. Anomalies in the flow rate are identified with an algorithm based on the generalied ESD outlier detection method. The anomalies are circled in green. 

### Signals acquisition check

> **28.69** % anomalies detected in the signal aquisition check. 




<img src="figure/unnamed-chunk-7-1.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" width="750px" style="display: block; margin: auto;" />

The more stable region selected consistent for all channels is highlighted in yellow. If the removal of outliers has been required before the execution of the changepoint analysis, the detected outliers are cicled in green.

The FCS file was divided in 1566 bins. The stable region is located between the bins 1 and 1116.

##### More info on the changepoints detected:

Changepoints detected in channels with shifts in signal acquisition:  


```
##               1    2
## BB515-A    1118 1526
## PE-A       1116 1525
## PE-CF594-A 1198 1526
## PE-Cy7-A   1235 1525
## BUV 395-A  1534 1561
## BUV 737-A  1241 1525
## APC-A      1257 1525
## BV 421-A   1257 1525
## BV 510-A   1257 1525
## BV 605-A   1257 1525
## BV 711-A   1257 1525
## APC-Cy7-A  1257 1525
```

Channels excluded from the analysis: FSC-A, FSC-H, FSC-W, SSC-A, SSC-H, SSC-W. 
 


### Dynamic range check

> **3.66** % anomalies detected in dynamic range check.  

<img src="figure/unnamed-chunk-11-1.png" title="plot of chunk unnamed-chunk-11" alt="plot of chunk unnamed-chunk-11" width="750px" style="display: block; margin: auto;" />

The plot shows where the anomalies occured the most. The x-axis scale is complementary to the one of the signal acquisition plot. 


##### More info on the anomalies detected in the dynamic range check:

for each channel, The table shows the number of events that did not pass the dynamic range check:


```
##              lower_range upper_range
## FSC-A                  0        8459
## FSC-H                  0           0
## FSC-W                  0          95
## SSC-A                  8       23912
## SSC-H                  0           0
## SSC-W                  0         139
## BB515-A              373          39
## PE-A                 719          53
## PE-CF594-A           329           6
## PE-Cy7-A             212          12
## BUV 395-A            444         456
## BUV 737-A            286          65
## APC-A                238          27
## BV 421-A             945        3622
## BV 510-A             756        1038
## BV 605-A             782         402
## BV 711-A             924         172
## APC-Cy7-A            511          76
## total_SUM           7364       38573
## total_UNIQUE        2548       26703
```
