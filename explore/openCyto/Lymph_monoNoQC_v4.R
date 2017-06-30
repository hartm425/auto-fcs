library(openCyto)
library(flowCore)
library(data.table)
library(ggcyto)
library(gridExtra)
library(CytoML)
library(flowAI)

# source("https://bioconductor.org/biocLite.R")
# biocLite("openCyto")
# biocLite("flowCore")
# biocLite("data.table")
# biocLite("ggcyto")
# biocLite("gridExtra")
# biocLite("CytoML")
# biocLite("flowAI")




.flowDensity <- function(fr, pp_res, channels = NA, ...) {
  if (length(channels) == 2)
    flowDensity:::.flowDensity.2d(fr, channels = channels, ...)
  else
    flowDensity:::.flowDensity.1d(fr, channel = channels, ...)
  
}

registerPlugins(fun = .flowDensity,
                methodName = "flowDensity",
                dep = "flowDensity",
                "gating")


panle1mapFile ="/Users/Kitty/git/auto-fcs/explore/openCyto/autoManMap3.txt"
setwd(dirname(panle1mapFile))
inputDir = "/Volumes/Beta/data/flow/fcs3/"
# cleanDir = "/Volumes/Beta/data/flow/fcs3Clean/"
# setwd(cleanDir)
outputDir = "/Volumes/Beta/data/flow/"
templateLymph = "~/git/auto-fcs/explore/openCyto/lymph.dev.e.csv"
# templateQC = "~/git/auto-fcs/explore/openCyto/lymph.dev.qc.b.csv"

templateMono = "~/git/auto-fcs/explore/openCyto/dc.dev.a.csv"
mapperFile = "/Volumes/Beta/data/flow/fcsMap.txt"

gateDir = "gates/"
# gateQCDir = "gatesQC5/"
mapper = read.delim(
  mapperFile,
  stringsAsFactors = FALSE,
  sep = "\t"
)

theme_set(theme_bw(5))
gt_lymph <-
  gatingTemplate(templateLymph, autostart = 1L)
gt_mono <-
  gatingTemplate(templateMono, autostart = 1L)

# gt_lymphQC <-
#   gatingTemplate(templateQC, autostart = 1L)
fcsFilesAll <-
  list.files(inputDir,
             pattern = ".fcs",
             full = FALSE)
# fcsFilesAll =fcsFilesAll[8:9]
# fcsFilesAll =fcsFilesAll[307:309]

fcsFilesAllProbs = c("NONE")



# only use files with gates available
# fcsFilesAll = fcsFilesAll[fcsFilesAll %in% mapper$FCS]
# print(length(fcsFilesAll))

REPLACE_FOR_NEW_FILES = ""

fcsFilesAll = split(fcsFilesAll, ceiling(seq_along(fcsFilesAll) / 15))

getStats <- function(gs1, qcVersion, metric, gate) {
  autoStats = getPopStats(gs1, statistic = metric)
  autoStats$METRIC = metric
  autoStats$GATE = gate
  autoStats$QC = qcVersion
  return(autoStats)
}

biexpTrans <-
  flowJo_biexp_trans(
    channelRange = 256,
    maxValue = 262144.0000291775 ,
    pos = 4.418539922,
    neg = 0,
    widthBasis = -100
  )
