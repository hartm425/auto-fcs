# plotTSNE
JL  
2/15/2017  



## Analysis

```
## Loading required package: plyr
```

```
## 
## Attaching package: 'igraph'
```

```
## The following objects are masked from 'package:flowCore':
## 
##     normalize, parent, tree
```

```
## The following objects are masked from 'package:stats':
## 
##     decompose, spectrum
```

```
## The following object is masked from 'package:base':
## 
##     union
```

```
##     Compensation is applied on  ~/temp/fcs/2016-05-20_PANEL 2_ZF_panel 2_F1632217_009.fcs
```

```
## Run Rphenograph starts:
##   -Input data of 43333 rows and 9 columns
##   -k is set to 11
```

```
##   Finding nearest neighbors...DONE ~ 9.043 s
##   Compute jaccard coefficient between nearest-neighbor sets...DONE ~ 2.074 s
##   Build undirected graph from the weighted links...DONE ~ 1.118 s
##   Run louvain clustering on the graph ...DONE ~ 1.272 s
```

```
## Run Rphenograph DONE, totally takes 13.507s.
```

```
##   Return a community class
##   -Modularity value: 0.8305925 
##   -Number of clusters: 30  Runing t-SNE...with seed 42  DONE
```

# Starting from PBMCs, I think

## TSNE results
![](PlotTSNE_files/figure-html/plot-1.png)<!-- -->

## TSNE results, colored by Phenograph clusters detected
![](PlotTSNE_files/figure-html/plot1-1.png)<!-- -->

## TSNE results, colored by manual gates 
![](PlotTSNE_files/figure-html/plot2-1.png)<!-- -->

## TSNE results, Manually gated 
![](PlotTSNE_files/figure-html/plot4-1.png)<!-- -->


# Starting from Dendritic cells,Natural killer cells, Monocytes, I think

## TSNE results
![](PlotTSNE_files/figure-html/plot5-1.png)<!-- -->

## TSNE results, colored by Phenograph clusters detected
![](PlotTSNE_files/figure-html/plot6-1.png)<!-- -->

## TSNE results, colored by manual gates 
![](PlotTSNE_files/figure-html/plot7-1.png)<!-- -->

## TSNE results, Manually gated 
![](PlotTSNE_files/figure-html/plot8-1.png)<!-- -->
