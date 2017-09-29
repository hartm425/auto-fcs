file="2017-01-12_PANEL 1_HB_group two_F1652546_029.fcs"
file="2016-09-19_PANEL 1_DHS_Group two_F1637204_031.fcs"
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
              mapping = aes(x = "CCR7", y = "CD45RA"),
              subset = "CD4") + geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()+geom_stats()
              
 