# Panel 1 frame
compP1Frame <-
  function(frame,
           file,
           gt_lymph,
           d,
           outputDir,
           gateDir,
           qcVersion,
           mapper,
           inputFCSDir,
           panle1map) {
    print(paste("compensating ....", file))
    metrics = data.frame()
    comp <- compensation(keyword(frame)$`SPILL`)
    
    chnls <- parameters(comp)
    tf <- transformerList(chnls, biexpTrans)
    
    print(paste("gating ....", file))
    # gs <- GatingSet(c(new_frame))
    frames = c(frame)
    names(frames) = c(basename(file))
    fs =  as(frames, "flowSet")
    gs1 <- GatingSet(fs)
    gs1 <- compensate(gs1, comp)
    gs1 <- transform(gs1, tf)
    
    gh <- gs1[[1]]
    gating(gt_lymph, gs1)
    
    
    
    autoCounts = getStats(gs1 = gs1,
                          qcVersion = qcVersion,
                          metric = "count",
                          "AUTOMATIC")
    # autoProps = getStats(gs1 = gs1,
    #                      qcVersion = qcVersion,
    #                      metric = "freq",
    #                      "AUTOMATIC")
    # metrics = rbind(autoCounts, autoProps)
    metrics = autoCounts
    
    if (!qcVersion) {
      wsFile = mapper[which(mapper$FCS == file),]$WSP
      if(length(wsFile) >0){
        ws <- openWorkspace(wsFile)
        gs <-
          parseWorkspace(
            ws,
            #WSP file
            path = inputFCSDir,
            #FCS file
            name = 1,
            #sample group
            subset = eval(fileToLoad),
            #load single fcs file
            isNcdf = FALSE,
            #not memory mapped
            compensation = comp
          )
        #
        
        manCounts = getStats(gs1 = gs,
                             qcVersion = qcVersion,
                             metric = "count",
                             "MANUAL")
        metrics = rbind(metrics, manCounts)
      }
      # manProps = getStats(gs1 = gs,
      #                     qcVersion = qcVersion,
      #                     metric = "freq",
      #                     "MANUAL")
      # metrics = rbind(metrics, manProps)
      
    }
    print(paste("plotting ....", file))
    # result <-
    #   filter(frame, rectangleGate("remove_from_FM" = c(10000, Inf)))
    # overlay.fr2 <- Subset(frame, result)
    t1 = ggcyto(gs1,
                mapping = aes(x = "FSC-A", y = "SSC-A"),
                subset = "root") +
      geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()  + xlim(c(0, 2e5)) + ylim(c(0, 2e5))
    
    # + scale_x_flowJo_biexp()+ scale_y_flowJo_biexp()
    
    t2 = ggcyto(gs1,
                mapping = aes(x = "FSC-A", y = "SSC-A"),
                subset = "boundary") +
      geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()  + xlim(c(0, 2e5)) + ylim(c(0, 2e5))
    
    
    t3 = ggcyto(gs1,
                mapping = aes(x = "FSC-A", y = "SSC-A"),
                subset = "nonDebris") +
      geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()  + xlim(c(0, 2e5)) + ylim(c(0, 2e5))
    # + scale_x_flowJo_biexp()+ scale_y_flowJo_biexp()
    
    
    t4 = ggcyto(gs1,
                mapping = aes(x = "FSC-W", y = "FSC-H"),
                subset = "lymph") +
      geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
    
    t5 = ggcyto(gs1,
                mapping = aes(x = "PE-A", y = "FSC-H"),
                subset = "Singlets") +
      geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
    
    t6 = ggcyto(gs1,
                mapping = aes(x = "CD3", y = "CD19"),
                subset = "PE-A-") +
      geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()
    t6_1 = ggcyto(gs1,
                  mapping = aes(x = "CD3", y = "CD19"),
                  subset = "Tcells") +
      geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()
    
    t1Bcell = ggcyto(gs1,
                     mapping = aes(x = "CD3", y = "CD19"),
                     subset = "CD3-") +
      geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()
    
    t2Bcell = ggcyto(gs1,
                     mapping = aes(x = "IgD", y = "CD27"),
                     subset = "Bcells") +
      geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()
    
    t7 = ggcyto(gs1,
                mapping = aes(x = "CD4", y = "CD8"),
                subset = "Tcells") +
      geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()
    
    # t7_1 = ggcyto(gs1,
    #               mapping = aes(x = "CD4", y = "CD8"),
    #               subset = "CD4_1") +
    #   geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()
    
    t8 = ggcyto(gs1,
                mapping = aes(x = "CD4", y = "HLA-DR"),
                subset = "CD4") +
      geom_hex(bins = 200) + ggcyto_par_set(limits = "data") + geom_gate()
    
    t9 = ggcyto(gs1,
                mapping = aes(x = "CCR7", y = "CD45RA"),
                subset = "CD4") + geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
    
    tCD8Active = ggcyto(gs1,
                        mapping = aes(x = "CD8", y = "HLA-DR"),
                        subset = "CD8") + geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
    t10 = ggcyto(gs1,
                 mapping = aes(x = "CCR7", y = "CD45RA"),
                 subset = "CD8") + geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
    
    t11 = ggcyto(gs1,
                 mapping = aes(x = "CD28", y = "CD27"),
                 subset = "CD8/CCR7-CD45RA-") + geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
    t12 = ggcyto(gs1,
                 mapping = aes(x = "CD28", y = "CD27"),
                 subset = "CD8/CCR7-CD45RA+") + geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
    
    grid.arrange(
      as.ggplot(t1),
      as.ggplot(t2),
      as.ggplot(t3),
      as.ggplot(t4),
      as.ggplot(t5),
      as.ggplot(t6),
      as.ggplot(t6_1),
      as.ggplot(t1Bcell),
      as.ggplot(t2Bcell),
      as.ggplot(t7),
      # as.ggplot(t7_1),
      as.ggplot(t8),
      as.ggplot(t9),
      as.ggplot(tCD8Active),
      as.ggplot(t10),
      as.ggplot(t11),
      as.ggplot(t12),
      
      ncol = 2
    )
    
    d = rbind.data.frame(as.data.frame(getPopStats(gs1)), d)
    outFile <-
      paste(outputDir, gateDir,
            basename(file),
            "_panel1.wsp", sep = "")
    GatingSet2flowJo(gs1, outFile)
    outFileRename <-
      paste(outputDir, gateDir,
            basename(file),
            "_panel1.wsp", sep = "")
    
    renameNodes(gs1,read.delim(panle1map,stringsAsFactors = FALSE,sep = "\t"))
    GatingSet2flowJo(gs1, outFileRename)
    sed1(outFileRename)
    return(metrics)
    
  }

