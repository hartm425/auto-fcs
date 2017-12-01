
file="2016-05-24_PANEL 1_DHS_panel one_F1632188_001.fcs"
file="2016-05-24_PANEL 1_DHS_panel one_F1636748_013.fcs"
file="2016-11-14_PANEL 1_DHS_Group two_F1636568_039.fcs"


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
              mapping = aes(x = "FSC-A", y = "SSC-A"),
              subset = "root") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()  + xlim(c(0, 2e5)) + ylim(c(0, 2e5))
 ggcyto(gs1,
              mapping = aes(x = "FSC-A", y = "SSC-A"),
              subset = "nonDebris") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()  + xlim(c(0, 2e5)) + ylim(c(0, 2e5))
  # + scale_x_flowJo_biexp()+ scale_y_flowJo_biexp()
       
 
 
 empty <- ggplot()+geom_point(aes(1,1), colour="white")+
         theme(axis.ticks=element_blank(), 
               panel.background=element_blank(), 
               axis.text.x=element_blank(), axis.text.y=element_blank(),           
               axis.title.x=element_blank(), axis.title.y=element_blank())      
scatter =   ggcyto(gs1,
              mapping = aes(x = "CD3", y = "CD19"),
              subset = "PE-A-") +
    geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()+ geom_stats("Tcells")
   
    
hist_top =   ggcyto(gs1,
       mapping = aes(x = "CD3"),
       subset = "PE-A-") + ggcyto_par_set(limits = "data") + geom_histogram(bins = 300)   
       hist_right =   ggcyto(gs1,
       mapping = aes(x = "CD19"),
       subset = "PE-A-") + ggcyto_par_set(limits = "data") + geom_histogram(bins = 300)
    
grid.arrange(as.ggplot(hist_top), empty, as.ggplot(scatter) + theme(legend.position="none"), as.ggplot(hist_right)+coord_flip(), ncol=2, nrow=2, widths=c(4, 1), heights=c(1, 4))

    
    
    