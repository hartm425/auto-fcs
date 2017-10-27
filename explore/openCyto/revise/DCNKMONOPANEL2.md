file="2017-01-17_PANEL 2_HB_group one_F1635916_010.fcs"
    source(file = "generateFortessa.R")

frame = read.FCS(paste(inputDir, file, sep = ""))

templateMono = "~/git/auto-fcs/explore/openCyto/dc.dev.LSR.c.txt"
templateMonoFortessa =convertP2ToFortessa(templateFile = templateMono, outputDir = outputDir)
gt_monoFortessa <-
  gatingTemplate(templateMonoFortessa, autostart = 1L)

    gateTemplate = gt_monoFortessa
    
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
                mapping = aes(x = "CD3", y = "CD19"),
                subset = "PBMC") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()+geom_stats()
    
 ggcyto(gs1,
                mapping = aes(x = "CD3"),
                subset = "PBMC") +
    geom_histogram() + ggcyto_par_set(limits = "data") + geom_gate()+geom_stats()
       
    
     ggcyto(gs1,
              mapping = aes(x = "CD19"),
              subset = "PBMC") + ggcyto_par_set(limits = "data") + geom_gate()+geom_histogram() 