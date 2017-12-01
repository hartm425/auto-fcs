
file="2016-08-04_PANEL 1_ZF_Group one_F1636831_001.fcs"
file="2016-08-17_PANEL 1_ZF_Group two_F1631183_030.fcs"
file="2017-03-07_PANEL 1_FORTESSA_DHS_group one_F1634020_019.fcs"


file="2017-03-01_PANEL 1_FORTESSA_HB_group two_F1638810_031.fcs"
file="2017-03-28_PANEL 1_FORTESSA_DHS_group two_F1638054_033.fcs"
file="2017-03-14_PANEL 1_FORTESSA_DHS_group two_F1635729_043.fcs"
file="2017-07-28_PANEL 1_LSR_HB_Group two_HB_F1632655_023.fcs"

templateLymph = "~/git/auto-fcs/explore/openCyto/lymph.dev.LSR.f.txt"
  template = read.delim(templateLymph, stringsAsFactors = FALSE)

source(file = "CombineWSP.R")
source(file = "computeFreqs.R")
source(file = "machineType.R")
source(file = "generateFortessa.R")
spliceFile = "TBSpliceFortessa.txt"

if(getMachineType(frame)=="FORTESSA"){
templateLymphFortessa = convertP1ToFortessa(templateFile = templateLymph, outputDir = outputDir,spliceFile = spliceFile)

gt_lymph <-
  gatingTemplate(templateLymphFortessa, autostart = 1L)
  print(getMachineType(frame))
}else{
gt_lymph <-
    gatingTemplate(templateLymph, autostart = 1L)
}

frame = read.FCS(paste(inputDir, file, sep = ""))

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
    
    