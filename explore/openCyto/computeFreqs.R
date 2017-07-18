











mets =  "/Volumes/Beta/data/flow/concordance/results_r6/all.metrics.txt"
p1map = "/Users/Kitty/git/auto-fcs/explore/openCyto/panel1Map.txt"
p2map = "/Users/Kitty/git/auto-fcs/explore/openCyto/panel2Map.txt"
outputDir = "/Volumes/Beta/data/flow/concordance/results_r6/"

computFreqs <- function(metsD, map, panel, basePop, QC) {
  metsAuto = metsD[which(
    metsD$GATE == "AUTOMATIC" &
      metsD$QC == QC &
      (metsD$Population %in% map$Auto |
         metsD$Parent == "root") & metsD$METRIC == "count"
    & metsD$Panel == panel
  ), ]
  metsAuto = merge(metsAuto,
                   map,
                   by.x = "Population",
                   by.y = "Auto",
                   all.x = TRUE)
  
  metsAuto$Merge = paste(metsAuto$Population, metsAuto$name, sep = "_")
  row.names(metsAuto) = metsAuto$Merge
  
  num = 0
  for (sample in unique(metsAuto$name)) {
    current = metsAuto[which(metsAuto$name == sample), ]
    num = num + 1
    # print(paste(sample, num))
    for (pop in unique(map$Auto)) {
      # print(pop)
      # print(paste(pop, sample, num))
      row = paste(pop, sample, sep = "_")
      sub = current[which(current$Population == pop &
                            current$name == sample), ]
      realParentCount = current[which(current$Population == sub$RealAutoParent &
                                        current$name == sample), ]$Count
      baseCount = current[which(current$Population == basePop &
                                  current$name == sample), ]$Count
      metsAuto[row, paste("freq_", basePop, sep = "")] = sub$Count / baseCount
      
      if (sub$RealAutoParent != "root") {
        metsAuto[row, "freqParent"] = sub$Count / realParentCount
      } else{
        realParentCount = current[which(current$Parent == sub$RealAutoParent &
                                          current$name == sample), ]$ParentCount
        metsAuto[row, "freqParent"] = sub$Count / realParentCount
        
      }
    }
  }
  return(metsAuto)
}

compute <- function(mets, p1map, p2map, outputDir) {
  metsD  = read.delim(mets, stringsAsFactors = FALSE, sep = "\t")
  p1mapD = read.delim(p1map, stringsAsFactors = FALSE, sep = "\t")
  p2mapD = read.delim(p2map, stringsAsFactors = FALSE, sep = "\t")
  
  
  panels = c("panel1", "panel2")
  basePops = c("lymph", "PBMC")
  QC = c("FALSE", "TRUE")
  
  fullMets = data.frame()
  outfile = paste(outputDir, "freq.metrics.txt", sep = "")
  
  panelNum = 1
  for (panel in panels) {
    basePop = basePops[panelNum]
    for (q in QC) {
      print(paste(panel,"QC",q))
      if (panel == "panel1") {
        tmp = computFreqs(
          metsD = metsD,
          map = p1mapD,
          panel = panel,
          basePop = basePop,
          QC = q
        )
        fullMets = rbind(fullMets, tmp)
        
      } else{
        tmp = computFreqs(
          metsD = metsD,
          map = p2mapD,
          panel = panel,
          basePop = basePop,
          QC = q
        )
        fullMets = rbind(fullMets, tmp)
      }
    }
    panelNum = panelNum + 1
  }
  
  write.table(
    fullMets,
    sep = "\t",
    quote = FALSE,
    file = outfile,
    row.names = FALSE
  )
}
#
compute(mets = mets ,
        p1map = p1map,
        p2map = p2map,outputDir = outputDir)
