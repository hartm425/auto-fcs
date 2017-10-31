


nameAndDump <- function(file, fileBim, fileOut, fileFrq) {
  dat = read.delim(file = file,
                   stringsAsFactors = FALSE,
                   header = FALSE)
  colnames(dat) = bim$V2
  rownames(dat) = bim$V2
  bim = read.delim(
    file = fileBim,
    stringsAsFactors = FALSE,
    header = FALSE,
    sep = "\t"
  )
  frq = read.delim(
    file = fileFrq,
    stringsAsFactors = FALSE,
    header = TRUE,
    sep = ""
  )
  row.names(frq) = frq$SNP
  dat = cbind(frq, dat)
  
  
  
  write.table(
    dat,
    sep = "\t",
    quote = FALSE,
    file = fileOut,
    col.names = TRUE,
    row.names = FALSE
  )
}


fileReg = "/Volumes/Beta/data/Cushings/targetedDEXAI_LD/plinkFiltr2.ld.gz"
fileRegFrq = "/Volumes/Beta/data/Cushings/targetedDEXAI_LD/plinkFiltr2.frq"
fileBimReg = "/Volumes/Beta/data/Cushings/targetedDEXAI_LD/plinkFilt.bim"
fileRegOut = "/Volumes/Beta/data/Cushings/targetedDEXAI_LD/plinkFiltr2.ld.names.txt"

nameAndDump(
  file = fileReg,
  fileBim = fileBimReg,
  fileOut = fileRegOut,
  fileFrq = fileRegFrq
)


fileGQ = "/Volumes/Beta/data/Cushings/targetedDEXAI_LD/plinkFiltGQ20r2.ld.gz"
fileFrqGQ = "/Volumes/Beta/data/Cushings/targetedDEXAI_LD/plinkFiltGQ20r2.frq"
fileBimGQ = "/Volumes/Beta/data/Cushings/targetedDEXAI_LD/plinkFiltGQ20.bim"
fileRegGQ = "/Volumes/Beta/data/Cushings/targetedDEXAI_LD/plinkFiltGQ20r2.ld.names.txt"

nameAndDump(
  file = fileGQ,
  fileBim = fileBimGQ,
  fileOut = fileRegGQ,
  fileFrq = fileFrqGQ
)
