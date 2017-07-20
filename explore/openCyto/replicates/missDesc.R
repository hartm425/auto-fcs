library(openCyto)
library(flowCore)
library(data.table)
library(ggcyto)
library(gridExtra)
library(CytoML)
library(flowAI)

getPanel <-
  function(frame) {
    t = pData(parameters(frame))
    p1Key = "CCR7"
    p2Key = "CD45"
    if (p1Key %in% t$desc) {
      return("panel1")
    } else if (p2Key %in% t$desc) {
      return("panel2")
    } else{
      return("panel_undetermined")
    }
  }

inputDir = "/scratch.global/lanej/flow/full/fcs/"
outputDIr = "/scratch.global/lanej/flow/full/failReview/"
fcsFilesAll <-
  list.files(inputDir,
             pattern = ".fcs",
             full = FALSE)

counts = data.frame(
  FILE = character(),
  TOTAL_COUNTS = integer(),
  QC = character(),
  PANEL = character(),
  DESC = character()
)
num = 0

for (file in fcsFilesAll) {
  frame = read.FCS(paste(inputDir, file, sep = ""))
  panel = getPanel(frame)
  countCurrent = length(exprs(frame)[, "FSC-H"])
  desc = paste(unique(pData(parameters(frame))$desc), collapse = ";")
  tmpCount = data.frame(
    FILE = file,
    TOTAL_COUNTS = countCurrent,
    QC = "FALSE",
    PANEL = panel,
    DESC = desc
  )
  counts = rbind(counts, tmpCount)
  num = num + 1
  print(paste(file, num, countCurrent, panel, desc))
  
}

write.table(
  counts,
  sep = "\t",
  quote = FALSE,
  file = paste(outputDir, "metrics.totalCellCounts.txt", sep = ""),
  row.names = FALSE
)