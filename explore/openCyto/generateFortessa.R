




convertP1ToFortessa <- function(templateFile, outputDir) {
  outFile = paste0(outputDir, basename(gsub("LSR", "FORTESSA", templateFile)))
  template = read.delim(templateFile, stringsAsFactors = FALSE)
  template = converTCellGate(template = template)
  write.table(
    x = template,
    file = outFile,
    row.names = FALSE,
    quote = FALSE,
    sep = "\t"
  )
  return(outFile)
}

converTCellGate  <- function(template) {
  template[which(template$pop == "CD3+/-"), c("gating_args")] = "gate_range=c(120,185)"
  template[which(template$pop == "CD19+/-"), c("gating_args")] = "gate_range=c(100,155),adjust=1.5"
  return(template)
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