# Panel 2 frame
compP2Frame <-
  function(frame,
           file,
           gt_lymph,
           d,
           outputDir,
           gateDir,
           qcVersion,
           mapper,
           inputFCSDir
  ) {
    print(paste("compensating ....", file))
    metrics = data.frame()
    comp <- compensation(keyword(frame)$`SPILL`)
    
    chnls <- parameters(comp)
    
    tf <- transformerList(chnls, biexpTrans)
    
    print(paste("gating ....", file))
    # gs <- GatingSet(c(new_frame))
    frames = c(frame)
    names(frames) = c(basename(file))
    fs =  as(frames, "flowSet")
    gs1 <- GatingSet(fs)
    gs1 <- compensate(gs1, comp)
    gs1 <- transform(gs1, tf)
    
    gh <- gs1[[1]]
    gating(gt_lymph, gs1)
    
    
    
    autoCounts = getStats(gs1 = gs1,
                          qcVersion = qcVersion,
                          metric = "count",
                          "AUTOMATIC")
    metrics = autoCounts
    
    if (!qcVersion) {
      wsFile = mapper[which(mapper$FCS == file),]$WSP
      if(length(wsFile) >0){
      ws <- openWorkspace(wsFile)
      gs <-
        parseWorkspace(
          ws,
          #WSP file 
          path = inputFCSDir,
          #FCS file
          name = 1,
          #sample group
          subset = eval(fileToLoad),
          #load single fcs file
          isNcdf = FALSE,
          #not memory mapped
          compensation = comp
        )
      #
      
      manCounts = getStats(gs1 = gs,
                           qcVersion = qcVersion,
                           metric = "count",
                           "MANUAL")
      metrics = rbind(metrics, manCounts)
      }
    }
    print(paste("plotting ....", file))
    
    t1 = ggcyto(gs1,
                mapping = aes(x = "FSC-A", y = "SSC-A"),
                subset = "root") +
      geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()  + xlim(c(0, 2e5)) + ylim(c(0, 2e5))
    
    
    t2 = ggcyto(gs1,
                mapping = aes(x = "FSC-A", y = "SSC-A"),
                subset = "boundary") +
      geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()  + xlim(c(0, 2e5)) + ylim(c(0, 2e5))
    
    
    
    
    t3 = ggcyto(gs1,
                mapping = aes(x = "FSC-A", y = "SSC-A"),
                subset = "nonDebris") +
      geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
    
    t4 = ggcyto(gs1,
                mapping = aes(x = "FSC-W", y = "FSC-H"),
                subset = "PBMC") +
      geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
    t5 = ggcyto(gs1,
                mapping = aes(x = "PE-A", y = "FSC-H"),
                subset = "Singlets") +
      geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
    
    t6 = ggcyto(gs1,
                mapping = aes(x = "CD3", y = "CD19"),
                subset = "PE-A") +
      geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
    
    t7= ggcyto(gs1,
               mapping = aes(x = "CD14", y = "CD16"),
               subset = "D_NK_M") +
      geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
    
    t8= ggcyto(gs1,
               mapping = aes(x = "CD14", y = "CD16"),
               subset = "CD14+") +
      geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
    
    t9= ggcyto(gs1,
               mapping = aes(x = "CD14", y = "CD20"),
               subset = "CD14-") +
      geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate() 
    
    t10= ggcyto(gs1,
                mapping = aes(x = "CD56", y = "CD16"),
                subset = "CD20-") +
      geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate() 
    
    t11= ggcyto(gs1,
                mapping = aes(x = "CD56", y = "CD16"),
                subset = "CD16+CD56+") +
      geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate() 
    
    
    t12= ggcyto(gs1,
                mapping = aes(x = "CD20", y = "HLA-DR"),
                subset = "CD20-") +
      geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate() 
    
    t13= ggcyto(gs1,
                mapping = aes(x = "CD11C", y = "CD123"),
                subset = "Dendritic") +
      geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate() 
    
    
    # t7= ggcyto(gs1,
    #             mapping = aes(x = "PE-A", y = "FSC-H"),
    #             subset = "Live") +
    #   geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
    # 
    # 
    
    
    grid.arrange(
      as.ggplot(t1),
      as.ggplot(t2),
      as.ggplot(t3),
      as.ggplot(t4),
      as.ggplot(t5),
      as.ggplot(t6),
      as.ggplot(t7),
      as.ggplot(t8),
      as.ggplot(t9),
      as.ggplot(t10),
      as.ggplot(t11),
      as.ggplot(t12),
      as.ggplot(t13),
      
      
      ncol = 2
    )
    
    d = rbind.data.frame(as.data.frame(getPopStats(gs1)), d)
    outFile <-
      paste(outputDir, gateDir,
            basename(file),
            "_panel2.wsp", sep = "")
    GatingSet2flowJo(gs1, outFile)
    return(metrics)
    
  }

