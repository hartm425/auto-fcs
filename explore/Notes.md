Notes about FCS gating
================

Existing solutions
------------------

**French study <a name=cite-Chen_2015></a>[Chen, Hasan, Libri, et al. (2015)](https://doi.org/10.1016%2Fj.clim.2014.12.009)** - still seems to involve manual labor

> Define pre-processing parameters (manual) To initialize automatic processing of Phase I, FlowGM requires the input of a few parameters, such as the choice of a reference sample, and the selection of potential pre-filtering and post-filtering parameters.

**The end of gating? An introduction to automated analysis of high dimensional cytometry data <a name=cite-Mair_2015></a>[Mair, Hartmann, Mrdjen, et al. (2015)](https://doi.org/10.1002%2Feji.201545774)**

> With the rapid increase of available tools, in 2010 the first FlowCAP (Flow Cytometry: critical assessment of population identification) challenge was initiated and revealed that a large number of these automated algorithms perform equally well or even better than a human expert with respect to population identification as well as sample classification

-   Citrus — Identification of stratifying subpopulations
    -   seems to be geared at case/control stratification

    > The algorithm named “Citrus” provides an unsupervised and automated process—meaning that the application is not guided by any user input save the size of the smallest cluster—that combines computational identification of cellular subpopulations with various association models to reveal stratifying clusters and cellular responses that are best predictive, or best correlated with the experimental endpoint <a name=cite-Bruggner_2014></a>[Bruggner, Bodenmiller, Dill, et al. (2014)](https://doi.org/10.1073%2Fpnas.1408792111)

-   PhenoGraph — Clustering in high-dimensional space
    -   this is cool

    > The reported application of PhenoGraph to high-dimensional data of human bone marrow derived from healthy donors as well as acute myeloid leukemia (AML) patients \[45\] suggests that this method is superior to previously available clustering methods, and can resolve subpopulations as rare as 1 in 2000 cells. <a name=cite-Levine_2015></a>[Levine, Simonds, Bendall, et al. (2015)](https://doi.org/10.1016%2Fj.cell.2015.05.047)

**Computational flow cytometry: helping to make sense of high-dimensional immunology data <a name=cite-Saeys_2016></a>[Saeys, Gassen, and Lambrecht (2016)](https://doi.org/10.1038%2Fnri.2016.56)**

**Cluster stability in the analysis of mass cytometry data <a name=cite-Melchiotti_2016></a>[Melchiotti, Gracio, Kordasti, et al. (2016)](https://doi.org/10.1002%2Fcyto.a.23001)**

**Cytofkit: A Bioconductor Package for an Integrated Mass Cytometry Data Analysis Pipeline <a name=cite-Chen_2016></a>[Chen, Lau, Wong, et al. (2016)](https://doi.org/10.1371%2Fjournal.pcbi.1005112)**

-   <https://www.bioconductor.org/packages/devel/bioc/vignettes/cytofkit/inst/doc/cytofkit_workflow.html>

<!-- -->

    library("cytofkit") 
    cytofkit_GUI()  

//TODO

1.  Maaten and Hinton (2008). “Visualizing data using t-SNE.” Journal of Machine Learning Research, 9: 2579–2605.

2.  Wallach, I.; Liliean, R. (2009). “The Protein-Small-Molecule Database, A Non-Redundant Structural Resource for the Analysis of Protein-Ligand Binding”. Bioinformatics 25 (5): 615–620.
