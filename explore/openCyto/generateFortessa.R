



convertP1ToFortessa <- function(templateFile, outputDir) {
  outFile = paste0(outputDir, basename(gsub("LSR", "FORTESSA", templateFile)))
  template = read.delim(templateFile, stringsAsFactors = FALSE)
  # template[which(template$alias == "lymph"), c("gating_args")] =
    
    write.table(
      x = template,
      file = outFile,
      row.names = FALSE,
      quote = FALSE,
      sep = "\t"
    )
  return(outFile)
}