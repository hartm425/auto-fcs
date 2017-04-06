# plotPropCount
JL  
4/3/2017  


```r
library(knitr)
library(ggplot2)
theme_set(theme_bw(15))
map = read.delim("/Users/Kitty/git/auto-fcs/explore/openCyto/autoManMap.txt",stringsAsFactors = FALSE,sep = "\t") 
metrics =read.delim("/Volumes/Beta/data/flow/testTypesTestMetrics5.txt",stringsAsFactors = FALSE,sep = "\t") 
metrics$freqParent = metrics$Count/metrics$ParentCount
metrics$nameOrig = metrics$name
metrics$name =gsub(".fcs.*","",metrics$name ,fixed = FALSE)
metrics$name =gsub(" ","",metrics$name ,fixed = TRUE)

metricsMan = metrics[which(metrics$GATE=="MANUAL"&metrics$Population %in% map$Manual&metrics$METRIC=="count"),]
metricsAuto = metrics[which(metrics$GATE=="AUTOMATIC"&metrics$QC=="FALSE"&metrics$Population %in% map$Auto&metrics$METRIC=="count"),]

metricsMan = merge(metricsMan,map,by.x = "Population",by.y = "Manual")
metricsMan$Population =metricsMan$Auto
metricsMan$Merge=paste(metricsMan$Population,metricsMan$name,sep = "_")
metricsAuto = merge(metricsAuto,map,by.x = "Population",by.y = "Auto")
metricsAuto$Merge=paste(metricsAuto$Population,metricsAuto$name,sep = "_")
metricCombo = merge(metricsAuto,metricsMan,by.x = "Merge",by.y = "Merge")

p = ggplot(metricCombo,aes(x=Count.x,y=Count.y, color=Population.x)) +geom_point()+xlab("Autogating population count")+ylab("Manual gating population count")+geom_abline(intercept = 0, slope = 1) 
p 
```

![](plotPropCount_files/figure-html/setup-1.png)<!-- -->

```r
p+facet_wrap(~Population.x)
```

![](plotPropCount_files/figure-html/setup-2.png)<!-- -->

```r
for(pop in unique(map$Auto)) {
  sub = metricCombo[which(metricCombo$Population.x == pop), ]
  t =cor.test(sub$Count.x,sub$Count.y)
  ts =cor.test(sub$Count.x,sub$Count.y,method = "spearman")
  fit = lm(Count.x~Count.y,data=sub)
  sum = summary(fit)
  p = ggplot(sub, aes(x =
  Count.x, y = Count.y, color = FlaggedSample.x)) + geom_point() + xlab("Autogating population count") +
  ylab("Manual gating population count") + geom_abline(intercept = 0, slope = 1)+ labs(title = paste(pop,"n=",length(sub$Count.x),"- pearson r =",signif(t$estimate,4),"- spearman r =",signif(ts$estimate,4),"\n beta =",signif(sum$coefficients[2],4),"r^2 = ",signif(sum$r.squared)))
  print(p)

    # print(summary(fit))
  #  p = ggplot(sub, aes(x =
  # freqParent.x, y = freqParent.y, color = FlaggedSample.x)) + geom_point() + xlab("Autogating population count") +
  # ylab("Manual gating population count") + geom_abline(intercept = 0, slope = 1)+ labs(title = paste(pop,"n=",length(sub$Count.x),"- pearson r =",signif(t$estimate,4),"- spearman r =",signif(ts$estimate,4)))
  # print(p)
}
```

![](plotPropCount_files/figure-html/setup-3.png)<!-- -->![](plotPropCount_files/figure-html/setup-4.png)<!-- -->![](plotPropCount_files/figure-html/setup-5.png)<!-- -->![](plotPropCount_files/figure-html/setup-6.png)<!-- -->![](plotPropCount_files/figure-html/setup-7.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-8.png)<!-- -->![](plotPropCount_files/figure-html/setup-9.png)<!-- -->![](plotPropCount_files/figure-html/setup-10.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-11.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-12.png)<!-- -->![](plotPropCount_files/figure-html/setup-13.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-14.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-15.png)<!-- -->![](plotPropCount_files/figure-html/setup-16.png)<!-- -->![](plotPropCount_files/figure-html/setup-17.png)<!-- -->

```r
 cor.test(metricCombo$Count.x,metricCombo$Count.y,method = "spearman")
```

```
## Warning in cor.test.default(metricCombo$Count.x, metricCombo$Count.y,
## method = "spearman"): Cannot compute exact p-value with ties
```

