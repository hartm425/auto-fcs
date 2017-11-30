
file="2017-02-13_PANEL 1_ZF_group one_F1652540_019.fcs"

file="2017-02-28_PANEL 1_RR_group one_F1638804_022.fcs"
file="2017-02-30_PANEL 1_LSR_RR_Group one_F1634154_002.fcs"
file="2017-03-06_PANEL 1_LSR_ZF_Group one_F1652967_001.fcs"
file="2017-02-27_PANEL 1_DHS_group one_F1653150_021.fcs"

file="2016-05-05_PANEL 1_HB_panel one_F1631959_005.fcs"
file="2016-05-12_PANEL 1_HB_panel one_F1632220_007.fcs"
file="2017-03-02_PANEL 1_FORTESSA_HB_group two_F1635738_024.fcs"
file="2017-02-30_PANEL 1_LSR_RR_Group one_F1642545_006.fcs"


probSamps
file="2016-05-26_PANEL 1_ZF_panel one_F1636717_006.fcs"
file="2016-08-30_PANEL 1_DHS_Group two_F1636884_031.fcs"
file="2016-11-28_PANEL 1_DHS_Group one_F1635646_003.fcs"

frame = read.FCS(paste(inputDir, file, sep = ""))

templateLymph = "~/git/auto-fcs/explore/openCyto/lymph.dev.LSR.f.txt"


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
              mapping = aes(x = "CD4", y = "CD8"),
              subset = "CD8") +
    geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()
    
    ggcyto(gs1,
       mapping = aes(x = "CD4"),
       subset = "CD4-") + ggcyto_par_set(limits = "data") + geom_histogram(bins = 300) 
       ggcyto(gs1,
       mapping = aes(x = "CD4"),
       subset = "Tcells") + ggcyto_par_set(limits = "data") + geom_histogram(bins = 300)  +geom_gate("CD4+")  
  
  ggcyto(gs1,
       mapping = aes(x = "CD3", y = "CD19"),
       subset = "PE-A-") +
    geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()
    geom_histogram(bins = 300) 
      
 
 
 empty <- ggplot()+geom_point(aes(1,1), colour="white")+
         theme(axis.ticks=element_blank(), 
               panel.background=element_blank(), 
               axis.text.x=element_blank(), axis.text.y=element_blank(),           
               axis.title.x=element_blank(), axis.title.y=element_blank())      
scatter =   ggcyto(gs1,
              mapping = aes(x = "CD4", y = "CD8"),
              subset = "Tcells") +
    geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()+ geom_stats("CD8")
   
    
hist_top =   ggcyto(gs1,
       mapping = aes(x = "CD4"),
       subset = "Tcells") + ggcyto_par_set(limits = "data") + geom_histogram(bins = 300)   
       hist_right =   ggcyto(gs1,
       mapping = aes(x = "CD8"),
       subset = "Tcells") + ggcyto_par_set(limits = "data") + geom_histogram(bins = 300)
    
grid.arrange(as.ggplot(hist_top), empty, as.ggplot(scatter) + theme(legend.position="none"), as.ggplot(hist_right)+coord_flip(), ncol=2, nrow=2, widths=c(4, 1), heights=c(1, 4))





 empty <- ggplot()+geom_point(aes(1,1), colour="white")+
         theme(axis.ticks=element_blank(), 
               panel.background=element_blank(), 
               axis.text.x=element_blank(), axis.text.y=element_blank(),           
               axis.title.x=element_blank(), axis.title.y=element_blank())      
scatter =   ggcyto(gs1,
              mapping = aes(x = "CD4", y = "CD8"),
              subset = "CD8CTOne") +
    geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()
   
    
hist_top =   ggcyto(gs1,
       mapping = aes(x = "CD4"),
       subset = "CD8CTOne") + ggcyto_par_set(limits = "data") + geom_histogram(bins = 300)   
       hist_right =   ggcyto(gs1,
       mapping = aes(x = "CD8"),
       subset = "CD8CTOne") + ggcyto_par_set(limits = "data") + geom_histogram(bins = 300)
    
grid.arrange(as.ggplot(hist_top), empty, as.ggplot(scatter) + theme(legend.position="none"), as.ggplot(hist_right)+coord_flip(), ncol=2, nrow=2, widths=c(4, 1), heights=c(1, 4))
    
   
    
    
    