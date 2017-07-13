# Replicate Concordance
JL  
7/12/2017  

TODO 

- manual
- automatic
  - with/without QC
  
1. CV of reps
2. ICC
3. min diff
4. max diff
  





|REPLICATE | NUMBER_FCS_FILES|
|:---------|----------------:|
|A         |               21|
|B         |               11|
|C         |               17|
|D         |               13|
|E         |               16|
|F         |               24|
|G         |               19|
|H         |               16|



Total number of Control fcs files (currently) = 137

Total number of Control groups (currently) = 8

![](replicateConcordance_files/figure-html/unnamed-chunk-3-1.png)<!-- -->![](replicateConcordance_files/figure-html/unnamed-chunk-3-2.png)<!-- -->

Percent of parent CV summary


|GROUP | GROUP_MEDIAN_CV| GROUP_MAD_CV|
|:-----|---------------:|------------:|
|A     |        12.26435|     11.09480|
|B     |        13.33148|     11.76286|
|C     |        12.99054|     10.14676|
|D     |        22.46977|     12.80152|
|E     |        25.53363|     17.64769|
|F     |        20.54376|     19.90676|
|G     |        14.00589|     14.03718|
|H     |        14.57943|     15.49101|


Percent of lymph CV summary


|GROUP | GROUP_MEDIAN_CV| GROUP_MAD_CV|
|:-----|---------------:|------------:|
|A     |        13.57145|    11.930342|
|B     |        15.71823|    10.150433|
|C     |        13.93569|     8.233016|
|D     |        32.07279|     5.371330|
|E     |        28.17266|    22.784927|
|F     |        27.92368|    25.316248|
|G     |        16.22147|    12.757021|
|H     |        32.46109|    14.221776|

![](replicateConcordance_files/figure-html/unnamed-chunk-5-1.png)<!-- -->![](replicateConcordance_files/figure-html/unnamed-chunk-5-2.png)<!-- -->![](replicateConcordance_files/figure-html/unnamed-chunk-5-3.png)<!-- -->![](replicateConcordance_files/figure-html/unnamed-chunk-5-4.png)<!-- -->![](replicateConcordance_files/figure-html/unnamed-chunk-5-5.png)<!-- -->![](replicateConcordance_files/figure-html/unnamed-chunk-5-6.png)<!-- -->![](replicateConcordance_files/figure-html/unnamed-chunk-5-7.png)<!-- -->![](replicateConcordance_files/figure-html/unnamed-chunk-5-8.png)<!-- -->![](replicateConcordance_files/figure-html/unnamed-chunk-5-9.png)<!-- -->![](replicateConcordance_files/figure-html/unnamed-chunk-5-10.png)<!-- -->![](replicateConcordance_files/figure-html/unnamed-chunk-5-11.png)<!-- -->![](replicateConcordance_files/figure-html/unnamed-chunk-5-12.png)<!-- -->![](replicateConcordance_files/figure-html/unnamed-chunk-5-13.png)<!-- -->![](replicateConcordance_files/figure-html/unnamed-chunk-5-14.png)<!-- -->![](replicateConcordance_files/figure-html/unnamed-chunk-5-15.png)<!-- -->![](replicateConcordance_files/figure-html/unnamed-chunk-5-16.png)<!-- -->![](replicateConcordance_files/figure-html/unnamed-chunk-5-17.png)<!-- -->

