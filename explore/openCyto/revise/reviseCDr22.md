
file="2016-11-29_PANEL 1_HB_group one_F1631006_025.fcs"
file="2016-05-13_PANEL 1_ZF_panel one_F1631922_003.fcs"

file="2017-01-26_PANEL 1_DHS_Group two_F1638623_035.fcs"
file="2016-12-27_PANEL 1_ZF_Group two_F1637410_033.fcs"
file="2016-11-29_PANEL 1_HB_group one_F1631006_025.fcs"
file="2016-05-11_PANEL 1_ZF_panel one_F1632176_004.fcs"
file="2016-05-11_PANEL 1_ZF_panel one_F1631925_005.fcs"
frame = read.FCS(paste(inputDir, file, sep = ""))

gt_lymph <-
    gatingTemplate(templateLymph, autostart = 1L)
    gateTemplate = gt_lymph
    
print(paste("compensating ....", file))
metrics = data.frame()
comp <- compensation(keyword(frame)$`SPILL`)

chnls <- parameters(comp)
tf <- transformerList(chnls, biexpTrans)

print(paste("gating ....", file))
frames = c(frame)
names(frames) = c(basename(file))
fs =  as(frames, "flowSet")
gs1 <- GatingSet(fs)
gs1 <- compensate(gs1, comp)
gs1 <- transform(gs1, tf)

gh <- gs1[[1]]
gating(gateTemplate, gs1)
 ggcyto(gs1,
              mapping = aes(x = "CD4", y = "CD8"),
              subset = "Tcells") +
    geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()+ geom_stats("CD8")
   ggcyto(gs1,
              mapping = aes(x = "CD4", y = "CD8"),
              subset = "CD8") +
    geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()
   ggcyto(gs1,
              mapping = aes(x = "CD4", y = "CD8"),
              subset = "Tcells") +
    geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()+ geom_stats("CD8")