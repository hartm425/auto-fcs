metrics = data.frame()
sampleBased = data.frame(SAMPLE = as.character(unique(merge$sample.ID.x)))
row.names(sampleBased) = unique(merge$sample.ID.x)
sampleBased2 = data.frame(SAMPLE = unique(merge$sample.ID.x))
test = cbind(sampleBased, sampleBased2)
for (type in unique(merge$CELLSID.x)) {
  stabGST = stabGS[which(stabGS$CELLSID == type), ]
  stabGST = stabGST[, c("sample.ID", "CELLS")]
  stabGST$NORM_CELLS = stabGST$CELLS
  # , color=SAMPLE.TYPE.x?
  data = merge[which(merge$CELLSID.x == type), ]
  data = merge(data, stabGST, by.x = "sample.ID.x", by.y = "sample.ID")
  data$L2PBMC = log2(data$CELLS.x / data$NORM_CELLS)
  data$L2PBWB = log2(data$CELLS.y / data$NORM_CELLS)
  
  
  for (tp in unique(data$time.point.x)) {
    current = data[which(data$time.point.x == tp), ]
    sampleTmp = data.frame(SAMPLE = current$sample.ID.x, DATA = current$CELLS.x)
    colnames(sampleTmp) = c("SAMPLE", current$KEY2)
    sampleBased = cbind(sampleBased, sampleTmp)
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
