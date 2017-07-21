
library(optparse)
option_list = list(
  make_option(c("-i", "--inputDir"), type="character", default=NULL, 
              help="directory, containing subdirectories with qc files", metavar="character")
  
); 

opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);


consolidateFlowAI <- function(inputDir) {
  
  print("HI")
}
if(!is.null(opt$inputDir)){
  consolidateFlowAI(inputDir = opt$inputDir)
}
