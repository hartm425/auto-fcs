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
metricsAuto = metrics[which(metrics$GATE=="AUTOMATIC"&metrics$QC=="TRUE"&(metrics$Population %in% map$Auto|metrics$Parent=="root")&metrics$METRIC=="count"),]

metricsMan = merge(metricsMan,map,by.x = "Population",by.y = "Manual")
metricsMan$Population =metricsMan$Auto
metricsMan$Merge=paste(metricsMan$Population,metricsMan$name,sep = "_")
metricsAuto = merge(metricsAuto,map,by.x = "Population",by.y = "Auto",all.x = TRUE)
metricsAuto$Merge=paste(metricsAuto$Population,metricsAuto$name,sep = "_")

row.names(metricsAuto) =metricsAuto$Merge

for(pop in unique(map$Auto)) {
  for (sample in unique(metricsAuto$name)) {
    row = paste(pop, sample, sep = "_")
    sub = metricsAuto[which(metricsAuto$Population == pop &
                              metricsAuto$name == sample),]
    realParentCount = metricsAuto[which(metricsAuto$Population == sub$RealAutoParent &
                                          metricsAuto$name == sample),]$Count
    if (sub$RealAutoParent != "root") {
      metricsAuto[row, "freqParent"] = sub$Count / realParentCount
    }else{
      realParentCount = metricsAuto[which(metricsAuto$Parent == sub$RealAutoParent &
                                          metricsAuto$name == sample),]$ParentCount
      metricsAuto[row, "freqParent"] = sub$Count / realParentCount

    }
  }
}

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
   p = ggplot(sub, aes(x =
  freqParent.x, y = freqParent.y, color = FlaggedSample.x)) + geom_point() + xlab("Autogating population count") +
  ylab("Manual gating population count") + geom_abline(intercept = 0, slope = 1)+ labs(title = paste(pop,"n=",length(sub$Count.x),"- pearson r =",signif(t$estimate,4),"- spearman r =",signif(ts$estimate,4)))
  print(p)
}
```

![](plotPropCount_files/figure-html/setup-3.png)<!-- -->![](plotPropCount_files/figure-html/setup-4.png)<!-- -->![](plotPropCount_files/figure-html/setup-5.png)<!-- -->![](plotPropCount_files/figure-html/setup-6.png)<!-- -->![](plotPropCount_files/figure-html/setup-7.png)<!-- -->![](plotPropCount_files/figure-html/setup-8.png)<!-- -->![](plotPropCount_files/figure-html/setup-9.png)<!-- -->![](plotPropCount_files/figure-html/setup-10.png)<!-- -->![](plotPropCount_files/figure-html/setup-11.png)<!-- -->![](plotPropCount_files/figure-html/setup-12.png)<!-- -->![](plotPropCount_files/figure-html/setup-13.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-14.png)<!-- -->![](plotPropCount_files/figure-html/setup-15.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-16.png)<!-- -->![](plotPropCount_files/figure-html/setup-17.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-18.png)<!-- -->![](plotPropCount_files/figure-html/setup-19.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-20.png)<!-- -->![](plotPropCount_files/figure-html/setup-21.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-22.png)<!-- -->![](plotPropCount_files/figure-html/setup-23.png)<!-- -->![](plotPropCount_files/figure-html/setup-24.png)<!-- -->![](plotPropCount_files/figure-html/setup-25.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-26.png)<!-- -->![](plotPropCount_files/figure-html/setup-27.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-28.png)<!-- -->![](plotPropCount_files/figure-html/setup-29.png)<!-- -->![](plotPropCount_files/figure-html/setup-30.png)<!-- -->![](plotPropCount_files/figure-html/setup-31.png)<!-- -->![](plotPropCount_files/figure-html/setup-32.png)<!-- -->

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
## S = 21491000, p-value < 2.2e-16
## alternative hypothesis: true rho is not equal to 0
## sample estimates:
##       rho 
## 0.9886799
```

```r
look = metricCombo[which(metricCombo$Population.x=="CCR7+CD45RA+"),]
kable(look[,c("PDF.x","Count.x","Count.y","name.x")])
```

      PDF.x                                          Count.x   Count.y  name.x                                      
