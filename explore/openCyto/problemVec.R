# fcsFilesAllProbs = c(
#   "2016-05-29_PANEL 1_HB_panel one_H_D3_003.fcs", #Panel 1 test 6, strange clustering
#   "2016-08-01_PANEL 1_DHS_Group one_F1630927_008.fcs",
#   "2016-05-06_PANEL 1_ZF_panel one_F1631950_006.fcs", #test 1 page 7 
#   "2016-08-01_PANEL 1_DHS_Group one_F1636819_011.fcs",
#   "2016-08-01_PANEL 1_DHS_Group two_F1631374_028.fcs",
#   "2016-05-27_PANEL 1_ZF_panel one_F1631054_011.fcs", #test 5 page 4  weird additional population of cells 
#   "2016-05-27_PANEL 1_ZF_panel one_F1631061_005.fcs" ,#test 5 page 6  weird additional population of cells
#   "2016-05-27_PANEL 1_ZF_panel one_F1631137_009.fcs",#test 5 page 8 lower cluster below the lymphocytes
#   "2016-05-27_PANEL 1_ZF_panel one_F1631355_008.fcs" ,#test 5 page 8 lower cluster below the lymphocytes
#   "2016-08-01_PANEL 1_DHS_Group two_F1631374_028.fcs",# most over -called
#   "2016-08-01_PANEL 1_DHS_Group one_F1636819_011.fcs",# 2nd most over -called
#   "2016-07-29_PANEL 1_ZF_Group one_F1632280_001.fcs", # most under -called
#   "2016-07-29_PANEL 1_ZF_Group two_F1636833_030.fcs", # 2nd most under -called
#   "2016-07-08_PANEL 1_ZF_Group one_F1632339_009.fcs", #Crazy flowrate
#   "2016-08-01_PANEL 1_DHS_Group one_F1631332_012.fcs", #CD8 outlier,see https://github.com/PankratzLab/auto-fcs/issues/20
#   "2016-05-11_PANEL 1_ZF_panel one_F1631920_007.fcs", #CCR7-CD45RA+ under called
#   "2016-05-13_PANEL 1_ZF_panel one_F1632235_005.fcs", #CCR7-CD45RA+ under called
#   "2016-07-06_PANEL 1_ZF_Group one_F1632098_005.fcs", #CCR7-CD45RA+ under called
#   "2016-07-08_PANEL 1_ZF_Group two_F1632131_025.fcs"  #CCR7-CD45RA+ under called
#   
#   )
# 
# 
# # fcsFilesAll = unique(c(fcsFilesAllProbs, fcsFilesAll))
# 
# qcOutliers = c(
#   "2016-05-13_PANEL 1_ZF_panel one_F1632233_004.fcs",
#   "2016-05-20_PANEL 1_ZF_panel one_F1631992_004.fcs",
#   "2016-05-20_PANEL 1_ZF_panel one_F1632217_007.fcs",
#   "2016-05-26_PANEL 1_ZF_panel one_F1636727_020.fcs",
#   "2016-07-08_PANEL 1_ZF_Group one_F1631269_003.fcs",
#   "2016-07-08_PANEL 1_ZF_Group one_F1632339_009.fcs",
#   "2016-07-08_PANEL 1_ZF_Group one_F1632342_002.fcs",
#   "2016-07-27_PANEL 1_ZF_Group one_F1631305_002.fcs",
#   "2016-07-27_PANEL 1_ZF_Group one_F1632384_007.fcs",
#   "2016-07-29_PANEL 1_ZF_Group one_F1632280_001.fcs",
#   "2016-07-29_PANEL 1_ZF_Group one_F1636783_009.fcs",
#   "2016-08-01_PANEL 1_DHS_Group one_F1630927_008.fcs",
#   "2016-08-01_PANEL 1_DHS_Group two_F1636830_032.fcs"
# )
# # fcsFilesAll = unique(c(fcsFilesAll,fcsFilesAllProbs, qcOutliers))
# fcsFilesAll = unique(c(fcsFilesAll, fcsFilesAllProbs))
# # fcsFilesAll =c( "2016-05-11_PANEL 1_ZF_panel one_F1631920_007.fcs", #CCR7-CD45RA+ under called
# #   "2016-05-13_PANEL 1_ZF_panel one_F1632235_005.fcs", #CCR7-CD45RA+ under called
# #   "2016-07-06_PANEL 1_ZF_Group one_F1632098_005.fcs", #CCR7-CD45RA+ under called
# #   "2016-07-08_PANEL 1_ZF_Group two_F1632131_025.fcs",  #CCR7-CD45RA+ under called
# #   "2016-05-11_PANEL 1_ZF_panel one_F1632171_002.fcs",
# #   "2016-07-29_PANEL 1_ZF_Group one_F1632280_001.fcs"
# #   )
# # fcsFilesAll =fcsFilesAllProbs




ws <- openWorkspace("/Users/Kitty/temp/fcs/513-520 HRS p1&p2.wsp")
gs <- parseWorkspace(ws, path = "/Volumes/Beta/data/flow/fcs/", name = 1,subset="2016-05-18_PANEL 1_ZF_panel one_F1632164_009.fcs",isNcdf = FALSE)
t3 = ggcyto(gs,
            mapping = aes(x = "FSC-A", y = "SSC-A"),
            subset = "Lymphocytes (SSC-A v FSC-A)") +
  geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()  + xlim(c(0, 2e5)) + ylim(c(0, 2e5))
write.table(
  +     getPopStats(gs),
  +     sep = "\t",
  +     quote = FALSE,
  +     file = "/Volumes/Beta/data/flow/testTypesManual.txt",
  +     row.names = FALSE
  + )

```


gt_lymph = rbind(
  gt_lymph,
  add_pop(
    gs1,
    alias = "*",
    pop = "HLADR+/-",
    parent = "CD4",
    dims =  "HLA-DR",
    gating_method = "tailgate",
    gating_args =
      "tol=5e-2",
    preprocessing_method = "standardize_flowset"
  )
)

gt_lymph = rbind(
  gt_lymph,
  add_pop(
    gs1,
    alias = "*",
    pop = "CD45RA+/-",
    parent = "CD4",
    dims =  "CD45RA",
    gating_method = "mindensity",
    gating_args =
      "gate_range=c(80,150)"
  )
)
gt_lymph = rbind(
  gt_lymph,
  add_pop(
    gs1,
    alias = "CCR7_gate",
    pop = "CCR7",
    parent = "CD45RA+",
    dims =  "CCR7",
    gating_method = "flowClust",
    gating_args = "K=2",
    preprocessing_method = "prior_flowClust",
    preprocessing_args = "K=2,min=0"
  )
)


qcDir = "/Volumes/Beta/data/flow/fcs3Clean/QC"
reviewDir = "/Users/Kitty/git/auto-fcs/explore/openCyto/QC/qcReview"
collectResults <-
  list.files(qcDir,
             pattern = "mini.txt$",
             full = TRUE)
df = data.frame()
for (file in collectResults) {
  tmp = read.delim(file,
                   stringsAsFactors = FALSE)
  
  df = rbind(df, tmp)
}

check = df[which((df$X..anomalies.flow.Rate > 20 |
                    df$X..anomalies.Margins > 6) & df$n..of.events > 10000), ]
copy = paste(check$Name.file, ".fcs", sep = "")
