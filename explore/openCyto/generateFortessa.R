




convertP1ToFortessa <- function(templateFile, outputDir,spliceFile) {
  outFile = paste0(outputDir, basename(gsub("LSR", "FORTESSA", templateFile)))
  template = read.delim(templateFile, stringsAsFactors = FALSE)
  template[which(template$pop == "boundary"), c("gating_args")] = "min=c(5e4,0),max=c(2.5e5,1.25e5)"
  
  templateSplice = read.delim(spliceFile, stringsAsFactors = FALSE)
  
  top =grep("PE-A-",template$alias)
  templateTop =template[c(1:grep("PE-A-",template$alias)),]
  
  templateBot =template[c(grep("CD27gate",template$alias):length(rownames(template))),]

  template =rbind(templateTop,templateSplice)
  template =rbind(template,templateBot)
  
  write.table(
    x = template,
    file = outFile,
    row.names = FALSE,
    quote = FALSE,
    sep = "\t"
  )
  return(outFile)
}

convertP2ToFortessa <- function(templateFile, outputDir) {
  outFile = paste0(outputDir, basename(gsub("LSR", "FORTESSA", templateFile)))
  template = read.delim(templateFile, stringsAsFactors = FALSE)
  # p2 might not need CD3 cut  
  template[which(template$pop == "CD19+/-"), c("gating_args")] = "gate_range=c(100,155),adjust=1.5"
  write.table(
    x = template,
    file = outFile,
    row.names = FALSE,
    quote = FALSE,
    sep = "\t"
  )
  return(outFile)
}