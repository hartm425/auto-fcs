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
    geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()+ geom_stats("CD4")


ggcyto(gs1,
       mapping = aes(x = "CD4", y = "CD8"),
       subset = "Tcells") +
    geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()+ geom_stats("CD8")