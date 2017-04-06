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
metricsAuto = metrics[which(metrics$GATE=="AUTOMATIC"&metrics$QC=="TRUE"&metrics$Population %in% map$Auto&metrics$METRIC=="count"),]

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
  
   p = ggplot(sub, aes(x =
  freqParent.x, y = freqParent.y, color = FlaggedSample.x)) + geom_point() + xlab("Autogating population count") +
  ylab("Manual gating population count") + geom_abline(intercept = 0, slope = 1)+ labs(title = paste(pop,"n=",length(sub$Count.x),"- pearson r =",signif(t$estimate,4),"- spearman r =",signif(ts$estimate,4)))
  print(p)
}
```

![](plotPropCount_files/figure-html/setup-3.png)<!-- -->![](plotPropCount_files/figure-html/setup-4.png)<!-- -->![](plotPropCount_files/figure-html/setup-5.png)<!-- -->![](plotPropCount_files/figure-html/setup-6.png)<!-- -->![](plotPropCount_files/figure-html/setup-7.png)<!-- -->![](plotPropCount_files/figure-html/setup-8.png)<!-- -->![](plotPropCount_files/figure-html/setup-9.png)<!-- -->![](plotPropCount_files/figure-html/setup-10.png)<!-- -->![](plotPropCount_files/figure-html/setup-11.png)<!-- -->![](plotPropCount_files/figure-html/setup-12.png)<!-- -->![](plotPropCount_files/figure-html/setup-13.png)<!-- -->![](plotPropCount_files/figure-html/setup-14.png)<!-- -->![](plotPropCount_files/figure-html/setup-15.png)<!-- -->![](plotPropCount_files/figure-html/setup-16.png)<!-- -->![](plotPropCount_files/figure-html/setup-17.png)<!-- -->![](plotPropCount_files/figure-html/setup-18.png)<!-- -->![](plotPropCount_files/figure-html/setup-19.png)<!-- -->![](plotPropCount_files/figure-html/setup-20.png)<!-- -->![](plotPropCount_files/figure-html/setup-21.png)<!-- -->![](plotPropCount_files/figure-html/setup-22.png)<!-- -->![](plotPropCount_files/figure-html/setup-23.png)<!-- -->![](plotPropCount_files/figure-html/setup-24.png)<!-- -->![](plotPropCount_files/figure-html/setup-25.png)<!-- -->![](plotPropCount_files/figure-html/setup-26.png)<!-- -->![](plotPropCount_files/figure-html/setup-27.png)<!-- -->![](plotPropCount_files/figure-html/setup-28.png)<!-- -->![](plotPropCount_files/figure-html/setup-29.png)<!-- -->![](plotPropCount_files/figure-html/setup-30.png)<!-- -->![](plotPropCount_files/figure-html/setup-31.png)<!-- -->![](plotPropCount_files/figure-html/setup-32.png)<!-- -->

```r
 cor.test(metricCombo$Count.x,metricCombo$Count.y,method = "spearman")
```

```
## 
## 	Spearman's rank correlation rho
## 
## data:  metricCombo$Count.x and metricCombo$Count.y
## S = 806, p-value < 2.2e-16
## alternative hypothesis: true rho is not equal to 0
## sample estimates:
##       rho 
## 0.9933654
```

```r
look = metricCombo[which(metricCombo$Population.x=="CCR7+CD45RA+"),]
kable(look[,c("PDF.x","Count.x","Count.y","name.x")])
```

     PDF.x                                         Count.x   Count.y  name.x                                     
---  -------------------------------------------  --------  --------  -------------------------------------------
25   /Volumes/Beta/data/flow/panel1_test5_1.pdf      33609     37945  2016-05-11_PANEL1_ZF_panelone_F1631920_007 
26   /Volumes/Beta/data/flow/panel1_test5_1.pdf      20037     21871  2016-05-11_PANEL1_ZF_panelone_F1632171_002 
27   /Volumes/Beta/data/flow/panel1_test5_1.pdf      39156     41724  2016-05-13_PANEL1_ZF_panelone_F1632235_005 
28   /Volumes/Beta/data/flow/panel1_test5_1.pdf      19134     37802  2016-07-06_PANEL1_ZF_Groupone_F1632098_005 
29   /Volumes/Beta/data/flow/panel1_test5_1.pdf      18030     23303  2016-07-08_PANEL1_ZF_Grouptwo_F1632131_025 
30   /Volumes/Beta/data/flow/panel1_test5_1.pdf      37850     37821  2016-07-29_PANEL1_ZF_Groupone_F1632280_001 

