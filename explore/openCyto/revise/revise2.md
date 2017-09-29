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
              mapping = aes(x = "FSC-W", y = "FSC-H"),
              subset = "PE-A") +
    geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()+geom_stats()
    
    ggcyto(gs1,
              mapping = aes(x = "FSC-W", y = "FSC-H"),
              subset = "Singlets") +
    geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()+geom_stats("Singlets")
    Singlets
   