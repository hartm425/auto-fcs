
file="2017-02-28_PANEL 1_RR_group one_F1638804_022.fcs"
file="2017-02-30_PANEL 1_LSR_RR_Group one_F1634154_002.fcs"

file="2017-02-03_PANEL 1_HB_group one_F1635792_023.fcs"
file="2016-12-09_PANEL 1_HB_group one_F1652236_017.fcs"
file="2017-03-20_PANEL 1_FORTESSA_HB_group one_F1637970_014.fcs"
file="2016-06-07_PANEL 1_DHS_Group one_F1632269_008.fcs"
strange Bcells
file="2016-11-14_PANEL 1_DHS_Group one_F1652417_010.fcs"
file="2017-01-30_PANEL 1_DHS_Group two_F1635796_038.fcs"

file="2016-05-05_PANEL 1_HB_panel one_F1631961_003.fcs"


frame = read.FCS(paste(inputDir, file, sep = ""))

templateLymph = "~/git/auto-fcs/explore/openCyto/lymph.dev.LSR.f.txt"
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
              mapping = aes(x = "FSC-A", y = "SSC-A"),
              subset = "nonDebris") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()  + xlim(c(0, 2e5)) + ylim(c(0, 2e5))