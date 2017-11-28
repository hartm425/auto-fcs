file="2016-05-10_PANEL 1_HB_panel one_F1632228_009.fcs"

file="2016-06-07_PANEL 2_DHS_Group one_F1632043_002.fcs"

    source(file = "generateFortessa.R")

frame = read.FCS(paste(inputDir, file, sep = ""))

templateMono = "~/git/auto-fcs/explore/openCyto/dc.dev.LSR.c.txt"
if(getMachineType(frame)=="FORTESSA"){
templateMonoFortessa =convertP2ToFortessa(templateFile = templateMono, outputDir = outputDir)

gt_mono <-
  gatingTemplate(templateMonoFortessa, autostart = 1L)
}else{
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
              mapping = aes(x = "FSC-A", y = "SSC-A"),
              subset = "Singlets") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()

ggcyto(gs1,
              mapping = aes(x = "FSC-A", y = "SSC-A"),
              subset = "nonDebris") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
    
 print(getMachineType(frame))
 