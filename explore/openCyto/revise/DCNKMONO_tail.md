file="2017-01-23_PANEL 2_DHS_Group one_F1636334_010.fcs"
file="2016-05-11_PANEL 2_ZF_panel 2_F1631920_007.fcs"
file="2016-11-30_PANEL 2_DHS_ZF_Group one_DHS_F1635889_001.fcs"
    source(file = "generateFortessa.R")

frame = read.FCS(paste(inputDir, file, sep = ""))

templateMono = "~/git/auto-fcs/explore/openCyto/dc.dev.LSR.c.txt"
if(getMachineType(frame)=="FORTESSA"){
templateMonoFortessa =convertP2ToFortessa(templateFile = templateMono, outputDir = outputDir)

gt_mono <-
  gatingTemplate(templateMonoFortessa, autostart = 1L)
}
else{
gt_mono <-
  gatingTemplate(templateMono, autostart = 1L)
}
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
                mapping = aes(x = "CD3", y = "CD19"),
                subset = "PBMC") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
 
 print(getMachineType(frame))
 