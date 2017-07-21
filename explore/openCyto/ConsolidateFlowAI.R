
library(optparse)
option_list = list(
  make_option(c("-i", "--inputDir"), type="character", default=NULL, 
              help="directory, containing subdirectories with qc files", metavar="character")
  
); 

opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);


consolidateFlowAI <- function(inputDir) {
  qcFiles = list.files(path = inputDir,pattern = ".mini.txt$",recursive = TRUE)
  consolidate = data.frame()
  for(file in qcFiles){
    tmp = read.delim(file =file,header = TRUE,sep = "\t",stringsAsFactors = FALSE)
    consolidate = rbind(consolidate,tmp)
  }
  write.table(
    consolidate,
    sep = "\t",
    quote = FALSE,
    file = paste(inputDir, "all.metrics.qc.txt", sep = ""),
    row.names = FALSE
  )
  
}
if(!is.null(opt$inputDir)){
  consolidateFlowAI(inputDir = opt$inputDir)
}
