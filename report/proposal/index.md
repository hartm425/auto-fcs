# Collecting notes for LLFS proposal



## Automatic Gating of flow cytometry data

>  Automated gating was able to match the performance of central manual analysis for all tested panels, exhibiting little to no bias and comparable variability. Standardized staining, data collection, and automated gating can increase power, reduce variability, and streamline analysis for immunophenotyping.

> The two top performing gating algorithms - OpenCyto (v. 1.7.4), flowDensity (v. 1.4.0) - in a study run by the FlowCAP consortium aimed at selecting the best performing algorithms for this larger study were chosen for the analysis presented in this paper. 

***Standardizing Flow Cytometry Immunophenotyping Analysis from the Human ImmunoPhenotyping Consortium***
<a name=cite-Finak_2016></a>[Finak, Langweiler, Jaimes, et al. (2016)](https://doi.org/10.1038%2Fsrep20686)

### OpenCyto <a name=cite-Finak_2014></a>[Finak, Frelinger, Jiang, et al. (2014)](https://doi.org/10.1371%2Fjournal.pcbi.1003806)



We propose to use OpenCyto to perform systematic and reproducible gating of 28 immune cell subsets. Gating is standardized via a **[.csv](https://github.com/PankratzLab/auto-fcs/blob/master/explore/openCyto/lymph.dev.b.csv)** file describing the algorithmic approach for each step of the gating hierarchy. Importantly, this methodology allows for unbiased gating of thousands of samples producing results that are interpretable and labelled populations

OpenCyto gives the user many options to refine algorithmic parameters to improve the performance of each step in the gating hierarchy. We evaluated the performance of our OpenCyto template using internal data for 151 manually gated (Jflow software) samples across 15 gates. The global correlation between the population counts of manual and OpenCyto gating was high (rho=0.9846 ,p-value <2e-16). Despite a high global concordance, certain subsets were less well correlated (e.g Activated CD4 counts, rho=0.6222 ,p-value <2e-16).

While OpenCyto can automate the classification of known subsets by following a traditional gating hierarchy, it does not easily facilitate the discovery of novel populations. 



![](index_files/figure-html/unnamed-chunk-1-1.png)<!-- -->


## Novel subsets


### My made up diagram for novel subsets

<!--html_preserve--><div id="htmlwidget-eefd66ee12770ea3132d" style="width:672px;height:480px;" class="visNetwork html-widget"></div>
<script type="application/json" data-for="htmlwidget-eefd66ee12770ea3132d">{"x":{"nodes":{"id":[1,2,3,4,5,6,7],"group":["chr","chr","chr","chr","chr","chr","chr"],"label":["OpenCyto:trim to primary subset","Primary subset (T- or B-Cells?)","Phenograph","Compute MEM score","Find discriminating populations for Case/Control","Citrus","Visualize with t-SNE"],"shape":["ellipse","ellipse","ellipse","ellipse","ellipse","ellipse","ellipse"]},"edges":{"id":[1,2,3,4,5,6,7,8],"from":[1,2,2,3,4,5,6,5],"to":[2,3,6,4,5,7,5,7],"label":["related","related","related","related","related","related","related","related"]},"nodesToDataframe":true,"edgesToDataframe":true,"options":{"width":"100%","height":"100%","nodes":{"shape":"dot"},"manipulation":{"enabled":false},"edges":{"arrows":{"to":{"enabled":true,"scaleFactor":1}}},"physics":{"stabilization":{"enabled":true,"onlyDynamicEdges":false,"fit":true}},"layout":{"improvedLayout":true}},"groups":"chr","width":null,"height":null,"idselection":{"enabled":false},"byselection":{"enabled":false},"main":null,"submain":null,"footer":null},"evals":[],"jsHooks":[]}</script><!--/html_preserve--><!--html_preserve--><div id="htmlwidget-8977ff6bc5442a8d4894" style="width:672px;height:480px;" class="grViz html-widget"></div>
<script type="application/json" data-for="htmlwidget-8977ff6bc5442a8d4894">{"x":{"diagram":"digraph {\n\ngraph [layout = \"neato\",\n       outputorder = \"edgesfirst\"]\n\nnode [fontname = \"Helvetica\",\n     fontsize = \"10\",\n     shape = \"circle\",\n     fixedsize = \"true\",\n     width = \"0.5\",\n     style = \"filled\",\n     fillcolor = \"aliceblue\",\n     color = \"gray70\",\n     fontcolor = \"gray50\"]\n\nedge [len = \"1.5\",\n     color = \"gray40\",\n     arrowsize = \"0.5\"]\n\n  \"1\" [label = \"OpenCyto:trim to primary subset\", shape = \"ellipse\"] \n  \"2\" [label = \"Primary subset (T- or B-Cells?)\", shape = \"ellipse\"] \n  \"3\" [label = \"Phenograph\", shape = \"ellipse\"] \n  \"4\" [label = \"Compute MEM score\", shape = \"ellipse\"] \n  \"5\" [label = \"Find discriminating populations for Case/Control\", shape = \"ellipse\"] \n  \"6\" [label = \"Citrus\", shape = \"ellipse\"] \n  \"7\" [label = \"Visualize with t-SNE\", shape = \"ellipse\"] \n\"1\"->\"2\" [id = \"1\"] \n\"2\"->\"3\" [id = \"2\"] \n\"2\"->\"6\" [id = \"3\"] \n\"3\"->\"4\" [id = \"4\"] \n\"4\"->\"5\" [id = \"5\"] \n\"5\"->\"7\" [id = \"6\"] \n\"6\"->\"5\" [id = \"7\"] \n\"5\"->\"7\" [id = \"8\"] \n}","config":{"engine":null,"options":null}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```
## quartz_off_screen 
##                 2
```


### PhenoGraph
<a name=cite-Levine_2015></a>([Levine, Simonds, Bendall, et al., 2015](https://doi.org/10.1016%2Fj.cell.2015.05.047))

PhenoGraph performs unsupervised clustering of high dimensional single cell data allowing for the discovery of novel subtypes. We propose to use OpenCyto to first limit our search space (e.g starting from live, single T-Cells) and then search for novel populations within the clean subset.

PhenoGraph produces results that are numerically labelled populations, but do not have an immediate interpretation. In order interpret the PhenoGraph results, we will compute the MEM <a name=cite-Diggins_2017></a>[Diggins, Greenplate, Leelatian, et al. (2017)](https://doi.org/10.1038%2Fnmeth.4149) score of each PhenoGraph cluster allowing for (magical) comparisons between cases and controls.

![](index_files/figure-html/pgraph-1.png)<!-- -->![](index_files/figure-html/pgraph-2.png)<!-- -->


|unique(data_xk_all$V1)                               |
|:----------------------------------------------------|
|Lymphocytes (SSC-A v FSC-A)=1                        |
|central memory cytotoxic Tcells (CCR7+ , CD45RA-)=15 |
|activated helper Tcells (CD4+ HLA-DR+)=17            |
|effector memory cytotoxic Tcells (CD95+ CD28-)=18    |
|central memory helper Tcells (CD95+, CD28+)=19       |
|Single Cells (FSC-H v FSC-W)=2                       |
|effector memory helper Tcells (CD95+, CD28-)=20      |
|activated cytotoxic Tcells (CD8+ HLA-DR+)=21         |
|EM2 cytotoxic Tcells (CD27+  CD28-)=22               |
|EM4 cytotoxic Tcells (CD27-  CD28+)=23               |
|pE1 cytotoxic Tcells (CD27+  CD28+)=24               |
|effector memory helper Tcells (CCR7- CD45RA-)=25     |
|naive cytotoxic Tcells (CD95- CD28+)=26              |
|naive helper Tcells (CCR7+ CD45RA+)=27               |
|EM3 cytotoxic Tcells (CD27-  CD28-)=28               |
|pE cytotoxic Tcells (CD27-  CD28-)=29                |
|Live cells (PE-)=3                                   |
|naive cytotoxic Tcells (CCR7+ , CD45RA+)=30          |
|central memory cytotoxic Tcells (CD95+ CD28+)=31     |
|EM1 cytotoxic Tcells (CD27+  CD28+)=32               |
|pE2 cytotoxic Tcells (CD27+ , CD28-)=33              |
|effector helper Tcells (CCR7- CD45RA+)=34            |
|cytotoxic Tcells CD27- , CD28+=36                    |
|central memory helper Tcells (CCR7+ CD45RA-)=37      |
|naive helper Tcells (CD95-, CD28+)=38                |
|Tcells (CD3+ CD19-)=6                                |
|cytotoxic Tcells-CD8+=7                              |

![](index_files/figure-html/pgraphs3-1.png)<!-- -->![](index_files/figure-html/pgraphs3-2.png)<!-- -->![](index_files/figure-html/pgraphs3-3.png)<!-- -->![](index_files/figure-html/pgraphs3-4.png)<!-- -->![](index_files/figure-html/pgraphs3-5.png)<!-- -->


***t-SNE is a visualization method, and not sure if it can be directly used for automated novel subset detection***


### Citrus
<a name=cite-Bruggner_2014></a>[Bruggner, Bodenmiller, Dill, et al. (2014)](https://doi.org/10.1073%2Fpnas.1408792111)



May be good choice for Aim 1:

>  Citrus (cluster identification, characterization, and regression), a data-driven approach for the identification of stratifying subpopulations in multidimensional cytometry datasets.

Citrus was designed to detect stratifying cell populations between cases and controls.








