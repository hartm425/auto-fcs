# plotPropCount
JL  
4/3/2017  


```r
library(knitr)
library(ggplot2)
theme_set(theme_bw(15))
map = read.delim("/Users/Kitty/git/auto-fcs/explore/openCyto/autoManMap.txt",stringsAsFactors = FALSE,sep = "\t") 
metrics =read.delim("/Volumes/Beta/data/flow/testTypesTestMetrics5.txt",stringsAsFactors = FALSE,sep = "\t") 
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

  p = ggplot(sub, aes(x =
  Count.x, y = Count.y, color = FlaggedSample.x)) + geom_point() + xlab("Autogating population count") +
  ylab("Manual gating population count") + geom_abline(intercept = 0, slope = 1)+ labs(title = paste(pop,"n=",length(sub$Count.x),"- pearson r =",signif(t$estimate,4),"- spearman r =",signif(ts$estimate,4)))
  print(p)
}
```

![](plotPropCount_files/figure-html/setup-3.png)<!-- -->![](plotPropCount_files/figure-html/setup-4.png)<!-- -->![](plotPropCount_files/figure-html/setup-5.png)<!-- -->![](plotPropCount_files/figure-html/setup-6.png)<!-- -->![](plotPropCount_files/figure-html/setup-7.png)<!-- -->![](plotPropCount_files/figure-html/setup-8.png)<!-- -->![](plotPropCount_files/figure-html/setup-9.png)<!-- -->![](plotPropCount_files/figure-html/setup-10.png)<!-- -->![](plotPropCount_files/figure-html/setup-11.png)<!-- -->![](plotPropCount_files/figure-html/setup-12.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-13.png)<!-- -->![](plotPropCount_files/figure-html/setup-14.png)<!-- -->![](plotPropCount_files/figure-html/setup-15.png)<!-- -->![](plotPropCount_files/figure-html/setup-16.png)<!-- -->![](plotPropCount_files/figure-html/setup-17.png)<!-- -->

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
## S = 202820, p-value < 2.2e-16
## alternative hypothesis: true rho is not equal to 0
## sample estimates:
##       rho 
## 0.9266097
```

```r
look = metricCombo[which(metricCombo$Population.x=="CCR7+CD45RA+"),]
kable(look[,c("PDF.x","Count.x","Count.y","name.x")])
```

     PDF.x                                         Count.x   Count.y  name.x                                      
---  -------------------------------------------  --------  --------  --------------------------------------------
69   /Volumes/Beta/data/flow/panel1_test5_1.pdf      30418     32167  2016-05-06_PANEL1_ZF_panelone_F1631950_006  
70   /Volumes/Beta/data/flow/panel1_test5_1.pdf      13655     17361  2016-05-06_PANEL1_ZF_panelone_F1631957_002  
71   /Volumes/Beta/data/flow/panel1_test5_1.pdf      14105     15699  2016-05-11_PANEL1_ZF_panelone_F1631919_009  
72   /Volumes/Beta/data/flow/panel1_test5_1.pdf      33668     37945  2016-05-11_PANEL1_ZF_panelone_F1631920_007  
73   /Volumes/Beta/data/flow/panel1_test5_1.pdf      15021     15930  2016-05-11_PANEL1_ZF_panelone_F1631925_005  
74   /Volumes/Beta/data/flow/panel1_test5_1.pdf      27339     27662  2016-05-11_PANEL1_ZF_panelone_F1631942_008  
75   /Volumes/Beta/data/flow/panel1_test5_1.pdf      20007     21871  2016-05-11_PANEL1_ZF_panelone_F1632171_002  
76   /Volumes/Beta/data/flow/panel1_test5_1.pdf      38974     41724  2016-05-13_PANEL1_ZF_panelone_F1632235_005  
77   /Volumes/Beta/data/flow/panel1_test5_2.pdf      19093     37802  2016-07-06_PANEL1_ZF_Groupone_F1632098_005  
78   /Volumes/Beta/data/flow/panel1_test5_1.pdf       2473      2832  2016-07-08_PANEL1_ZF_Groupone_F1632339_009  
79   /Volumes/Beta/data/flow/panel1_test5_2.pdf      18012     23303  2016-07-08_PANEL1_ZF_Grouptwo_F1632131_025  
80   /Volumes/Beta/data/flow/panel1_test5_1.pdf      37900     37821  2016-07-29_PANEL1_ZF_Groupone_F1632280_001  
81   /Volumes/Beta/data/flow/panel1_test5_1.pdf      36820     41986  2016-07-29_PANEL1_ZF_Grouptwo_F1636833_030  
82   /Volumes/Beta/data/flow/panel1_test5_1.pdf      36790     37759  2016-08-01_PANEL1_DHS_Groupone_F1630927_008 
83   /Volumes/Beta/data/flow/panel1_test5_1.pdf       2956      5028  2016-08-01_PANEL1_DHS_Groupone_F1631332_012 
84   /Volumes/Beta/data/flow/panel1_test5_1.pdf       2051      2162  2016-08-01_PANEL1_DHS_Groupone_F1636819_011 
85   /Volumes/Beta/data/flow/panel1_test5_1.pdf      21009     20892  2016-08-01_PANEL1_DHS_Grouptwo_F1631374_028 

