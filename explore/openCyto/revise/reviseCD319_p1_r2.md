file="2016-11-14_PANEL 1_DHS_Group two_F1636413_042.fcs"
file="2017-1-03_PANEL 1_DHS_Group one_F1635942_002.fcs"
file="2016-05-24_PANEL 1_DHS_panel one_F1636748_013.fcs"
file="2016-05-24_PANEL 1_DHS_panel one_F1632188_001.fcs"
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
       mapping = aes(x = "CD19"),
       subset = "CD3+") + ggcyto_par_set(limits = "data") + geom_gate()+ geom_histogram(bins = 300) 
ggcyto(gs1,
       mapping = aes(x = "CD3", y = "CD19"),
       subset = "PE-A-") +
    geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()
 