|                                                                                         | cutree(fit, 8)|
|:----------------------------------------------------------------------------------------|--------------:|
|2016-01-08_PANEL 1_HB-appsettingsreset_Group one_Ctl-A_002.fcs                           |              1|
|2016-01-08_PANEL 1_HB-appsettingsreset_Group one_Ctl-B_005.fcs                           |              2|
|2016-01-08_PANEL 1_HB-appsettingsreset_Group one_Ctl-C_003.fcs                           |              3|
|2016-01-08_PANEL 1_HB-appsettingsreset_Group one_Ctl-D_004.fcs                           |              1|
|2016-10-24_PANEL 1_DHS_Group two_Ctl-A_033.fcs                                           |              4|
|2016-11-15_PANEL 1_HB_HRS_Ctl-C_023.fcs                                                  |              3|
|2016-11-15_PANEL 1_HB_HRS_Ctl-D_014.fcs                                                  |              5|
|2016-11-17_PANEL 1_ZF_Group two_Ctl-A_028.fcs                                            |              4|
|2016-11-18_PANEL 1_HB_HRS-P1-GROUP1_Ctl-D_025.fcs                                        |              6|
|2016-11-22_PANEL 1_DHS_Group two_Ctl-A_035.fcs                                           |              4|
|2016-11-22_PANEL 1_HB_HRS P1_Ctl-A-DHS_024.fcs                                           |              4|
|2016-11-22_PANEL 1_HB_HRS P1_Ctl-C_023.fcs                                               |              3|
|2016-11-23_PANEL 1_ZF_Group two_Ctl-D_028.fcs                                            |              6|
|2016-11-28_PANEL 1_DHS_Group two_Ctl-D_041.fcs                                           |              7|
|2016-11-29_PANEL 1_ZF_Group one_Ctl-A_016.fcs                                            |              7|
|2016-12-02_PANEL 1_HB_group two_Ctl-D_029.fcs                                            |              6|
|2016-12-02_PANEL 1_ZF_Group one_Ctl-C_016.fcs                                            |              3|
|2016-12-03_PANEL 1_ZF_Group two_Ctl-D_029.fcs                                            |              6|
|2016-12-05_PANEL 1_DHS_Group two_Ctl-C_033.fcs                                           |              3|
|2016-12-08_PANEL 1_ZF_Group two_Ctl-C_028.fcs                                            |              3|
|2016-12-09_PANEL 1_HB_group two_Ctl-B_029.fcs                                            |              7|
|2016-12-09_PANEL 1_ZF_Group two_Ctl-D_029.fcs                                            |              6|
|2016-12-12_PANEL 1_DHS_Group two_Ctl-A_040.fcs                                           |              7|
|2016-12-14_PANEL 1_ZF_Group two_Ctl-B_029.fcs                                            |              8|
|2016-12-16_PANEL 1_HB_group two_Ctl-A_033.fcs                                            |              4|
|2016-12-19_PANEL 1_ZF_Group two_Ctl-C_031.fcs                                            |              6|
|2016-12-22_PANEL 1_HB_group two_Ctl-A_028.fcs                                            |              4|
|2016-12-27_PANEL 1_ZF_Group two_Ctl-D_041.fcs                                            |              6|
|2016-12-30_PANEL 1_HB_group two_Ctl-B_033.fcs                                            |              8|
|2017-01-05_PANEL 1_ZF_Group two_Ctl-C_041.fcs                                            |              3|
|2017-01-06_PANEL 1_HB_group two_Ctl-D_033.fcs                                            |              6|
|2017-01-10_PANEL 1_HB_Group two_Ctl-C_033.fcs                                            |              3|
|2017-01-11_PANEL 1_ZF_Group one_Ctl-C_014.fcs                                            |              3|
|2017-01-12_PANEL 1_ZF_Group two_Ctl-A_029.fcs                                            |              4|
|2017-01-17_PANEL 1_ZF_Group two_Ctl-C_029.fcs                                            |              3|
|2017-01-19_PANEL 1_HB_group two_Ctl-A_024.fcs                                            |              4|
|2017-01-24_PANEL 1_ZF_group two_Ctl-A_017.fcs                                            |              4|
|2017-01-26_PANEL 1_DHS_Group two_Ctl-B_041.fcs                                           |              7|
|2017-01-26_PANEL 1_HB_group ONE_Ctl-C_010.fcs                                            |              3|
|2017-01-30_PANEL 1_DHS_Group two_Ctl-C_039.fcs                                           |              3|
|2017-01-30_PANEL 1_ZF_group two_Ctl-A_033.fcs                                            |              4|
|2017-01-31_PANEL 1_HB_group two_Ctl-A_033.fcs                                            |              4|
|2017-02-06_PANEL 1_DHS_group two_Ctl-B_031.fcs                                           |              8|
|2017-02-06_PANEL 1_ZF_Group two_Ctl-C_033.fcs                                            |              3|
|2017-02-09_PANEL 1_RR_group one_Ctl-A_019.fcs                                            |              4|
|2017-02-10_PANEL 1_HB_group two_Ctl-A_032.fcs                                            |              4|
|2017-02-10_PANEL 1_HB_group two_Ctl-E_033.fcs                                            |              2|
|2017-02-10_PANEL 1_ZF_Group two_Ctl-B_036.fcs                                            |              8|
|2017-02-10_PANEL 1_ZF_Group two_Ctl-F_037.fcs                                            |              8|
|2017-02-13_PANEL 1_DHS_Group two_Ctl-A_042.fcs                                           |              7|
|2017-02-13_PANEL 1_DHS_Group two_Ctl-E_043.fcs                                           |              2|
|2017-02-13_PANEL 1_ZF_group two_Ctl-C_034.fcs                                            |              3|
|2017-02-13_PANEL 1_ZF_group two_Ctl-G_035.fcs                                            |              3|
|2017-02-16_PANEL 1_HB_group two_Ctl-B_032.fcs                                            |              8|
|2017-02-16_PANEL 1_HB_group two_Ctl-F_033.fcs                                            |              8|
|2017-02-16_PANEL 1_RR_Group one_Ctl-D_007.fcs                                            |              6|
|2017-02-16_PANEL 1_RR_Group one_Ctl-H_008.fcs                                            |              6|
|2017-02-21_PANEL 1_DHS_group two_Ctl-B_037.fcs                                           |              8|
|2017-02-21_PANEL 1_DHS_group two_Ctl-F_036.fcs                                           |              8|
|2017-02-22_PANEL 1_ZF_Group two_Ctl-D_043.fcs                                            |              7|
|2017-02-22_PANEL 1_ZF_Group two_Ctl-H_042.fcs                                            |              5|
|2017-02-27_PANEL 1_DHS_group two_Ctl-C_042.fcs                                           |              3|
|2017-02-27_PANEL 1_DHS_group two_Ctl-G_043.fcs                                           |              3|
|2017-02-28_PANEL 1_RR_group two_Ctl-B_032.fcs                                            |              8|
|2017-02-28_PANEL 1_RR_group two_Ctl-F_033.fcs                                            |              8|
|2017-03-01_PANEL 1_FORTESSA_HB_group two_Ctl-D_032.fcs                                   |              6|
|2017-03-01_PANEL 1_FORTESSA_HB_group two_Ctl-H_033.fcs                                   |              5|
|2017-03-01_PANEL 1_LSR_ZF_Group two_Ctl-A_031.fcs                                        |              4|
|2017-03-01_PANEL 1_LSR_ZF_Group two_Ctl-E_032.fcs                                        |              2|
|2017-03-02_PANEL 1_FORTESSA_HB_group two_Ctl-G_033.fcs                                   |              3|
|2017-03-06_PANEL 1_FORTESSA_DHS_group two_Ctl-A_042.fcs                                  |              4|
|2017-03-06_PANEL 1_FORTESSA_DHS_group two_Ctl-H_043.fcs                                  |              5|
|2017-03-07_PANEL 1_LSR_RR_Group two_Ctl-C_032.fcs                                        |              3|
|2017-03-07_PANEL 1_LSR_RR_Group two_Ctl-G_033.fcs                                        |              3|
|2017-03-08_PANEL 1_FORTESSA_ZF_group one_Ctl-A_021.fcs                                   |              1|
|2017-03-08_PANEL 1_FORTESSA_ZF_group one_Ctl-H_022.fcs                                   |              6|
|2017-03-09_PANEL 1_FORTESSA_HB-post tank replacement_group one_Ctl-A_014.fcs             |              1|
|2017-03-09_PANEL 1_FORTESSA_HB-post tank replacement_group one_Ctl-H_015.fcs             |              6|
|2017-03-13_PANEL 1_LSR_RR_Group two_Ctl-E_033.fcs                                        |              3|
|2017-03-14_PANEL 1_FORTESSA_DHS_group two_HB_Ctl-G_046.fcs                               |              3|
|2017-03-20_PANEL 1_FORTESSA_HB_group two_ZF_Ctl-F_032.fcs                                |              8|
|2017-03-21_PANEL 1_FORTESSA_DHS_group two_Ctl-G_036.fcs                                  |              3|
|2017-03-21_PANEL 1_LSR_RR_Group two_Ctl-F_033.fcs                                        |              8|
|2017-03-23_PANEL 1_FORTESSA_HB_group two_Ctl-H_027.fcs                                   |              6|
|2017-03-29_PANEL 1_LSR_HB_Group one_Ctl-G_014.fcs                                        |              3|
|2017-04-03_PANEL 1_FORTESSA_DHS_group two_Ctl-E_026.fcs                                  |              2|
|2017-04-04_PANEL 1_LSR_RR_Group two_Ctl-H_041.fcs                                        |              6|
|2017-04-05_PANEL 1_LSR_HB_Group three_Ctl-F_035.fcs                                      |              8|
|2017-04-10_PANEL 1_FORTESSA_DHS_group three_Ctl-G_034.fcs                                |              3|
|2017-04-11_PANEL 1_LSR_RR_Group two_Ctl-E_041.fcs                                        |              2|
|2017-04-12_PANEL 1_FORTESSA_ZF_group two_Ctl-F_026.fcs                                   |              8|
|2017-04-13_PANEL 1_LSR_HB_Group three_Ctl-H_001.fcs                                      |              6|
|2017-04-13_PANEL 1_LSR_HB_Group three_Ctl-H_035.fcs                                      |              6|
|2017-04-17_PANEL 1_FORTESSA_DHS_group three_Ctl-E_033.fcs                                |              2|
|2017-04-17_PANEL 1_LSR_DHS_Group three_Ctl-E_035.fcs                                     |              5|
|2017-04-20_PANEL 1_LSR_ZF_Group two_Ctl_G_037.fcs                                        |              3|
|2017-04-24_PANEL 1_FORTESSA_DHS_group two_Ctl-H_039.fcs                                  |              6|
|2017-04-25_PANEL 1_LSR_DHS_Group three_Ctl-G_045.fcs                                     |              3|
|2017-04-27_PANEL 1_LSR_RR_Group two_001_Ctl-F_001.fcs                                    |              8|
|2017-04-27_PANEL 1_LSR_RR_Group two_RR_Ctl-F_032.fcs                                     |              8|
|2017-04-28_PANEL 1_LSR_ZF_Group two_Ctl-H_043.fcs                                        |              6|
|2017-05-01_PANEL 1_LSR_ZF_Group two_Ctl-F_039.fcs                                        |              6|
|2017-05-04_PANEL 1_LSR_RR_Group two_Ctl-G_001.fcs                                        |              3|
|2017-05-04_PANEL 1_LSR_RR_Group two_Ctl-G_034.fcs                                        |              3|
|2017-05-08_PANEL 1_LSR_DHS_Group two_Ctl-G_043.fcs                                       |              3|
|2017-05-11_PANEL 1_FORTESSA_HB-postboardsreplacement_group one_Ctl-F_014.fcs             |              5|
|2017-05-11_PANEL 1_FORTESSA_HB-postboardsreplacement_group one_Ctl-G_015.fcs             |              3|
|2017-05-12_PANEL 1_FORTESSA_HB_group two-ZF_Ctl-H_025.fcs                                |              6|
|2017-05-12_PANEL 1_LSR_ZF_Group two_Ctl-H_032.fcs                                        |              6|
|2017-05-16_PANEL 1_LSR_DHS_Group two_ZF_Ctl-H_044.fcs                                    |              6|
|2017-05-17_PANEL 1_FORTESSA_ZF-postUVlaseralignement&speedadjust_group two_Ctl-F_001.fcs |              8|
|2017-05-17_PANEL 1_FORTESSA_ZF-postUVlaseralignement&speedadjust_group two_Ctl-F_025.fcs |              8|
|2017-05-18_PANEL 1_FORTESSA_ZF_HB_group two_HB_Ctl-E_042.fcs                             |              2|
|2017-05-18_PANEL 1_FORTESSA_ZF_HB_group two_HB_Ctl-E-newbiolegend_041.fcs                |              2|
|2017-05-19_PANEL 1_FORTESSA_ZF_HB_group two_HB_Ctl-F_044.fcs                             |              8|
|2017-05-19_PANEL 1_LSR_ZF_HB_Group two_ZF_Ctl-E_029.fcs                                  |              1|
|2017-05-23_PANEL 1_LSR_DHS_ZF_Group two_DHS_Ctl-F_001.fcs                                |              8|
|2017-05-23_PANEL 1_LSR_DHS_ZF_Group two_DHS_Ctl-F_027.fcs                                |              8|
|2017-05-31_PANEL 1_LSR_001_Group two_DHS_Ctl-G_001.fcs                                   |              3|
|2017-05-31_PANEL 1_LSR_001_Group two_DHS_Ctl-G_025.fcs                                   |              3|
|2017-06-01_PANEL 1_LSR_HB_ZF_Group two-HB_Ctl-F_001.fcs                                  |              8|
|2017-06-01_PANEL 1_LSR_HB_ZF_Group two-HB_Ctl-F_029.fcs                                  |              8|
|2017-06-02_PANEL 1_LSR_HB_Group two-ZF_Ctl-F_042.fcs                                     |              8|
|2017-06-05_PANEL 1_LSR_DHS_Group two_DHS_Ctl-F_026.fcs                                   |              8|
|2017-06-07_PANEL 1_LSR_ZF_RR_Group two_RR_Ctl-E_040.fcs                                  |              2|
|2017-06-12_PANEL 1_LSR_DHS_ZF_Group two_DHS_Ctl-E_028.fcs                                |              2|
|2017-06-15_PANEL 1_LSR_ZF_Group one_EC_Ctl-E_029.fcs                                     |              2|
|2017-06-15_PANEL 1_LSR_ZF_Group one_EC_Ctl-F_031.fcs                                     |              8|
|2017-06-15_PANEL 1_LSR_ZF_Group one_EC_Ctl-G_030.fcs                                     |              3|
|2017-06-15_PANEL 1_LSR_ZF_Group one_EC_Ctl-H_032.fcs                                     |              6|
|2017-06-19_PANEL 1_LSR_DHS_Group one_EC_Ctl-E_002.fcs                                    |              7|
|2017-06-19_PANEL 1_LSR_DHS_Group one_EC_Ctl-E_043.fcs                                    |              7|
|2017-06-19_PANEL 1_LSR_DHS_Group two_DHS_Ctl-F_001.fcs                                   |              8|
|2017-06-19_PANEL 1_LSR_DHS_Group two_DHS_Ctl-F_028.fcs                                   |              8|
|2017-06-23_PANEL 1_LSR_ZF_Group one_HB_Ctl-G_034.fcs                                     |              3|
|2017-06-23_PANEL 1_LSR_ZF_Group two_ZF_Ctl-G_033.fcs                                     |              3|
|2017-1-03_PANEL 1_DHS_Group two_Ctl-B_041.fcs                                            |              8|
