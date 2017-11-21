
file="2016-08-04_PANEL 1_ZF_Group one_F1636831_001.fcs"
file="2016-08-17_PANEL 1_ZF_Group two_F1631183_030.fcs"

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
                   mapping = aes(x = "IgD", y = "CD27"),
                   subset = "Bcells") +
    geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()