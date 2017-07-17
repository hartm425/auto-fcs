





mets =  "/Volumes/Beta/data/flow/concordance/all.metrics.txt"
p1map = "/Users/Kitty/git/auto-fcs/explore/openCyto/panel1Map.txt"
p2map = "/Users/Kitty/git/auto-fcs/explore/openCyto/panel2Map.txt"

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
  
  num =0
  for (pop in unique(map$Auto)) {
    print(pop)
    for (sample in unique(metsAuto$name)) {
      num=num+1
      print(paste(pop,sample,num))
      row = paste(pop, sample, sep = "_")
      sub = metsAuto[which(metsAuto$Population == pop &
                             metsAuto$name == sample), ]
      realParentCount = metsAuto[which(metsAuto$Population == sub$RealAutoParent &
                                         metsAuto$name == sample), ]$Count
      parentCount = metsAuto[which(metsAuto$Population == basePop &
                                    metsAuto$name == sample), ]$Count
      metsAuto[row, paste("freq_", basePop, sep = "")] = sub$Count / parentCount
      
      if (sub$RealAutoParent != "root") {
        metsAuto[row, "freqParent"] = sub$Count / realParentCount
      } else{
        realParentCount = metsAuto[which(metsAuto$Parent == sub$RealAutoParent &
                                           metsAuto$name == sample), ]$ParentCount
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
  
  
  panel = "panel1"
  basePop = "lymph"
  QC = "FALSE"
  
  p1Mets = computFreqs(
    metsD = metsD,
    map = p1mapD,
    panel = panel,
    basePop = basePop,
    QC = QC
  )
  print(p1Mets)
  
}

compute(mets = mets ,
        p1map = p1map,
        p2map = p2map)
