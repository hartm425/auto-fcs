



convertP1ToFortessa <- function(templateFile, outputDir) {
  outFile = paste0(outputDir, basename(gsub("LSR", "FORTESSA", templateFile)))
  template = read.delim(templateFile, stringsAsFactors = FALSE)
  # template[which(template$alias == "lymph"), c("gating_args")] =
  template[which(template$pop == "CD3+/-"), c("gating_args")] ="gate_range=c(140,185)"
  # template[which(template$pop == "CD19+/-"), c("gating_args")] ="gate_range=c(120,200),adjust=1.5"
  
    write.table(
      x = template,
      file = outFile,
      row.names = FALSE,
      quote = FALSE,
      sep = "\t"
    )
  return(outFile)
}