file="2017-01-17_PANEL 2_HB_group one_F1635916_010.fcs"
file="2016-12-30_PANEL 2_HB_group two_F1636018_024.fcs"
file="2016-11-14_PANEL 2_DHS_Group two_F1636413_038.fcs"

    source(file = "generateFortessa.R")

frame = read.FCS(paste(inputDir, file, sep = ""))

templateMono = "~/git/auto-fcs/explore/openCyto/dc.dev.LSR.c.txt"

gt_mono <-
  gatingTemplate(templateMono, autostart = 1L)

    gateTemplate = gt_mono
    
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
       mapping = aes(x = "HLA-DR"),
       subset = "CD20-") + ggcyto_par_set(limits = "data") + geom_gate("HLA-DR+")+ geom_histogram(bins = 300) 
ggcyto(gs1,
               mapping = aes(x = "CD20", y = "HLA-DR"),
               subset = "HLA-DR+") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()       
       
ggcyto(gs1,
               mapping = aes(x = "CD20", y = "HLA-DR"),
               subset = "CD20-") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()       
