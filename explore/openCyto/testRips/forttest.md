source(file = "generateFortessa.R")

templateLymphFortessa = convertP1ToFortessa(templateFile = templateLymph, outputDir = outputDir)
gt_lymphFortessa <-
  gatingTemplate(templateLymphFortessa, autostart = 1L)


file="2017-03-01_PANEL 1_FORTESSA_HB_group two_Ctl-D_032.fcs"
frame = read.FCS(paste(inputDir, file, sep = ""))
gateTemplate=gt_lymphFortessa

 metrics = data.frame()
    comp <- compensation(keyword(frame)$`SPILL`)
    
    chnls <- parameters(comp)
    tf <- transformerList(chnls, biexpTrans)
    
    print(paste("gating ....", file))
    # gs <- GatingSet(c(new_frame))
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
              subset = "PE-A-") +
    geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()