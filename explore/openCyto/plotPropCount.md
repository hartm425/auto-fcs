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

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-3.png)<!-- -->![](plotPropCount_files/figure-html/setup-4.png)<!-- -->![](plotPropCount_files/figure-html/setup-5.png)<!-- -->![](plotPropCount_files/figure-html/setup-6.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-7.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-8.png)<!-- -->![](plotPropCount_files/figure-html/setup-9.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-10.png)<!-- -->

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
## S = 25755000, p-value < 2.2e-16
## alternative hypothesis: true rho is not equal to 0
## sample estimates:
##       rho 
## 0.9867013
```

```r
look = metricCombo[which(metricCombo$Population.x=="CCR7+CD45RA+"),]
kable(look[,c("PDF.x","Count.x","Count.y","name.x")])
```

      PDF.x                                          Count.x   Count.y  name.x                                      
----  --------------------------------------------  --------  --------  --------------------------------------------
605   /Volumes/Beta/data/flow/panel1_test5_1.pdf       28165      1492  2016-05-05_PANEL1_HB_panelone_F1631931_006  
606   /Volumes/Beta/data/flow/panel1_test5_1.pdf       19158     18497  2016-05-05_PANEL1_HB_panelone_F1631958_002  
607   /Volumes/Beta/data/flow/panel1_test5_1.pdf       21518     20889  2016-05-05_PANEL1_HB_panelone_F1631959_005  
608   /Volumes/Beta/data/flow/panel1_test5_1.pdf       22740     23056  2016-05-05_PANEL1_HB_panelone_F1631960_004  
609   /Volumes/Beta/data/flow/panel1_test5_1.pdf       24371     30594  2016-05-05_PANEL1_HB_panelone_F1631961_003  
610   /Volumes/Beta/data/flow/panel1_test5_1.pdf       43807     46389  2016-05-06_PANEL1_ZF_panelone_F1631944_005  
611   /Volumes/Beta/data/flow/panel1_test5_1.pdf       30566     32167  2016-05-06_PANEL1_ZF_panelone_F1631950_006  
612   /Volumes/Beta/data/flow/panel1_test5_1.pdf       48311     49913  2016-05-06_PANEL1_ZF_panelone_F1631954_003  
613   /Volumes/Beta/data/flow/panel1_test5_1.pdf       32595     37961  2016-05-06_PANEL1_ZF_panelone_F1631956_004  
614   /Volumes/Beta/data/flow/panel1_test5_1.pdf       13725     17361  2016-05-06_PANEL1_ZF_panelone_F1631957_002  
615   /Volumes/Beta/data/flow/panel1_test5_1.pdf       14101     15699  2016-05-11_PANEL1_ZF_panelone_F1631919_009  
616   /Volumes/Beta/data/flow/panel1_test5_1.pdf       33731     37945  2016-05-11_PANEL1_ZF_panelone_F1631920_007  
617   /Volumes/Beta/data/flow/panel1_test5_1.pdf       15095     15930  2016-05-11_PANEL1_ZF_panelone_F1631925_005  
618   /Volumes/Beta/data/flow/panel1_test5_1.pdf       27436     27662  2016-05-11_PANEL1_ZF_panelone_F1631942_008  
619   /Volumes/Beta/data/flow/panel1_test5_1.pdf       20214     21871  2016-05-11_PANEL1_ZF_panelone_F1632171_002  
620   /Volumes/Beta/data/flow/panel1_test5_2.pdf        1594      7489  2016-05-11_PANEL1_ZF_panelone_F1632176_004  
621   /Volumes/Beta/data/flow/panel1_test5_2.pdf      169786    164776  2016-05-11_PANEL1_ZF_panelone_F1632184_001  
622   /Volumes/Beta/data/flow/panel1_test5_2.pdf       39167     37047  2016-05-11_PANEL1_ZF_panelone_F1632214_010  
623   /Volumes/Beta/data/flow/panel1_test5_2.pdf       18746     21265  2016-05-11_PANEL1_ZF_panelone_F1632227_006  
624   /Volumes/Beta/data/flow/panel1_test5_2.pdf          12     25849  2016-05-11_PANEL1_ZF_panelone_F1632229_003  
625   /Volumes/Beta/data/flow/panel1_test5_2.pdf       35914     34301  2016-05-13_PANEL1_ZF_panelone_F1631922_003  
626   /Volumes/Beta/data/flow/panel1_test5_2.pdf       44403     44901  2016-05-13_PANEL1_ZF_panelone_F1631924_001  
627   /Volumes/Beta/data/flow/panel1_test5_2.pdf       60022     61750  2016-05-13_PANEL1_ZF_panelone_F1632182_002  
628   /Volumes/Beta/data/flow/panel1_test5_2.pdf        2330      3086  2016-05-13_PANEL1_ZF_panelone_F1632233_004  
629   /Volumes/Beta/data/flow/panel1_test5_2.pdf       39235     41724  2016-05-13_PANEL1_ZF_panelone_F1632235_005  
630   /Volumes/Beta/data/flow/panel1_test5_2.pdf           8      8904  2016-05-18_PANEL1_ZF_panelone_F1631974_008  
631   /Volumes/Beta/data/flow/panel1_test5_2.pdf       54753     57989  2016-05-18_PANEL1_ZF_panelone_F1631977_003  
632   /Volumes/Beta/data/flow/panel1_test5_2.pdf        8379      8805  2016-05-18_PANEL1_ZF_panelone_F1631988_002  
633   /Volumes/Beta/data/flow/panel1_test5_2.pdf       12588     13551  2016-05-18_PANEL1_ZF_panelone_F1631990_005  
634   /Volumes/Beta/data/flow/panel1_test5_2.pdf        4614      6187  2016-05-18_PANEL1_ZF_panelone_F1631991_012  
635   /Volumes/Beta/data/flow/panel1_test5_3.pdf       39268     39990  2016-05-18_PANEL1_ZF_panelone_F1631995_001  
636   /Volumes/Beta/data/flow/panel1_test5_3.pdf       27257     27715  2016-05-18_PANEL1_ZF_panelone_F1632002_006  
637   /Volumes/Beta/data/flow/panel1_test5_3.pdf       15387     16305  2016-05-18_PANEL1_ZF_panelone_F1632164_009  
638   /Volumes/Beta/data/flow/panel1_test5_3.pdf       46821     47241  2016-05-18_PANEL1_ZF_panelone_F1632193_007  
639   /Volumes/Beta/data/flow/panel1_test5_3.pdf       26881     27959  2016-05-18_PANEL1_ZF_panelone_F1632197_010  
640   /Volumes/Beta/data/flow/panel1_test5_3.pdf       41710     42049  2016-05-18_PANEL1_ZF_panelone_F1632258_004  
641   /Volumes/Beta/data/flow/panel1_test5_3.pdf        3555      3698  2016-05-18_PANEL1_ZF_panelone_F1636464_011  
642   /Volumes/Beta/data/flow/panel1_test5_3.pdf       21267     21557  2016-05-18_PANEL1_ZF_panelone_F1636739_014  
643   /Volumes/Beta/data/flow/panel1_test5_3.pdf       81985     82785  2016-05-18_PANEL1_ZF_panelone_F1636757_013  
644   /Volumes/Beta/data/flow/panel1_test5_3.pdf        7556      7902  2016-05-20_PANEL1_ZF_panelone_F1631992_004  
645   /Volumes/Beta/data/flow/panel1_test5_3.pdf        5158      5479  2016-05-20_PANEL1_ZF_panelone_F1631993_003  
646   /Volumes/Beta/data/flow/panel1_test5_3.pdf       26051     23888  2016-05-20_PANEL1_ZF_panelone_F1631997_009  
647   /Volumes/Beta/data/flow/panel1_test5_3.pdf        6029      7093  2016-05-20_PANEL1_ZF_panelone_F1632006_005  
648   /Volumes/Beta/data/flow/panel1_test5_3.pdf       13564     14603  2016-05-20_PANEL1_ZF_panelone_F1632191_006  
649   /Volumes/Beta/data/flow/panel1_test5_3.pdf        3338      3763  2016-05-20_PANEL1_ZF_panelone_F1632203_001  
650   /Volumes/Beta/data/flow/panel1_test5_4.pdf       49774     53952  2016-05-20_PANEL1_ZF_panelone_F1632206_002  
651   /Volumes/Beta/data/flow/panel1_test5_4.pdf       19080     19274  2016-05-20_PANEL1_ZF_panelone_F1632217_007  
652   /Volumes/Beta/data/flow/panel1_test5_4.pdf        1910      1983  2016-07-06_PANEL1_ZF_Groupone_F1632030_006  
653   /Volumes/Beta/data/flow/panel1_test5_4.pdf       84462     82823  2016-07-06_PANEL1_ZF_Groupone_F1632030B_007 
654   /Volumes/Beta/data/flow/panel1_test5_4.pdf       14358     15270  2016-07-06_PANEL1_ZF_Groupone_F1632038_003  
655   /Volumes/Beta/data/flow/panel1_test5_4.pdf       70424     68418  2016-07-06_PANEL1_ZF_Groupone_F1632044_004  
656   /Volumes/Beta/data/flow/panel1_test5_4.pdf       34031     37134  2016-07-06_PANEL1_ZF_Groupone_F1632057_001  
657   /Volumes/Beta/data/flow/panel1_test5_4.pdf       22748     23291  2016-07-06_PANEL1_ZF_Groupone_F1632091_010  
658   /Volumes/Beta/data/flow/panel1_test5_4.pdf       19483     37802  2016-07-06_PANEL1_ZF_Groupone_F1632098_005  
659   /Volumes/Beta/data/flow/panel1_test5_4.pdf       39022     39061  2016-07-06_PANEL1_ZF_Groupone_F1632112_009  
660   /Volumes/Beta/data/flow/panel1_test5_4.pdf       11383     11247  2016-07-06_PANEL1_ZF_Groupone_F1632325_002  
661   /Volumes/Beta/data/flow/panel1_test5_4.pdf        1395      1404  2016-07-06_PANEL1_ZF_Groupone_F1632350_008  
662   /Volumes/Beta/data/flow/panel1_test5_4.pdf       37492     42472  2016-07-07_PANEL1_ZF_Groupone_F1632103_010  
663   /Volumes/Beta/data/flow/panel1_test5_4.pdf       22379     24534  2016-07-07_PANEL1_ZF_Groupone_F1632117_007  
664   /Volumes/Beta/data/flow/panel1_test5_5.pdf       85616     84680  2016-07-07_PANEL1_ZF_Groupone_F1632340_001  
665   /Volumes/Beta/data/flow/panel1_test5_5.pdf       62754     64985  2016-07-07_PANEL1_ZF_Groupone_F1632346_008  
666   /Volumes/Beta/data/flow/panel1_test5_5.pdf       54132     58821  2016-07-07_PANEL1_ZF_Groupone_F1632351_006  
667   /Volumes/Beta/data/flow/panel1_test5_5.pdf       69302     77102  2016-07-07_PANEL1_ZF_Groupone_F1632353_002  
668   /Volumes/Beta/data/flow/panel1_test5_5.pdf       76099     75414  2016-07-07_PANEL1_ZF_Groupone_F1632359_004  
669   /Volumes/Beta/data/flow/panel1_test5_5.pdf       38021     38064  2016-07-07_PANEL1_ZF_Groupone_F1632381_005  
670   /Volumes/Beta/data/flow/panel1_test5_5.pdf       47446     48028  2016-07-07_PANEL1_ZF_Groupone_F1632396_009  
671   /Volumes/Beta/data/flow/panel1_test5_5.pdf       33222     38248  2016-07-07_PANEL1_ZF_Grouptwo_F1631273_025  
672   /Volumes/Beta/data/flow/panel1_test5_5.pdf       54852     53235  2016-07-07_PANEL1_ZF_Grouptwo_F1631274_024  
673   /Volumes/Beta/data/flow/panel1_test5_5.pdf       32145     35801  2016-07-07_PANEL1_ZF_Grouptwo_F1632076_032  
674   /Volumes/Beta/data/flow/panel1_test5_5.pdf       13706     17869  2016-07-07_PANEL1_ZF_Grouptwo_F1632102_026  
675   /Volumes/Beta/data/flow/panel1_test5_5.pdf       50561     51662  2016-07-07_PANEL1_ZF_Grouptwo_F1632105_027  
676   /Volumes/Beta/data/flow/panel1_test5_5.pdf       37756     44333  2016-07-07_PANEL1_ZF_Grouptwo_F1632134_029  
677   /Volumes/Beta/data/flow/panel1_test5_5.pdf      100448    103835  2016-07-07_PANEL1_ZF_Grouptwo_F1632343_030  
678   /Volumes/Beta/data/flow/panel1_test5_6.pdf       23460     30274  2016-07-07_PANEL1_ZF_Grouptwo_F1632358_028  
679   /Volumes/Beta/data/flow/panel1_test5_6.pdf       55609     54635  2016-07-07_PANEL1_ZF_Grouptwo_F1632383_031  
680   /Volumes/Beta/data/flow/panel1_test5_6.pdf       19523     19766  2016-07-08_PANEL1_ZF_Groupone_F1631265_006  
681   /Volumes/Beta/data/flow/panel1_test5_6.pdf       10593     11307  2016-07-08_PANEL1_ZF_Groupone_F1631269_003  
682   /Volumes/Beta/data/flow/panel1_test5_6.pdf        7093      7068  2016-07-08_PANEL1_ZF_Groupone_F1631270_010  
683   /Volumes/Beta/data/flow/panel1_test5_6.pdf       17510     19082  2016-07-08_PANEL1_ZF_Groupone_F1632153_004  
684   /Volumes/Beta/data/flow/panel1_test5_6.pdf       12196     11056  2016-07-08_PANEL1_ZF_Groupone_F1632338_008  
685   /Volumes/Beta/data/flow/panel1_test5_6.pdf        2396      2832  2016-07-08_PANEL1_ZF_Groupone_F1632339_009  
686   /Volumes/Beta/data/flow/panel1_test5_6.pdf        4302      4373  2016-07-08_PANEL1_ZF_Groupone_F1632342_002  
687   /Volumes/Beta/data/flow/panel1_test5_6.pdf         441       720  2016-07-08_PANEL1_ZF_Groupone_F1632345_001  
688   /Volumes/Beta/data/flow/panel1_test5_6.pdf       10256     10170  2016-07-08_PANEL1_ZF_Groupone_F1632380_005  
689   /Volumes/Beta/data/flow/panel1_test5_6.pdf       26989     28988  2016-07-08_PANEL1_ZF_Groupone_F1632399_007  
690   /Volumes/Beta/data/flow/panel1_test5_6.pdf       67460     67270  2016-07-08_PANEL1_ZF_Grouptwo_F1631285_030  
691   /Volumes/Beta/data/flow/panel1_test5_6.pdf         578      1376  2016-07-08_PANEL1_ZF_Grouptwo_F1632054_032  
692   /Volumes/Beta/data/flow/panel1_test5_6.pdf       18488     23303  2016-07-08_PANEL1_ZF_Grouptwo_F1632131_025  
693   /Volumes/Beta/data/flow/panel1_test5_7.pdf        4646      5030  2016-07-08_PANEL1_ZF_Grouptwo_F1632278_033  
694   /Volumes/Beta/data/flow/panel1_test5_7.pdf       22707     25271  2016-07-08_PANEL1_ZF_Grouptwo_F1632284_029  
695   /Volumes/Beta/data/flow/panel1_test5_7.pdf       44782     43563  2016-07-08_PANEL1_ZF_Grouptwo_F1632363_026  
696   /Volumes/Beta/data/flow/panel1_test5_7.pdf       65665     66753  2016-07-08_PANEL1_ZF_Grouptwo_F1632372_024  
697   /Volumes/Beta/data/flow/panel1_test5_7.pdf       17936     21575  2016-07-08_PANEL1_ZF_Grouptwo_F1632379_031  
698   /Volumes/Beta/data/flow/panel1_test5_7.pdf       42631     44159  2016-07-08_PANEL1_ZF_Grouptwo_F1632385_027  
699   /Volumes/Beta/data/flow/panel1_test5_7.pdf       56639     56652  2016-07-08_PANEL1_ZF_Grouptwo_F1649319_028  
700   /Volumes/Beta/data/flow/panel1_test5_7.pdf       68781     66857  2016-07-27_PANEL1_ZF_Groupone_F1631224_003  
701   /Volumes/Beta/data/flow/panel1_test5_7.pdf        4351      4261  2016-07-27_PANEL1_ZF_Groupone_F1631305_002  
702   /Volumes/Beta/data/flow/panel1_test5_7.pdf       21502     21365  2016-07-27_PANEL1_ZF_Groupone_F1631369_009  
703   /Volumes/Beta/data/flow/panel1_test5_7.pdf       49435     51175  2016-07-27_PANEL1_ZF_Groupone_F1632277_010  
704   /Volumes/Beta/data/flow/panel1_test5_7.pdf       45274     44755  2016-07-27_PANEL1_ZF_Groupone_F1632369_008  
705   /Volumes/Beta/data/flow/panel1_test5_7.pdf       55871     55699  2016-07-27_PANEL1_ZF_Groupone_F1632384_007  
706   /Volumes/Beta/data/flow/panel1_test5_7.pdf       15312     19221  2016-07-27_PANEL1_ZF_Groupone_F1632400_006  
707   /Volumes/Beta/data/flow/panel1_test5_7.pdf       69787     72205  2016-07-27_PANEL1_ZF_Groupone_F1636532_005  
708   /Volumes/Beta/data/flow/panel1_test5_8.pdf       26205     28640  2016-07-27_PANEL1_ZF_Groupone_F1636535_004  
709   /Volumes/Beta/data/flow/panel1_test5_8.pdf       60193     59467  2016-07-27_PANEL1_ZF_Grouptwo_F1631148_028  
710   /Volumes/Beta/data/flow/panel1_test5_8.pdf       34627     32649  2016-07-27_PANEL1_ZF_Grouptwo_F1631199_031  
711   /Volumes/Beta/data/flow/panel1_test5_8.pdf       51837     51459  2016-07-27_PANEL1_ZF_Grouptwo_F1636515_032  
712   /Volumes/Beta/data/flow/panel1_test5_8.pdf       62832     63084  2016-07-27_PANEL1_ZF_Grouptwo_F1636520_029  
713   /Volumes/Beta/data/flow/panel1_test5_8.pdf       31282     40658  2016-07-27_PANEL1_ZF_Grouptwo_F1636521_024  
714   /Volumes/Beta/data/flow/panel1_test5_8.pdf       11376     12682  2016-07-27_PANEL1_ZF_Grouptwo_F1636785_030  
715   /Volumes/Beta/data/flow/panel1_test5_8.pdf        1424      1476  2016-07-27_PANEL1_ZF_Grouptwo_F1636806_025  
716   /Volumes/Beta/data/flow/panel1_test5_8.pdf       10787     11702  2016-07-27_PANEL1_ZF_Grouptwo_F1636821_026  
717   /Volumes/Beta/data/flow/panel1_test5_8.pdf       63339     66639  2016-07-27_PANEL1_ZF_Grouptwo_F1636835_027  
718   /Volumes/Beta/data/flow/panel1_test5_8.pdf        5622      5634  2016-07-29_PANEL1_ZF_Groupone_F1631100_003  
719   /Volumes/Beta/data/flow/panel1_test5_8.pdf       39130     37821  2016-07-29_PANEL1_ZF_Groupone_F1632280_001  
720   /Volumes/Beta/data/flow/panel1_test5_8.pdf       19040     19180  2016-07-29_PANEL1_ZF_Groupone_F1636517_010  
721   /Volumes/Beta/data/flow/panel1_test5_8.pdf       69520     64439  2016-07-29_PANEL1_ZF_Groupone_F1636523_008  
722   /Volumes/Beta/data/flow/panel1_test5_8.pdf        4113      4759  2016-07-29_PANEL1_ZF_Groupone_F1636528_002  
723   /Volumes/Beta/data/flow/panel1_test5_9.pdf        2272      2321  2016-07-29_PANEL1_ZF_Groupone_F1636542_006  
724   /Volumes/Beta/data/flow/panel1_test5_9.pdf         873      1111  2016-07-29_PANEL1_ZF_Groupone_F1636783_009  
725   /Volumes/Beta/data/flow/panel1_test5_9.pdf       27502     23919  2016-07-29_PANEL1_ZF_Groupone_F1636802_005  
726   /Volumes/Beta/data/flow/panel1_test5_9.pdf       29574     26455  2016-07-29_PANEL1_ZF_Groupone_F1636814_004  
727   /Volumes/Beta/data/flow/panel1_test5_9.pdf       74316     72867  2016-07-29_PANEL1_ZF_Groupone_F1636837_007  
728   /Volumes/Beta/data/flow/panel1_test5_9.pdf       12215     10138  2016-07-29_PANEL1_ZF_Grouptwo_F1631111_029  
729   /Volumes/Beta/data/flow/panel1_test5_9.pdf        9551      9883  2016-07-29_PANEL1_ZF_Grouptwo_F1631330_031  
730   /Volumes/Beta/data/flow/panel1_test5_9.pdf       15534     20942  2016-07-29_PANEL1_ZF_Grouptwo_F1636525_024  
731   /Volumes/Beta/data/flow/panel1_test5_9.pdf       28089     26163  2016-07-29_PANEL1_ZF_Grouptwo_F1636784_033  
732   /Volumes/Beta/data/flow/panel1_test5_9.pdf      105945     96375  2016-07-29_PANEL1_ZF_Grouptwo_F1636796_027  
733   /Volumes/Beta/data/flow/panel1_test5_9.pdf       22551     21942  2016-07-29_PANEL1_ZF_Grouptwo_F1636823_026  
734   /Volumes/Beta/data/flow/panel1_test5_9.pdf       37521     41986  2016-07-29_PANEL1_ZF_Grouptwo_F1636833_030  
735   /Volumes/Beta/data/flow/panel1_test5_9.pdf       17476     17337  2016-07-29_PANEL1_ZF_Grouptwo_F1636856_032  
736   /Volumes/Beta/data/flow/panel1_test5_9.pdf        8480      8465  2016-07-29_PANEL1_ZF_Grouptwo_F1636859_028  
737   /Volumes/Beta/data/flow/panel1_test5_9.pdf       36958     37759  2016-08-01_PANEL1_DHS_Groupone_F1630927_008 
738   /Volumes/Beta/data/flow/panel1_test5_10.pdf      33512     32904  2016-08-01_PANEL1_DHS_Groupone_F1631107_010 
739   /Volumes/Beta/data/flow/panel1_test5_10.pdf       3009      5028  2016-08-01_PANEL1_DHS_Groupone_F1631332_012 
740   /Volumes/Beta/data/flow/panel1_test5_10.pdf       7002      7205  2016-08-01_PANEL1_DHS_Groupone_F1631366_002 
741   /Volumes/Beta/data/flow/panel1_test5_10.pdf      50554     52142  2016-08-01_PANEL1_DHS_Groupone_F1631377_003 
742   /Volumes/Beta/data/flow/panel1_test5_10.pdf          2       471  2016-08-01_PANEL1_DHS_Groupone_F1636533_004 
743   /Volumes/Beta/data/flow/panel1_test5_10.pdf      57960     57144  2016-08-01_PANEL1_DHS_Groupone_F1636775_013 
744   /Volumes/Beta/data/flow/panel1_test5_10.pdf      45661     46538  2016-08-01_PANEL1_DHS_Groupone_F1636790_006 
745   /Volumes/Beta/data/flow/panel1_test5_10.pdf      49050     49932  2016-08-01_PANEL1_DHS_Groupone_F1636818_005 
746   /Volumes/Beta/data/flow/panel1_test5_10.pdf       2098      2162  2016-08-01_PANEL1_DHS_Groupone_F1636819_011 
747   /Volumes/Beta/data/flow/panel1_test5_10.pdf      38799     39894  2016-08-01_PANEL1_DHS_Groupone_F1636826_007 
748   /Volumes/Beta/data/flow/panel1_test5_10.pdf       4295      4724  2016-08-01_PANEL1_DHS_Groupone_F1636847_014 
749   /Volumes/Beta/data/flow/panel1_test5_10.pdf      25796     26266  2016-08-01_PANEL1_DHS_Groupone_F1636850_009 
750   /Volumes/Beta/data/flow/panel1_test5_10.pdf       5604      5905  2016-08-01_PANEL1_DHS_Groupone_F1636851_001 
751   /Volumes/Beta/data/flow/panel1_test5_10.pdf       6986      9650  2016-08-01_PANEL1_DHS_Grouptwo_F1631147_029 
752   /Volumes/Beta/data/flow/panel1_test5_10.pdf      18832     20892  2016-08-01_PANEL1_DHS_Grouptwo_F1631374_028 
753   /Volumes/Beta/data/flow/panel1_test5_11.pdf      22507     23120  2016-08-01_PANEL1_DHS_Grouptwo_F1631383_031 
754   /Volumes/Beta/data/flow/panel1_test5_11.pdf      62385     62003  2016-08-01_PANEL1_DHS_Grouptwo_F1636774_030 
755   /Volumes/Beta/data/flow/panel1_test5_11.pdf      22439     23662  2016-08-01_PANEL1_DHS_Grouptwo_F1636830_032 

