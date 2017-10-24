file="2017-01-26_PANEL 1_DHS_Group two_F1638715_037.fcs"
file="2017-01-19_PANEL 1_HB_group one_F1635866_023.fcs"

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
       mapping = aes(x = "PE-A"),
       subset = "Singlets") + ggcyto_par_set(limits = "data") + geom_gate()+ geom_histogram(bins = 300) 


ggcyto(gs1,
              mapping = aes(x = "PE-A", y = "FSC-H"),
              subset = "Singlets") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
  
              
             ggcyto(gs1,
              mapping = aes(x = "PE-A"),
              subset = "Singlets") + ggcyto_par_set(limits = "data") + geom_gate()+ geom_histogram() 
 