

library(openCyto)
library(flowCore)
library(data.table)
library(ggcyto)
library(gridExtra)
library(CytoML)
library(flowAI)

option_list = list(
  make_option(c("-g", "--gatingDirectory"), type="character", default=NULL, 
              help="directory, containing subdirectories with wsp files", metavar="character"),
  make_option(c("-i", "--inputFCSDir"), type="character", default="~/fcs/", 
              help="directroy with fcs files", metavar="character"),
  make_option(c("-p1", "--panle1map"), type="character", default="autoManMap.txt", 
              help="map of openCyto gate names to manual gate names", metavar="character")
  
); 

opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);



combineWSP <- function(outputDir, gateDir,inputFCSDir,panle1map) {
  panle1map = read.delim(panle1map,stringsAsFactors = FALSE,sep = "\t") 
  dir =paste(outputDir,gateDir,sep = "")
  wsps = list.files( dir,pattern = "wsp$", recursive = TRUE,full = TRUE)
  print(paste("found",length(wsps),"wsp files in",dir))
  gates1 =list()
  gates2 = list()
  # wsp = wsp[1:5]
  cur = 0
  for(wsp in wsps){
    cur =cur +1
    print(cur)
    # ws <- openWorkspace("/Volumes/Beta/data/flow/gates5/2016-05-05_PANEL 1_HB_panel one_F1631931_006.fcs_panel1.wsp")
    ws <- openWorkspace(wsp)
    gs <-
      parseWorkspace(
        ws,
        #WSP file
        path = inputFCSDir,
        #FCS file
        name = 1,
        # execute = FALSE,
        #sample group
        # subset = eval(fileToLoad),
        #load single fcs file
        isNcdf = TRUE
        # #not memory mapped
        # compensation = comp
      )
    #Have to rename in reverse order, else the h-archy is updated
    renameNodes <- function(gs,map) {
      nodes = rev(getNodes(gs,path="auto")) 
      num =0
      for(node in nodes){
        if(node %in% map$Auto){
          sub =map[which(map$Auto==node),]
          num =num+1
          print(paste(node,"->",sub$Manual," num=",num))
          setNode(gs, node, gsub("/","_",sub$Manual))
        }
        
      }
    }
    
    if(length(grep("panel1",wsp))){
      renameNodes(gs,panle1map)
      gates1 = c(gates1,gs)
    }else{
      gates2 = c(gates2,gs)
    }
  }
  
  
  if(length(gates1)>0){
    outWsp1 = paste(outputDir, "panel1_full.wsp", sep = "")
    GatingSet2flowJo(GatingSetList(gates1),outWsp1 )
    
    p1sed1="sed -i \'\' -e \'s/<GroupNode name=\"All Samples\">/<GroupNode name=\"P1\">/g\'"
    p1sed2 ="sed -i \'\' -e \'s/<Group name=\"All Samples\">/<Group name=\"P1\">/g\'" 
    
    system(paste(p1sed1,outWsp1))
    system(paste(p1sed2,outWsp1))
  }
  
  if(length(gates2)>0){
    
    outWsp2 = paste(outputDir, "panel2_full.wsp", sep = "")
    GatingSet2flowJo(GatingSetList(gates2),outWsp2 )
    p2sed1="sed -i \'\' -e \'s/<GroupNode name=\"All Samples\">/<GroupNode name=\"P1\">/g\'"
    p2sed2 ="sed -i \'\' -e \'s/<Group name=\"All Samples\">/<Group name=\"P1\">/g\'" 
    
    system(paste(p2sed1,outWsp2))
    system(paste(p2sed2,outWsp2))
    
  }
}


if (!is.null(opt$gatingDirectory)) {
  combineWSP(
    outputDir = "",
    gateDir = opt$gatingDirectory,
    inputFCSDir = opt$inputFCSDir,
    panle1map = opt$panle1map
  )
}