getPanel <- 
  function(frame){
    t=pData(parameters(frame))
    p1Key = "CCR7"
    if(p1Key %in% t$desc){
      return("panel1")
    }else{
      return("panel2")
    }
  }

# https://www.bioconductor.org/packages/devel/bioc/vignettes/flowCore/inst/doc/HowTo-flowCore.pdf
i = 1
numProcessed = 0
d = data.frame()
metrics = data.frame()
counts = data.frame(FILE=character(),TOTAL_COUNTS=integer())
for (files in fcsFilesAll) {
  # fcsFiles = files
  print(files)
  i
  pdfFile = paste(outputDir, "gate_plots", i, ".pdf", sep = "")
  pdf(file = pdfFile)
  i = i + 1
  for (file in files) {
    fileToLoad <- file
    
    numProcessed = numProcessed + 1
    print(paste("number processed ....", numProcessed))
    print(paste("loading ....", file))
    frame = read.FCS(paste(inputDir, file, sep = ""))
    tmpCount = data.frame(
      FILE =file,
      TOTAL_COUNTS = length(exprs(frame)[, "FSC-H"])
    )
    counts = rbind(counts, tmpCount)
    
    try(if (length(exprs(frame)[, "FSC-H"]) > 0) {
      
     
      
      description(frame)$FILENAME = file
      # 
      # qcFile = paste(tools::file_path_sans_ext(file), ".fcs", sep = "")
      # qcFileFull = paste(cleanDir, "QC/", qcFile, sep = "")
      # if (!file.exists(qcFileFull)) {
      #   flow_auto_qc(
      #     frame,
      #     folder_results = "QC",
      #     mini_report = paste(basename(file), "mini"),
      #     fcs_QC = "",
      #     pen_valueFS = 50,
      #     remove_from = "FM"
      #   )
      # }
      
      
      # frame.c = read.FCS(qcFileFull)
      
      panel = getPanel(frame)
      if(panel=="panel1"){
        metricBase = compP1Frame(
          frame = frame,
          file = file,
          gt_lymph = gt_lymph ,
          d = d,
          outputDir = outputDir,
          gateDir = gateDir,
          qcVersion = FALSE,
          mapper = mapper,
          inputFCSDir = ininputDir,
          panle1map = panle1mapFile
          
        )
      }else{
        #panel 2
        metricBase = compP2Frame(
          frame = frame,
          file = file,
          gt_lymph = gt_mono ,
          d = d,
          outputDir = outputDir,
          gateDir = gateDir,
          qcVersion = FALSE,
          mapper,
          inputDir
        )
      }
      metricBase$Panel = panel
      metricBase$PDF = pdfFile
      metricBase$FlaggedSample = file %in% fcsFilesAllProbs
      metrics = rbind(metrics, metricBase)
      # metricQC = compFrame(
      #   frame = frame.c,
      #   file = file,
      #   gt_lymph = gt_lymphQC ,
      #   d = d,
      #   outputDir = outputDir,
      #   gateDir = gateQCDir,
      #   qcVersion = TRUE,
      #   mapper,
      #   inputFCSDir
      # )
      # metricQC$PDF = pdfFile
      # metricQC$FlaggedSample = file %in% fcsFilesAllProbs
      # metrics = rbind(metrics, metricQC)
    })
    
  }
  dev.off()
  
}

write.table(
  metrics,
  sep = "\t",
  quote = FALSE,
  file = paste(outputDir, "metrics.txt", sep = ""),
  row.names = FALSE
)
write.table(
  d,
  sep = "\t",
  quote = FALSE,
  file = paste(outputDir, "metrics.types.txt", sep = ""),
  row.names = FALSE
)
write.table(
  counts,
  sep = "\t",
  quote = FALSE,
  file = paste(outputDir, "metrics.totalCellCounts.txt", sep = ""),
  row.names = FALSE
)


source(file ="CombineWSP.R" )
combineWSP(outputDir =outputDir,gateDir = gateDir,inputFCSDir = inputDir,panle1map = panle1mapFile)

sessionInfo()



