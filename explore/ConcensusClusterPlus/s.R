

metrics = data.frame()
sampleBased = data.frame(row.names = as.character(unique(merge$sample.ID.x)))


for (type in unique(merge$CELLSID.x)) {
  stabGST = stabGS[which(stabGS$CELLSID == type),]
  stabGST = stabGST[, c("sample.ID", "CELLS")]
  stabGST$NORM_CELLS = stabGST$CELLS
  # , color=SAMPLE.TYPE.x?
  data = merge[which(merge$CELLSID.x == type),]
  data = merge(data, stabGST, by.x = "sample.ID.x", by.y = "sample.ID")
  data$L2PBMC = log2(data$CELLS.x / data$NORM_CELLS)
  data$L2PBWB = log2(data$CELLS.y / data$NORM_CELLS)
  
  
  for (tp in unique(data$time.point.x)) {
    current = data[which(data$time.point.x == tp),]
    sampleTmp = data.frame(DATA1 = current$CELLS.x, DATA2 = current$CELLS.y)
    colnames(sampleTmp) = c(paste("PBMC", current$KEY2.x[1]),
                            paste("WB", current$KEY2.x[1]))
    row.names(sampleTmp) = current$sample.ID.x
    if (length(current$sample.ID.x) == length(as.character(unique(merge$sample.ID.x)))) {
      sampleBased = cbind(sampleBased, sampleTmp)
    }
    
    tmp = data.frame(
      TIME = as.numeric(tp),
      TYPE = type,
      L2PBMC_MED = median(current$L2PBMC, na.rm = TRUE),
      SD_L2PBMC = mad(current$L2PBMC, na.rm = TRUE),
      L2PBWB_MED = median(current$L2PBWB, na.rm = TRUE),
      SD_L2PBWB = mad(current$L2PBWB, na.rm = TRUE)
      
    )
    metrics  = rbind(metrics, tmp)
  }
}

k = 10
iter = 2000

title = paste("test_sampleClust_transposeK", k, "iter", iter, sep = "")
results = ConsensusClusterPlus(
  t(as.matrix(sampleBased)),
  maxK = k,
  reps = iter,
  pItem = 0.8,
  pFeature = 1,
  title = title,
  clusterAlg = "hc",
  distance = "spearman",
  seed = 1262118388.71279,
  plot = "pdf",
  corUse = "pairwise.complete.obs"
)
title = paste("test_CellClustK", k, "iter", iter, sep = "")
results = ConsensusClusterPlus(
  as.matrix(sampleBased),
  maxK = k,
  reps = iter,
  pItem = 0.8,
  pFeature = 1,
  title = title,
  clusterAlg = "hc",
  distance = "spearman",
  seed = 1262118388.71279,
  plot = "pdf",
  corUse = "pairwise.complete.obs"
)

write.table(sampleBased , file = "data.txt", sep = "\t")
