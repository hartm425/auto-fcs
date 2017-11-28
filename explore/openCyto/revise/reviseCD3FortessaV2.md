file="2017-03-01_PANEL 1_FORTESSA_HB_group two_Ctl-D_032.fcs"    
file="2017-01-05_PANEL 1_ZF_Group one_F1636254_024.fcs"
file="2017-01-24_PANEL 1_ZF_group one_F1638554_028.fcs"
file="2017-03-03_PANEL 1_FORTESSA_ZF_group two_F1634221_033.fcs"
file="2017-03-01_PANEL 1_FORTESSA_HB_group one_F1638418_023.fcs"
file="2017-03-02_PANEL 1_FORTESSA_HB_group two_ZF_F1634018_036.fcs"
file="2017-02-21_PANEL 1_DHS_group two_F1635759_033.fcs"
file="2017-02-17_PANEL 1_ZF_group two_F1635741_026.fcs"
file="2017-02-27_PANEL 1_DHS_group one_F1653141_026.fcs"

    frame = read.FCS(paste(inputDir, file, sep = ""))

    source(file = "generateFortessa.R")
spliceFile = "TBSpliceFortessa.txt"

    templateLymph = "~/git/auto-fcs/explore/openCyto/lymph.dev.LSR.f.txt"
templateLymphFortessa = convertP1ToFortessa(templateFile = templateLymph, outputDir = outputDir,spliceFile = spliceFile)

    gt_lymphFortessa <-
  gatingTemplate(templateLymphFortessa, autostart = 1L)
    gateTemplate = gt_lymphFortessa
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
       mapping = aes(x = "CD3"),
       subset = "Bcells") + ggcyto_par_set(limits = "data") + geom_histogram(bins = 300) 
       
 ggcyto(gs1,
              mapping = aes(x = "CD3", y = "CD19"),
              subset = "PE-A-") +
    geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()+ geom_stats("Bcells")
    