```
## 
## 	Spearman's rank correlation rho
## 
## data:  metricCombo$Count.x and metricCombo$Count.y
## S = 13232000, p-value < 2.2e-16
## alternative hypothesis: true rho is not equal to 0
## sample estimates:
##       rho 
## 0.9784734
```

```r
look = metricCombo[which(metricCombo$Population.x=="CCR7+CD45RA+"),]
kable(look[,c("PDF.x","Count.x","Count.y","name.x")])
```

      PDF.x                                         Count.x   Count.y  name.x                                      
----  -------------------------------------------  --------  --------  --------------------------------------------
413   /Volumes/Beta/data/flow/panel1_test5_1.pdf      18472      1492  2016-05-05_PANEL1_HB_panelone_F1631931_006  
414   /Volumes/Beta/data/flow/panel1_test5_1.pdf      18376     18497  2016-05-05_PANEL1_HB_panelone_F1631958_002  
415   /Volumes/Beta/data/flow/panel1_test5_1.pdf      20618     20889  2016-05-05_PANEL1_HB_panelone_F1631959_005  
416   /Volumes/Beta/data/flow/panel1_test5_1.pdf      21858     23056  2016-05-05_PANEL1_HB_panelone_F1631960_004  
417   /Volumes/Beta/data/flow/panel1_test5_1.pdf      23791     30594  2016-05-05_PANEL1_HB_panelone_F1631961_003  
418   /Volumes/Beta/data/flow/panel1_test5_1.pdf      42011     46389  2016-05-06_PANEL1_ZF_panelone_F1631944_005  
419   /Volumes/Beta/data/flow/panel1_test5_1.pdf      29901     32167  2016-05-06_PANEL1_ZF_panelone_F1631950_006  
420   /Volumes/Beta/data/flow/panel1_test5_1.pdf      47246     49913  2016-05-06_PANEL1_ZF_panelone_F1631954_003  
421   /Volumes/Beta/data/flow/panel1_test5_1.pdf      32409     37961  2016-05-06_PANEL1_ZF_panelone_F1631956_004  
422   /Volumes/Beta/data/flow/panel1_test5_1.pdf      13430     17361  2016-05-06_PANEL1_ZF_panelone_F1631957_002  
423   /Volumes/Beta/data/flow/panel1_test5_1.pdf      13751     15699  2016-05-11_PANEL1_ZF_panelone_F1631919_009  
424   /Volumes/Beta/data/flow/panel1_test5_1.pdf      33218     37945  2016-05-11_PANEL1_ZF_panelone_F1631920_007  
425   /Volumes/Beta/data/flow/panel1_test5_1.pdf      14826     15930  2016-05-11_PANEL1_ZF_panelone_F1631925_005  
426   /Volumes/Beta/data/flow/panel1_test5_1.pdf      26925     27662  2016-05-11_PANEL1_ZF_panelone_F1631942_008  
427   /Volumes/Beta/data/flow/panel1_test5_1.pdf      19256     21871  2016-05-11_PANEL1_ZF_panelone_F1632171_002  
428   /Volumes/Beta/data/flow/panel1_test5_2.pdf       1526      7489  2016-05-11_PANEL1_ZF_panelone_F1632176_004  
429   /Volumes/Beta/data/flow/panel1_test5_2.pdf     164337    164776  2016-05-11_PANEL1_ZF_panelone_F1632184_001  
430   /Volumes/Beta/data/flow/panel1_test5_2.pdf      37339     37047  2016-05-11_PANEL1_ZF_panelone_F1632214_010  
431   /Volumes/Beta/data/flow/panel1_test5_2.pdf      18446     21265  2016-05-11_PANEL1_ZF_panelone_F1632227_006  
432   /Volumes/Beta/data/flow/panel1_test5_2.pdf        203     25849  2016-05-11_PANEL1_ZF_panelone_F1632229_003  
433   /Volumes/Beta/data/flow/panel1_test5_2.pdf      34813     34301  2016-05-13_PANEL1_ZF_panelone_F1631922_003  
434   /Volumes/Beta/data/flow/panel1_test5_2.pdf      43048     44901  2016-05-13_PANEL1_ZF_panelone_F1631924_001  
435   /Volumes/Beta/data/flow/panel1_test5_2.pdf      58386     61750  2016-05-13_PANEL1_ZF_panelone_F1632182_002  
436   /Volumes/Beta/data/flow/panel1_test5_2.pdf       2269      3086  2016-05-13_PANEL1_ZF_panelone_F1632233_004  
437   /Volumes/Beta/data/flow/panel1_test5_2.pdf      37540     41724  2016-05-13_PANEL1_ZF_panelone_F1632235_005  
438   /Volumes/Beta/data/flow/panel1_test5_2.pdf        468      8904  2016-05-18_PANEL1_ZF_panelone_F1631974_008  
439   /Volumes/Beta/data/flow/panel1_test5_2.pdf      53601     57989  2016-05-18_PANEL1_ZF_panelone_F1631977_003  
440   /Volumes/Beta/data/flow/panel1_test5_2.pdf       8189      8805  2016-05-18_PANEL1_ZF_panelone_F1631988_002  
441   /Volumes/Beta/data/flow/panel1_test5_2.pdf      12422     13551  2016-05-18_PANEL1_ZF_panelone_F1631990_005  
442   /Volumes/Beta/data/flow/panel1_test5_2.pdf       4538      6187  2016-05-18_PANEL1_ZF_panelone_F1631991_012  
443   /Volumes/Beta/data/flow/panel1_test5_3.pdf      38728     39990  2016-05-18_PANEL1_ZF_panelone_F1631995_001  
444   /Volumes/Beta/data/flow/panel1_test5_3.pdf      26614     27715  2016-05-18_PANEL1_ZF_panelone_F1632002_006  
445   /Volumes/Beta/data/flow/panel1_test5_3.pdf      14760     16305  2016-05-18_PANEL1_ZF_panelone_F1632164_009  
446   /Volumes/Beta/data/flow/panel1_test5_3.pdf      45838     47241  2016-05-18_PANEL1_ZF_panelone_F1632193_007  
447   /Volumes/Beta/data/flow/panel1_test5_3.pdf      26623     27959  2016-05-18_PANEL1_ZF_panelone_F1632197_010  
448   /Volumes/Beta/data/flow/panel1_test5_3.pdf      40947     42049  2016-05-18_PANEL1_ZF_panelone_F1632258_004  
449   /Volumes/Beta/data/flow/panel1_test5_3.pdf       3423      3698  2016-05-18_PANEL1_ZF_panelone_F1636464_011  
450   /Volumes/Beta/data/flow/panel1_test5_3.pdf      21010     21557  2016-05-18_PANEL1_ZF_panelone_F1636739_014  
451   /Volumes/Beta/data/flow/panel1_test5_3.pdf      79656     82785  2016-05-18_PANEL1_ZF_panelone_F1636757_013  
452   /Volumes/Beta/data/flow/panel1_test5_3.pdf       7367      7902  2016-05-20_PANEL1_ZF_panelone_F1631992_004  
453   /Volumes/Beta/data/flow/panel1_test5_3.pdf       5051      5479  2016-05-20_PANEL1_ZF_panelone_F1631993_003  
454   /Volumes/Beta/data/flow/panel1_test5_3.pdf      25183     23888  2016-05-20_PANEL1_ZF_panelone_F1631997_009  
455   /Volumes/Beta/data/flow/panel1_test5_3.pdf       5936      7093  2016-05-20_PANEL1_ZF_panelone_F1632006_005  
456   /Volumes/Beta/data/flow/panel1_test5_3.pdf      13219     14603  2016-05-20_PANEL1_ZF_panelone_F1632191_006  
457   /Volumes/Beta/data/flow/panel1_test5_3.pdf       3285      3763  2016-05-20_PANEL1_ZF_panelone_F1632203_001  
458   /Volumes/Beta/data/flow/panel1_test5_4.pdf      48700     53952  2016-05-20_PANEL1_ZF_panelone_F1632206_002  
459   /Volumes/Beta/data/flow/panel1_test5_4.pdf      18881     19274  2016-05-20_PANEL1_ZF_panelone_F1632217_007  
460   /Volumes/Beta/data/flow/panel1_test5_4.pdf       1895      1983  2016-07-06_PANEL1_ZF_Groupone_F1632030_006  
461   /Volumes/Beta/data/flow/panel1_test5_4.pdf      83336     82823  2016-07-06_PANEL1_ZF_Groupone_F1632030B_007 
462   /Volumes/Beta/data/flow/panel1_test5_4.pdf      14204     15270  2016-07-06_PANEL1_ZF_Groupone_F1632038_003  
463   /Volumes/Beta/data/flow/panel1_test5_4.pdf      68168     68418  2016-07-06_PANEL1_ZF_Groupone_F1632044_004  
464   /Volumes/Beta/data/flow/panel1_test5_4.pdf      33161     37134  2016-07-06_PANEL1_ZF_Groupone_F1632057_001  
465   /Volumes/Beta/data/flow/panel1_test5_4.pdf      22030     23291  2016-07-06_PANEL1_ZF_Groupone_F1632091_010  
466   /Volumes/Beta/data/flow/panel1_test5_4.pdf      49687     37802  2016-07-06_PANEL1_ZF_Groupone_F1632098_005  
467   /Volumes/Beta/data/flow/panel1_test5_4.pdf      38307     39061  2016-07-06_PANEL1_ZF_Groupone_F1632112_009  
468   /Volumes/Beta/data/flow/panel1_test5_4.pdf      11288     11247  2016-07-06_PANEL1_ZF_Groupone_F1632325_002  
469   /Volumes/Beta/data/flow/panel1_test5_4.pdf       1367      1404  2016-07-06_PANEL1_ZF_Groupone_F1632350_008  
470   /Volumes/Beta/data/flow/panel1_test5_4.pdf      37035     42472  2016-07-07_PANEL1_ZF_Groupone_F1632103_010  
471   /Volumes/Beta/data/flow/panel1_test5_4.pdf      21836     24534  2016-07-07_PANEL1_ZF_Groupone_F1632117_007  
472   /Volumes/Beta/data/flow/panel1_test5_5.pdf      83823     84680  2016-07-07_PANEL1_ZF_Groupone_F1632340_001  
473   /Volumes/Beta/data/flow/panel1_test5_5.pdf      61604     64985  2016-07-07_PANEL1_ZF_Groupone_F1632346_008  
474   /Volumes/Beta/data/flow/panel1_test5_5.pdf      52135     58821  2016-07-07_PANEL1_ZF_Groupone_F1632351_006  
475   /Volumes/Beta/data/flow/panel1_test5_5.pdf      67470     77102  2016-07-07_PANEL1_ZF_Groupone_F1632353_002  
476   /Volumes/Beta/data/flow/panel1_test5_5.pdf      74371     75414  2016-07-07_PANEL1_ZF_Groupone_F1632359_004  
477   /Volumes/Beta/data/flow/panel1_test5_5.pdf      36501     38064  2016-07-07_PANEL1_ZF_Groupone_F1632381_005  
478   /Volumes/Beta/data/flow/panel1_test5_5.pdf      46757     48028  2016-07-07_PANEL1_ZF_Groupone_F1632396_009  
479   /Volumes/Beta/data/flow/panel1_test5_5.pdf      32283     38248  2016-07-07_PANEL1_ZF_Grouptwo_F1631273_025  
480   /Volumes/Beta/data/flow/panel1_test5_5.pdf      53916     53235  2016-07-07_PANEL1_ZF_Grouptwo_F1631274_024  
481   /Volumes/Beta/data/flow/panel1_test5_5.pdf      31663     35801  2016-07-07_PANEL1_ZF_Grouptwo_F1632076_032  
482   /Volumes/Beta/data/flow/panel1_test5_5.pdf      13343     17869  2016-07-07_PANEL1_ZF_Grouptwo_F1632102_026  
483   /Volumes/Beta/data/flow/panel1_test5_5.pdf      49546     51662  2016-07-07_PANEL1_ZF_Grouptwo_F1632105_027  
484   /Volumes/Beta/data/flow/panel1_test5_5.pdf      37030     44333  2016-07-07_PANEL1_ZF_Grouptwo_F1632134_029  
485   /Volumes/Beta/data/flow/panel1_test5_5.pdf       2207       434  2016-07-07_PANEL1_ZF_Grouptwo_F1632161_033  
486   /Volumes/Beta/data/flow/panel1_test5_5.pdf      97630    103835  2016-07-07_PANEL1_ZF_Grouptwo_F1632343_030  
487   /Volumes/Beta/data/flow/panel1_test5_6.pdf      23133     30274  2016-07-07_PANEL1_ZF_Grouptwo_F1632358_028  
488   /Volumes/Beta/data/flow/panel1_test5_6.pdf      54689     54635  2016-07-07_PANEL1_ZF_Grouptwo_F1632383_031  
489   /Volumes/Beta/data/flow/panel1_test5_6.pdf      19139     19766  2016-07-08_PANEL1_ZF_Groupone_F1631265_006  
490   /Volumes/Beta/data/flow/panel1_test5_6.pdf      10351     11307  2016-07-08_PANEL1_ZF_Groupone_F1631269_003  
491   /Volumes/Beta/data/flow/panel1_test5_6.pdf       6974      7068  2016-07-08_PANEL1_ZF_Groupone_F1631270_010  
492   /Volumes/Beta/data/flow/panel1_test5_6.pdf      17377     19082  2016-07-08_PANEL1_ZF_Groupone_F1632153_004  
493   /Volumes/Beta/data/flow/panel1_test5_6.pdf      11916     11056  2016-07-08_PANEL1_ZF_Groupone_F1632338_008  
494   /Volumes/Beta/data/flow/panel1_test5_6.pdf       2471      2832  2016-07-08_PANEL1_ZF_Groupone_F1632339_009  
495   /Volumes/Beta/data/flow/panel1_test5_6.pdf       4175      4373  2016-07-08_PANEL1_ZF_Groupone_F1632342_002  
496   /Volumes/Beta/data/flow/panel1_test5_6.pdf        419       720  2016-07-08_PANEL1_ZF_Groupone_F1632345_001  
497   /Volumes/Beta/data/flow/panel1_test5_6.pdf      10034     10170  2016-07-08_PANEL1_ZF_Groupone_F1632380_005  
498   /Volumes/Beta/data/flow/panel1_test5_6.pdf      26035     28988  2016-07-08_PANEL1_ZF_Groupone_F1632399_007  
499   /Volumes/Beta/data/flow/panel1_test5_6.pdf      64652     67270  2016-07-08_PANEL1_ZF_Grouptwo_F1631285_030  
500   /Volumes/Beta/data/flow/panel1_test5_6.pdf        573      1376  2016-07-08_PANEL1_ZF_Grouptwo_F1632054_032  
501   /Volumes/Beta/data/flow/panel1_test5_6.pdf      17669     23303  2016-07-08_PANEL1_ZF_Grouptwo_F1632131_025  
502   /Volumes/Beta/data/flow/panel1_test5_7.pdf       4598      5030  2016-07-08_PANEL1_ZF_Grouptwo_F1632278_033  
503   /Volumes/Beta/data/flow/panel1_test5_7.pdf      22170     25271  2016-07-08_PANEL1_ZF_Grouptwo_F1632284_029  
504   /Volumes/Beta/data/flow/panel1_test5_7.pdf      43563     43563  2016-07-08_PANEL1_ZF_Grouptwo_F1632363_026  
505   /Volumes/Beta/data/flow/panel1_test5_7.pdf      63126     66753  2016-07-08_PANEL1_ZF_Grouptwo_F1632372_024  
506   /Volumes/Beta/data/flow/panel1_test5_7.pdf      17572     21575  2016-07-08_PANEL1_ZF_Grouptwo_F1632379_031  
507   /Volumes/Beta/data/flow/panel1_test5_7.pdf      41147     44159  2016-07-08_PANEL1_ZF_Grouptwo_F1632385_027  
508   /Volumes/Beta/data/flow/panel1_test5_7.pdf      54227     56652  2016-07-08_PANEL1_ZF_Grouptwo_F1649319_028  
509   /Volumes/Beta/data/flow/panel1_test5_7.pdf      66813     66857  2016-07-27_PANEL1_ZF_Groupone_F1631224_003  
510   /Volumes/Beta/data/flow/panel1_test5_7.pdf       4322      4261  2016-07-27_PANEL1_ZF_Groupone_F1631305_002  
511   /Volumes/Beta/data/flow/panel1_test5_7.pdf      21046     21365  2016-07-27_PANEL1_ZF_Groupone_F1631369_009  
512   /Volumes/Beta/data/flow/panel1_test5_7.pdf      48230     51175  2016-07-27_PANEL1_ZF_Groupone_F1632277_010  
513   /Volumes/Beta/data/flow/panel1_test5_7.pdf      43946     44755  2016-07-27_PANEL1_ZF_Groupone_F1632369_008  
514   /Volumes/Beta/data/flow/panel1_test5_7.pdf      54149     55699  2016-07-27_PANEL1_ZF_Groupone_F1632384_007  
515   /Volumes/Beta/data/flow/panel1_test5_7.pdf      14983     19221  2016-07-27_PANEL1_ZF_Groupone_F1632400_006  