----  --------------------------------------------  --------  --------  --------------------------------------------
601   /Volumes/Beta/data/flow/panel1_test5_1.pdf       19154     18497  2016-05-05_PANEL1_HB_panelone_F1631958_002  
602   /Volumes/Beta/data/flow/panel1_test5_1.pdf       21459     20889  2016-05-05_PANEL1_HB_panelone_F1631959_005  
603   /Volumes/Beta/data/flow/panel1_test5_1.pdf       22731     23056  2016-05-05_PANEL1_HB_panelone_F1631960_004  
604   /Volumes/Beta/data/flow/panel1_test5_1.pdf       24251     30594  2016-05-05_PANEL1_HB_panelone_F1631961_003  
605   /Volumes/Beta/data/flow/panel1_test5_1.pdf       43724     46389  2016-05-06_PANEL1_ZF_panelone_F1631944_005  
606   /Volumes/Beta/data/flow/panel1_test5_1.pdf       30497     32167  2016-05-06_PANEL1_ZF_panelone_F1631950_006  
607   /Volumes/Beta/data/flow/panel1_test5_1.pdf       48286     49913  2016-05-06_PANEL1_ZF_panelone_F1631954_003  
608   /Volumes/Beta/data/flow/panel1_test5_1.pdf       32454     37961  2016-05-06_PANEL1_ZF_panelone_F1631956_004  
609   /Volumes/Beta/data/flow/panel1_test5_1.pdf       13755     17361  2016-05-06_PANEL1_ZF_panelone_F1631957_002  
610   /Volumes/Beta/data/flow/panel1_test5_1.pdf       14089     15699  2016-05-11_PANEL1_ZF_panelone_F1631919_009  
611   /Volumes/Beta/data/flow/panel1_test5_1.pdf       33722     37945  2016-05-11_PANEL1_ZF_panelone_F1631920_007  
612   /Volumes/Beta/data/flow/panel1_test5_1.pdf       15060     15930  2016-05-11_PANEL1_ZF_panelone_F1631925_005  
613   /Volumes/Beta/data/flow/panel1_test5_1.pdf       27381     27662  2016-05-11_PANEL1_ZF_panelone_F1631942_008  
614   /Volumes/Beta/data/flow/panel1_test5_1.pdf       20222     21871  2016-05-11_PANEL1_ZF_panelone_F1632171_002  
615   /Volumes/Beta/data/flow/panel1_test5_2.pdf        1610      7489  2016-05-11_PANEL1_ZF_panelone_F1632176_004  
616   /Volumes/Beta/data/flow/panel1_test5_2.pdf      169831    164776  2016-05-11_PANEL1_ZF_panelone_F1632184_001  
617   /Volumes/Beta/data/flow/panel1_test5_2.pdf       39176     37047  2016-05-11_PANEL1_ZF_panelone_F1632214_010  
618   /Volumes/Beta/data/flow/panel1_test5_2.pdf       18690     21265  2016-05-11_PANEL1_ZF_panelone_F1632227_006  
619   /Volumes/Beta/data/flow/panel1_test5_2.pdf           9     25849  2016-05-11_PANEL1_ZF_panelone_F1632229_003  
620   /Volumes/Beta/data/flow/panel1_test5_2.pdf       35858     34301  2016-05-13_PANEL1_ZF_panelone_F1631922_003  
621   /Volumes/Beta/data/flow/panel1_test5_2.pdf       44389     44901  2016-05-13_PANEL1_ZF_panelone_F1631924_001  
622   /Volumes/Beta/data/flow/panel1_test5_2.pdf       60028     61750  2016-05-13_PANEL1_ZF_panelone_F1632182_002  
623   /Volumes/Beta/data/flow/panel1_test5_2.pdf        2318      3086  2016-05-13_PANEL1_ZF_panelone_F1632233_004  
624   /Volumes/Beta/data/flow/panel1_test5_2.pdf       39180     41724  2016-05-13_PANEL1_ZF_panelone_F1632235_005  
625   /Volumes/Beta/data/flow/panel1_test5_2.pdf           7      8904  2016-05-18_PANEL1_ZF_panelone_F1631974_008  
626   /Volumes/Beta/data/flow/panel1_test5_2.pdf       54756     57989  2016-05-18_PANEL1_ZF_panelone_F1631977_003  
627   /Volumes/Beta/data/flow/panel1_test5_2.pdf        8368      8805  2016-05-18_PANEL1_ZF_panelone_F1631988_002  
628   /Volumes/Beta/data/flow/panel1_test5_2.pdf       12602     13551  2016-05-18_PANEL1_ZF_panelone_F1631990_005  
629   /Volumes/Beta/data/flow/panel1_test5_2.pdf        4594      6187  2016-05-18_PANEL1_ZF_panelone_F1631991_012  
630   /Volumes/Beta/data/flow/panel1_test5_3.pdf       39298     39990  2016-05-18_PANEL1_ZF_panelone_F1631995_001  
631   /Volumes/Beta/data/flow/panel1_test5_3.pdf       27236     27715  2016-05-18_PANEL1_ZF_panelone_F1632002_006  
632   /Volumes/Beta/data/flow/panel1_test5_3.pdf       15390     16305  2016-05-18_PANEL1_ZF_panelone_F1632164_009  
633   /Volumes/Beta/data/flow/panel1_test5_3.pdf       46751     47241  2016-05-18_PANEL1_ZF_panelone_F1632193_007  
634   /Volumes/Beta/data/flow/panel1_test5_3.pdf       26868     27959  2016-05-18_PANEL1_ZF_panelone_F1632197_010  
635   /Volumes/Beta/data/flow/panel1_test5_3.pdf       41702     42049  2016-05-18_PANEL1_ZF_panelone_F1632258_004  
636   /Volumes/Beta/data/flow/panel1_test5_3.pdf        3554      3698  2016-05-18_PANEL1_ZF_panelone_F1636464_011  
637   /Volumes/Beta/data/flow/panel1_test5_3.pdf       21226     21557  2016-05-18_PANEL1_ZF_panelone_F1636739_014  
638   /Volumes/Beta/data/flow/panel1_test5_3.pdf       81921     82785  2016-05-18_PANEL1_ZF_panelone_F1636757_013  
639   /Volumes/Beta/data/flow/panel1_test5_3.pdf        7550      7902  2016-05-20_PANEL1_ZF_panelone_F1631992_004  
640   /Volumes/Beta/data/flow/panel1_test5_3.pdf        5141      5479  2016-05-20_PANEL1_ZF_panelone_F1631993_003  
641   /Volumes/Beta/data/flow/panel1_test5_3.pdf       17214     23888  2016-05-20_PANEL1_ZF_panelone_F1631997_009  
642   /Volumes/Beta/data/flow/panel1_test5_3.pdf        6061      7093  2016-05-20_PANEL1_ZF_panelone_F1632006_005  
643   /Volumes/Beta/data/flow/panel1_test5_3.pdf       13536     14603  2016-05-20_PANEL1_ZF_panelone_F1632191_006  
644   /Volumes/Beta/data/flow/panel1_test5_3.pdf        3321      3763  2016-05-20_PANEL1_ZF_panelone_F1632203_001  
645   /Volumes/Beta/data/flow/panel1_test5_4.pdf       49761     53952  2016-05-20_PANEL1_ZF_panelone_F1632206_002  
646   /Volumes/Beta/data/flow/panel1_test5_4.pdf       19077     19274  2016-05-20_PANEL1_ZF_panelone_F1632217_007  
647   /Volumes/Beta/data/flow/panel1_test5_4.pdf        1910      1983  2016-07-06_PANEL1_ZF_Groupone_F1632030_006  
648   /Volumes/Beta/data/flow/panel1_test5_4.pdf       84545     82823  2016-07-06_PANEL1_ZF_Groupone_F1632030B_007 
649   /Volumes/Beta/data/flow/panel1_test5_4.pdf       14347     15270  2016-07-06_PANEL1_ZF_Groupone_F1632038_003  
650   /Volumes/Beta/data/flow/panel1_test5_4.pdf       70450     68418  2016-07-06_PANEL1_ZF_Groupone_F1632044_004  
651   /Volumes/Beta/data/flow/panel1_test5_4.pdf       34020     37134  2016-07-06_PANEL1_ZF_Groupone_F1632057_001  
652   /Volumes/Beta/data/flow/panel1_test5_4.pdf       22772     23291  2016-07-06_PANEL1_ZF_Groupone_F1632091_010  
653   /Volumes/Beta/data/flow/panel1_test5_4.pdf       19452     37802  2016-07-06_PANEL1_ZF_Groupone_F1632098_005  
654   /Volumes/Beta/data/flow/panel1_test5_4.pdf       38760     39061  2016-07-06_PANEL1_ZF_Groupone_F1632112_009  
655   /Volumes/Beta/data/flow/panel1_test5_4.pdf       11358     11247  2016-07-06_PANEL1_ZF_Groupone_F1632325_002  
656   /Volumes/Beta/data/flow/panel1_test5_4.pdf        1394      1404  2016-07-06_PANEL1_ZF_Groupone_F1632350_008  
657   /Volumes/Beta/data/flow/panel1_test5_4.pdf       37491     42472  2016-07-07_PANEL1_ZF_Groupone_F1632103_010  
658   /Volumes/Beta/data/flow/panel1_test5_4.pdf       22350     24534  2016-07-07_PANEL1_ZF_Groupone_F1632117_007  
659   /Volumes/Beta/data/flow/panel1_test5_5.pdf       85570     84680  2016-07-07_PANEL1_ZF_Groupone_F1632340_001  
660   /Volumes/Beta/data/flow/panel1_test5_5.pdf       62792     64985  2016-07-07_PANEL1_ZF_Groupone_F1632346_008  
661   /Volumes/Beta/data/flow/panel1_test5_5.pdf       54215     58821  2016-07-07_PANEL1_ZF_Groupone_F1632351_006  
662   /Volumes/Beta/data/flow/panel1_test5_5.pdf       69305     77102  2016-07-07_PANEL1_ZF_Groupone_F1632353_002  
663   /Volumes/Beta/data/flow/panel1_test5_5.pdf       76080     75414  2016-07-07_PANEL1_ZF_Groupone_F1632359_004  
664   /Volumes/Beta/data/flow/panel1_test5_5.pdf       37971     38064  2016-07-07_PANEL1_ZF_Groupone_F1632381_005  
665   /Volumes/Beta/data/flow/panel1_test5_5.pdf       47490     48028  2016-07-07_PANEL1_ZF_Groupone_F1632396_009  
666   /Volumes/Beta/data/flow/panel1_test5_5.pdf       33181     38248  2016-07-07_PANEL1_ZF_Grouptwo_F1631273_025  
667   /Volumes/Beta/data/flow/panel1_test5_5.pdf       54870     53235  2016-07-07_PANEL1_ZF_Grouptwo_F1631274_024  
668   /Volumes/Beta/data/flow/panel1_test5_5.pdf       32133     35801  2016-07-07_PANEL1_ZF_Grouptwo_F1632076_032  
669   /Volumes/Beta/data/flow/panel1_test5_5.pdf       13699     17869  2016-07-07_PANEL1_ZF_Grouptwo_F1632102_026  
670   /Volumes/Beta/data/flow/panel1_test5_5.pdf       50590     51662  2016-07-07_PANEL1_ZF_Grouptwo_F1632105_027  
671   /Volumes/Beta/data/flow/panel1_test5_5.pdf       37828     44333  2016-07-07_PANEL1_ZF_Grouptwo_F1632134_029  
672   /Volumes/Beta/data/flow/panel1_test5_5.pdf      100427    103835  2016-07-07_PANEL1_ZF_Grouptwo_F1632343_030  
673   /Volumes/Beta/data/flow/panel1_test5_6.pdf       23544     30274  2016-07-07_PANEL1_ZF_Grouptwo_F1632358_028  
674   /Volumes/Beta/data/flow/panel1_test5_6.pdf       55560     54635  2016-07-07_PANEL1_ZF_Grouptwo_F1632383_031  
675   /Volumes/Beta/data/flow/panel1_test5_6.pdf       19437     19766  2016-07-08_PANEL1_ZF_Groupone_F1631265_006  
676   /Volumes/Beta/data/flow/panel1_test5_6.pdf       10597     11307  2016-07-08_PANEL1_ZF_Groupone_F1631269_003  
677   /Volumes/Beta/data/flow/panel1_test5_6.pdf        7109      7068  2016-07-08_PANEL1_ZF_Groupone_F1631270_010  
678   /Volumes/Beta/data/flow/panel1_test5_6.pdf       17531     19082  2016-07-08_PANEL1_ZF_Groupone_F1632153_004  
679   /Volumes/Beta/data/flow/panel1_test5_6.pdf       12195     11056  2016-07-08_PANEL1_ZF_Groupone_F1632338_008  
680   /Volumes/Beta/data/flow/panel1_test5_6.pdf        2392      2832  2016-07-08_PANEL1_ZF_Groupone_F1632339_009  
681   /Volumes/Beta/data/flow/panel1_test5_6.pdf        4298      4373  2016-07-08_PANEL1_ZF_Groupone_F1632342_002  
682   /Volumes/Beta/data/flow/panel1_test5_6.pdf         438       720  2016-07-08_PANEL1_ZF_Groupone_F1632345_001  
683   /Volumes/Beta/data/flow/panel1_test5_6.pdf       10264     10170  2016-07-08_PANEL1_ZF_Groupone_F1632380_005  
684   /Volumes/Beta/data/flow/panel1_test5_6.pdf       26969     28988  2016-07-08_PANEL1_ZF_Groupone_F1632399_007  
685   /Volumes/Beta/data/flow/panel1_test5_6.pdf       67477     67270  2016-07-08_PANEL1_ZF_Grouptwo_F1631285_030  
686   /Volumes/Beta/data/flow/panel1_test5_6.pdf         586      1376  2016-07-08_PANEL1_ZF_Grouptwo_F1632054_032  
687   /Volumes/Beta/data/flow/panel1_test5_6.pdf       18499     23303  2016-07-08_PANEL1_ZF_Grouptwo_F1632131_025  
688   /Volumes/Beta/data/flow/panel1_test5_7.pdf        4647      5030  2016-07-08_PANEL1_ZF_Grouptwo_F1632278_033  
689   /Volumes/Beta/data/flow/panel1_test5_7.pdf       22700     25271  2016-07-08_PANEL1_ZF_Grouptwo_F1632284_029  
690   /Volumes/Beta/data/flow/panel1_test5_7.pdf       44807     43563  2016-07-08_PANEL1_ZF_Grouptwo_F1632363_026  
691   /Volumes/Beta/data/flow/panel1_test5_7.pdf       65670     66753  2016-07-08_PANEL1_ZF_Grouptwo_F1632372_024  
692   /Volumes/Beta/data/flow/panel1_test5_7.pdf       17838     21575  2016-07-08_PANEL1_ZF_Grouptwo_F1632379_031  
693   /Volumes/Beta/data/flow/panel1_test5_7.pdf       42591     44159  2016-07-08_PANEL1_ZF_Grouptwo_F1632385_027  
694   /Volumes/Beta/data/flow/panel1_test5_7.pdf       56565     56652  2016-07-08_PANEL1_ZF_Grouptwo_F1649319_028  
695   /Volumes/Beta/data/flow/panel1_test5_7.pdf       68799     66857  2016-07-27_PANEL1_ZF_Groupone_F1631224_003  
696   /Volumes/Beta/data/flow/panel1_test5_7.pdf        4352      4261  2016-07-27_PANEL1_ZF_Groupone_F1631305_002  
697   /Volumes/Beta/data/flow/panel1_test5_7.pdf       21492     21365  2016-07-27_PANEL1_ZF_Groupone_F1631369_009  
698   /Volumes/Beta/data/flow/panel1_test5_7.pdf       49424     51175  2016-07-27_PANEL1_ZF_Groupone_F1632277_010  
699   /Volumes/Beta/data/flow/panel1_test5_7.pdf       45188     44755  2016-07-27_PANEL1_ZF_Groupone_F1632369_008  
700   /Volumes/Beta/data/flow/panel1_test5_7.pdf       55881     55699  2016-07-27_PANEL1_ZF_Groupone_F1632384_007  
701   /Volumes/Beta/data/flow/panel1_test5_7.pdf       15341     19221  2016-07-27_PANEL1_ZF_Groupone_F1632400_006  
702   /Volumes/Beta/data/flow/panel1_test5_7.pdf       69764     72205  2016-07-27_PANEL1_ZF_Groupone_F1636532_005  
703   /Volumes/Beta/data/flow/panel1_test5_8.pdf       26213     28640  2016-07-27_PANEL1_ZF_Groupone_F1636535_004  
704   /Volumes/Beta/data/flow/panel1_test5_8.pdf       60197     59467  2016-07-27_PANEL1_ZF_Grouptwo_F1631148_028  
705   /Volumes/Beta/data/flow/panel1_test5_8.pdf       34595     32649  2016-07-27_PANEL1_ZF_Grouptwo_F1631199_031  
706   /Volumes/Beta/data/flow/panel1_test5_8.pdf       51782     51459  2016-07-27_PANEL1_ZF_Grouptwo_F1636515_032  
707   /Volumes/Beta/data/flow/panel1_test5_8.pdf       62814     63084  2016-07-27_PANEL1_ZF_Grouptwo_F1636520_029  
708   /Volumes/Beta/data/flow/panel1_test5_8.pdf       31187     40658  2016-07-27_PANEL1_ZF_Grouptwo_F1636521_024  
709   /Volumes/Beta/data/flow/panel1_test5_8.pdf       11375     12682  2016-07-27_PANEL1_ZF_Grouptwo_F1636785_030  
710   /Volumes/Beta/data/flow/panel1_test5_8.pdf        1426      1476  2016-07-27_PANEL1_ZF_Grouptwo_F1636806_025  
711   /Volumes/Beta/data/flow/panel1_test5_8.pdf       10705     11702  2016-07-27_PANEL1_ZF_Grouptwo_F1636821_026  
712   /Volumes/Beta/data/flow/panel1_test5_8.pdf       63582     66639  2016-07-27_PANEL1_ZF_Grouptwo_F1636835_027  
713   /Volumes/Beta/data/flow/panel1_test5_8.pdf        5623      5634  2016-07-29_PANEL1_ZF_Groupone_F1631100_003  
714   /Volumes/Beta/data/flow/panel1_test5_8.pdf       39121     37821  2016-07-29_PANEL1_ZF_Groupone_F1632280_001  
715   /Volumes/Beta/data/flow/panel1_test5_8.pdf       19018     19180  2016-07-29_PANEL1_ZF_Groupone_F1636517_010  
716   /Volumes/Beta/data/flow/panel1_test5_8.pdf       69562     64439  2016-07-29_PANEL1_ZF_Groupone_F1636523_008  
717   /Volumes/Beta/data/flow/panel1_test5_8.pdf        4113      4759  2016-07-29_PANEL1_ZF_Groupone_F1636528_002  
718   /Volumes/Beta/data/flow/panel1_test5_9.pdf        2264      2321  2016-07-29_PANEL1_ZF_Groupone_F1636542_006  
719   /Volumes/Beta/data/flow/panel1_test5_9.pdf         872      1111  2016-07-29_PANEL1_ZF_Groupone_F1636783_009  
720   /Volumes/Beta/data/flow/panel1_test5_9.pdf       27487     23919  2016-07-29_PANEL1_ZF_Groupone_F1636802_005  
721   /Volumes/Beta/data/flow/panel1_test5_9.pdf       29758     26455  2016-07-29_PANEL1_ZF_Groupone_F1636814_004  
722   /Volumes/Beta/data/flow/panel1_test5_9.pdf       74301     72867  2016-07-29_PANEL1_ZF_Groupone_F1636837_007  
723   /Volumes/Beta/data/flow/panel1_test5_9.pdf       12226     10138  2016-07-29_PANEL1_ZF_Grouptwo_F1631111_029  
724   /Volumes/Beta/data/flow/panel1_test5_9.pdf        9505      9883  2016-07-29_PANEL1_ZF_Grouptwo_F1631330_031  
725   /Volumes/Beta/data/flow/panel1_test5_9.pdf       15492     20942  2016-07-29_PANEL1_ZF_Grouptwo_F1636525_024  
726   /Volumes/Beta/data/flow/panel1_test5_9.pdf       28110     26163  2016-07-29_PANEL1_ZF_Grouptwo_F1636784_033  
727   /Volumes/Beta/data/flow/panel1_test5_9.pdf      105791     96375  2016-07-29_PANEL1_ZF_Grouptwo_F1636796_027  
728   /Volumes/Beta/data/flow/panel1_test5_9.pdf       22463     21942  2016-07-29_PANEL1_ZF_Grouptwo_F1636823_026  
729   /Volumes/Beta/data/flow/panel1_test5_9.pdf       37504     41986  2016-07-29_PANEL1_ZF_Grouptwo_F1636833_030  
730   /Volumes/Beta/data/flow/panel1_test5_9.pdf       17467     17337  2016-07-29_PANEL1_ZF_Grouptwo_F1636856_032  
731   /Volumes/Beta/data/flow/panel1_test5_9.pdf        8467      8465  2016-07-29_PANEL1_ZF_Grouptwo_F1636859_028  
732   /Volumes/Beta/data/flow/panel1_test5_9.pdf       36956     37759  2016-08-01_PANEL1_DHS_Groupone_F1630927_008 
733   /Volumes/Beta/data/flow/panel1_test5_10.pdf      33466     32904  2016-08-01_PANEL1_DHS_Groupone_F1631107_010 
734   /Volumes/Beta/data/flow/panel1_test5_10.pdf       3002      5028  2016-08-01_PANEL1_DHS_Groupone_F1631332_012 
735   /Volumes/Beta/data/flow/panel1_test5_10.pdf       7004      7205  2016-08-01_PANEL1_DHS_Groupone_F1631366_002 
736   /Volumes/Beta/data/flow/panel1_test5_10.pdf      50484     52142  2016-08-01_PANEL1_DHS_Groupone_F1631377_003 
737   /Volumes/Beta/data/flow/panel1_test5_10.pdf         80       471  2016-08-01_PANEL1_DHS_Groupone_F1636533_004 
738   /Volumes/Beta/data/flow/panel1_test5_10.pdf      57934     57144  2016-08-01_PANEL1_DHS_Groupone_F1636775_013 
739   /Volumes/Beta/data/flow/panel1_test5_10.pdf      45591     46538  2016-08-01_PANEL1_DHS_Groupone_F1636790_006 
740   /Volumes/Beta/data/flow/panel1_test5_10.pdf      49041     49932  2016-08-01_PANEL1_DHS_Groupone_F1636818_005 
741   /Volumes/Beta/data/flow/panel1_test5_10.pdf       2093      2162  2016-08-01_PANEL1_DHS_Groupone_F1636819_011 
742   /Volumes/Beta/data/flow/panel1_test5_10.pdf      38960     39894  2016-08-01_PANEL1_DHS_Groupone_F1636826_007 
743   /Volumes/Beta/data/flow/panel1_test5_10.pdf       4283      4724  2016-08-01_PANEL1_DHS_Groupone_F1636847_014 
744   /Volumes/Beta/data/flow/panel1_test5_10.pdf      25791     26266  2016-08-01_PANEL1_DHS_Groupone_F1636850_009 
745   /Volumes/Beta/data/flow/panel1_test5_10.pdf       5607      5905  2016-08-01_PANEL1_DHS_Groupone_F1636851_001 
746   /Volumes/Beta/data/flow/panel1_test5_10.pdf       6987      9650  2016-08-01_PANEL1_DHS_Grouptwo_F1631147_029 
747   /Volumes/Beta/data/flow/panel1_test5_10.pdf      18823     20892  2016-08-01_PANEL1_DHS_Grouptwo_F1631374_028 
748   /Volumes/Beta/data/flow/panel1_test5_11.pdf      22491     23120  2016-08-01_PANEL1_DHS_Grouptwo_F1631383_031 
749   /Volumes/Beta/data/flow/panel1_test5_11.pdf      62393     62003  2016-08-01_PANEL1_DHS_Grouptwo_F1636774_030 
750   /Volumes/Beta/data/flow/panel1_test5_11.pdf      22471     23662  2016-08-01_PANEL1_DHS_Grouptwo_F1636830_032 

