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

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties

## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-3.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-4.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-5.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-6.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-7.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-8.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-9.png)<!-- -->

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

![](plotPropCount_files/figure-html/setup-12.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-13.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-14.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-15.png)<!-- -->

```
## Warning in cor.test.default(sub$Count.x, sub$Count.y, method = "spearman"):
## Cannot compute exact p-value with ties
```

![](plotPropCount_files/figure-html/setup-16.png)<!-- -->![](plotPropCount_files/figure-html/setup-17.png)<!-- -->

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
## S = 93005, p-value < 2.2e-16
## alternative hypothesis: true rho is not equal to 0
## sample estimates:
##       rho 
## 0.9716487
```

```r
look = metricCombo[which(metricCombo$Population.x=="CCR7-CD45RA+"&metricCombo$Count.y>20000),]
kable(look[,c("PDF.x","Count.x","Count.y","name.x")])
```

     PDF.x                                         Count.x   Count.y  name.x                                     
---  -------------------------------------------  --------  --------  -------------------------------------------
38   /Volumes/Beta/data/flow/panel1_test5_1.pdf      23519     26068  2016-05-11_PANEL1_ZF_panelone_F1631920_007 
39   /Volumes/Beta/data/flow/panel1_test5_1.pdf      19858     24664  2016-05-13_PANEL1_ZF_panelone_F1632235_005 
40   /Volumes/Beta/data/flow/panel1_test5_1.pdf      35810     22396  2016-07-06_PANEL1_ZF_Groupone_F1632098_005 
42   /Volumes/Beta/data/flow/panel1_test5_1.pdf      15153     23524  2016-07-08_PANEL1_ZF_Grouptwo_F1632131_025 

