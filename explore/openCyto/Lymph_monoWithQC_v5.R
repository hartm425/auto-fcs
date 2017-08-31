library(openCyto)
library(flowCore)
library(data.table)
library(ggcyto)
library(gridExtra)
library(CytoML)
library(flowAI)


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


panle1mapFile = "/Users/Kitty/git/auto-fcs/explore/openCyto/panel1Map.txt"
panle2mapFile = "/Users/Kitty/git/auto-fcs/explore/openCyto/panel2Map.txt"

panel1NodesToHide = c("CD8/HLA-DR+", "CD4/HLA-DR+", "FSC-W+")
panel2NodesToHide = c()

setwd(dirname(panle1mapFile))
source(file = "CombineWSP.R")
source(file = "computeFreqs.R")
source(file = "machineType.R")
source(file = "generateFortessa.R")

runFlowAI = FALSE
inputDir = "/Volumes/Beta/data/flow/fcs3/"
outputDir = "/Volumes/Beta/data/flow/"
templateLymph = "~/git/auto-fcs/explore/openCyto/lymph.dev.LSR.f.txt"
templateLymphFortessa = convertP1ToFortessa(templateFile = templateLymph, outputDir = outputDir)

templateMono = "~/git/auto-fcs/explore/openCyto/dc.dev.c.txt"
mapperFile = "/Volumes/Beta/data/flow/fcsMap.txt"

gateDir = "gates/"
gateQCDir = "gatesQC/"

mapper = read.delim(mapperFile,
                    stringsAsFactors = FALSE,
                    sep = "\t")

theme_set(theme_bw(5))
gt_lymph <-
  gatingTemplate(templateLymph, autostart = 1L)
gt_lymphFortessa <-
  gatingTemplate(templateLymphFortessa, autostart = 1L)
gt_mono <-
  gatingTemplate(templateMono, autostart = 1L)

fcsFilesAll <-
  list.files(inputDir,
             pattern = ".fcs",
             full = FALSE)
# fcsFilesAll = fcsFilesAll[8:9]
# fcsFilesAll = fcsFilesAll[307:309]
# BCELL test: 2016-05-11_PANEL 1_ZF_panel one_F1631925_005.fcs
# fcsFilesAll[grepl("PANEL 1",fcsFilesAll)]
# fcsFilesAll =c( "2017-05-02_PANEL 1_FORTESSA_DHS_group one_F1640599_029.fcs")
# fcsFilesAll =fcsFilesAll[grepl("PANEL 1_FORTESSA",fcsFilesAll)]
fcsFilesAllProbs = c("NONE")



# only use files with gates available
# fcsFilesAll = fcsFilesAll[fcsFilesAll %in% mapper$FCS]
# print(length(fcsFilesAll))

REPLACE_FOR_NEW_FILES = ""

fcsFilesAll = split(fcsFilesAll, ceiling(seq_along(fcsFilesAll) / 15))

getStats <- function(gs1, qcVersion, metric, gate) {
  autoStats = getPopStats(gs1, statistic = metric)
  # t= getPopStats(gs1, statistic = "count")
  # write.table(t,file="t1.txt",quote = FALSE,row.names = FALSE,sep = "\t")
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


plotP1 <- function(gs1) {
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
  
}

plotP2 <- function(gs1) {
  t1 = ggcyto(gs1,
              mapping = aes(x = "FSC-A", y = "SSC-A"),
              subset = "root") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()  + xlim(c(0, 2e5)) + ylim(c(0, 2e5))
  
  
  t2 = ggcyto(gs1,
              mapping = aes(x = "CD45", y = "SSC-A"),
              subset = "boundary") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
  
  
  
  
  t3 = ggcyto(gs1,
              mapping = aes(x = "PE-A", y = "SSC-A"),
              subset = "CD45+") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
  
  t4 = ggcyto(gs1,
              mapping = aes(x = "FSC-W", y = "FSC-H"),
              subset = "PE-A") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
  t5 = ggcyto(gs1,
              mapping = aes(x = "FSC-A", y = "SSC-A"),
              subset = "Singlets") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
  
  t6 = ggcyto(gs1,
              mapping = aes(x = "FSC-A", y = "SSC-A"),
              subset = "nonDebris") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
  
  t6_1 = ggcyto(gs1,
                mapping = aes(x = "CD3", y = "CD19"),
                subset = "PBMC") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
  
  
  t7 = ggcyto(gs1,
              mapping = aes(x = "CD14", y = "CD16"),
              subset = "D_NK_M") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
  
  t8 = ggcyto(gs1,
              mapping = aes(x = "CD14", y = "CD16"),
              subset = "CD14+") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
  
  t9 = ggcyto(gs1,
              mapping = aes(x = "CD14", y = "CD20"),
              subset = "CD14-") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
  
  t10 = ggcyto(gs1,
               mapping = aes(x = "CD56", y = "CD16"),
               subset = "CD20-") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
  
  t11 = ggcyto(gs1,
               mapping = aes(x = "CD56", y = "CD16"),
               subset = "CD16+CD56+") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
  
  
  t12 = ggcyto(gs1,
               mapping = aes(x = "CD20", y = "HLA-DR"),
               subset = "CD20-") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
  
  t13 = ggcyto(gs1,
               mapping = aes(x = "CD11C", y = "CD123"),
               subset = "Dendritic") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()
  
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
}
compFrame <-
  function(frame,
           file,
           gateTemplate,
           d,
           outputDir,
           gateDir,
           qcVersion,
           mapper,
           inputFCSDir,
           panelMap,
           plot = TRUE,
           panel,
           nodesToHide) {
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
    gating(gateTemplate, gs1)
    
    
    
    autoCounts = getStats(gs1 = gs1,
                          qcVersion = qcVersion,
                          metric = "count",
                          "AUTOMATIC")
    metrics = autoCounts
    
    if (!qcVersion) {
      wsFile = mapper[which(mapper$FCS == file), ]$WSP
      if (length(wsFile) > 0) {
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
    try(if (plot) {
      print(paste("plotting ", panel, "....", file))
      if (panel == "panel1") {
        plotP1(gs1 = gs1)
      } else if (panel == "panel2") {
        plotP2(gs1 = gs1)
      }
    })
    
    d = rbind.data.frame(as.data.frame(getPopStats(gs1)), d)
    outFile <-
      paste(outputDir, gateDir,
            basename(file),
            "_", panel, ".wsp", sep = "")
    GatingSet2flowJo(gs1, outFile)
    outFileRename <-
      paste(outputDir,
            gateDir,
            basename(file),
            "_",
            panel,
            "Rename.wsp",
            sep = "")
    
    nodes = getNodes(gs1, path = "auto")
    for (hideNode in nodesToHide) {
      if (hideNode %in% nodes) {
        print(paste("hiding node ", hideNode))
        setNode(gs1, hideNode, FALSE)
      }
    }
    
    renameNodes(gs1,
                read.delim(panelMap, stringsAsFactors = FALSE, sep = "\t"))
    GatingSet2flowJo(gs1, outFileRename)
    if (panel == "panel1") {
      sed1(outFileRename)
    } else if (panel == "panel2") {
      sed2(outFileRename)
    }
    return(metrics)
    
  }

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

validFrame <- function(frame) {
  "FSC-H" %in% colnames(exprs(frame))
}
metricsFile = paste(outputDir, "metrics.txt", sep = "")

if (!file.exists(metricsFile)) {
  # https://www.bioconductor.org/packages/devel/bioc/vignettes/flowCore/inst/doc/HowTo-flowCore.pdf
  i = 1
  numProcessed = 0
  d = data.frame()
  metrics = data.frame()
  counts = data.frame(
    FILE = character(),
    TOTAL_COUNTS = integer(),
    QC = character(),
    PANEL = character(),
    MACHINE=character()
  )
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
      if (validFrame(frame = frame)) {
        panel = getPanel(frame)
        machine = getMachineType(frame = frame)
        print(paste("finished loading ....", file," panel=",panel," machine=",machine))
        
        tmpCount = data.frame(
          FILE = file,
          TOTAL_COUNTS = length(exprs(frame)[, "FSC-H"]),
          QC = "FALSE",
          PANEL = panel,
          MACHINE=machine
        )
        counts = rbind(counts, tmpCount)
        
        try(if (length(exprs(frame)[, "FSC-H"]) > 0) {
          description(frame)$FILENAME = file
          #
          
          metricBase = data.frame()
          if (panel == "panel1") {
            templateToUse = NULL
            if (machine == "FORTESSA") {
              templateToUse = gt_lymphFortessa
            } else if (machine == "LSR") {
              templateToUse = gt_lymph
            }
            metricBase = compFrame(
              frame = frame,
              file = file,
              gateTemplate = templateToUse ,
              d = d,
              outputDir = outputDir,
              gateDir = gateDir,
              qcVersion = FALSE,
              mapper = mapper,
              inputFCSDir = inputDir,
              panelMap = panle1mapFile,
              plot = TRUE,
              panel = panel,
              nodesToHide = panel1NodesToHide
            )
            metricBase$Panel = panel
            metricBase$PDF = pdfFile
            metricBase$FlaggedSample = file %in% fcsFilesAllProbs
            metricBase$MACHINE = machine
            
            metrics = rbind(metrics, metricBase)
            print(metricBase)
            
          } else if (panel == "panel2") {
            #panel 2
            metricBase = compFrame(
              frame = frame,
              file = file,
              gateTemplate = gt_mono ,
              d = d,
              outputDir = outputDir,
              gateDir = gateDir,
              qcVersion = FALSE,
              mapper = mapper,
              inputFCSDir = inputDir,
              panelMap = panle2mapFile,
              plot = TRUE,
              panel = panel,
              nodesToHide = panel2NodesToHide
            )
            metricBase$Panel = panel
            metricBase$PDF = pdfFile
            metricBase$FlaggedSample = file %in% fcsFilesAllProbs
            metricBase$MACHINE = machine
            print(metricBase)
            
            metrics = rbind(metrics, metricBase)
          }
          
        })
        try(if (runFlowAI) {
          qcFile = paste(tools::file_path_sans_ext(file), ".fcs", sep = "")
          qcDir = paste(outputDir, "fcsQC/", sep = "")
          qcFileFull = paste(qcDir, qcFile, sep = "")
          
          if (!file.exists(qcFileFull)) {
            setwd(qcDir)
            flow_auto_qc(
              frame,
              folder_results = "",
              mini_report = paste(basename(file), "mini", sep =),
              fcs_QC = FALSE,
              pen_valueFS = 50,
              remove_from = "FR_FM",
              fcs_highQ = ""
              
            )
          }
          frame.c = read.FCS(qcFileFull)
          tmpCount = data.frame(
            FILE = file,
            TOTAL_COUNTS = length(exprs(frame.c)[, "FSC-H"]),
            QC = "TRUE",
            PANEL = panel,
            MACHINE=machine
            
          )
          counts = rbind(counts, tmpCount)
          
          try(if (length(exprs(frame)[, "FSC-H"]) > 0) {
            if (panel == "panel1") {
              templateToUse = NULL
              if (machine == "FORTESSA") {
                templateToUse = gt_lymphFortessa
              } else if (machine == "LSR") {
                templateToUse = gt_lymph
              }
              metricBaseQC = compFrame(
                frame = frame.c,
                file = qcFile,
                gateTemplate = templateToUse ,
                d = d,
                outputDir = outputDir,
                gateDir = gateQCDir,
                qcVersion = TRUE,
                mapper = mapper,
                inputFCSDir = qcDir,
                panelMap = panle1mapFile,
                plot = TRUE,
                panel = panel,
                nodesToHide = panel1NodesToHide
                
              )
              metricBaseQC$Panel = panel
              metricBaseQC$PDF = pdfFile
              metricBaseQC$FlaggedSample = file %in% fcsFilesAllProbs
              metricBaseQC$MACHINE = machine
              
              metrics = rbind(metrics, metricBaseQC)
              
            } else if (panel == "panel2") {
              #panel 2
              # print(metricBase)
              metricBaseQC = compFrame(
                frame = frame.c,
                file = qcFile,
                gateTemplate  = gt_mono ,
                d = d,
                outputDir = outputDir,
                gateDir = gateQCDir,
                qcVersion = TRUE,
                mapper = mapper,
                inputFCSDir = qcDir,
                panelMap =  panle2mapFile,
                plot = TRUE,
                panel = panel,
                nodesToHide = panel2NodesToHide
              )
              metricBaseQC$Panel = panel
              metricBaseQC$PDF = pdfFile
              metricBaseQC$FlaggedSample = file %in% fcsFilesAllProbs
              metrics = rbind(metrics, metricBaseQC)
              metricBaseQC$MACHINE = machine
              
            }
            
          })
        })
      } else{
        print(paste("Invalid fcs file (no FSC-H): ", file))
      }
    }
    dev.off()
    
  }
  
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
  
  write.table(
    metrics,
    sep = "\t",
    quote = FALSE,
    file = metricsFile,
    row.names = FALSE
  )
} else{
  print(paste("metrics file", metricsFile, "exists"))
}

compute(
  mets = metricsFile,
  p1map = panle1mapFile,
  p2map = panle2mapFile,
  outputDir = outputDir
)



# combineWSP(outputDir =outputDir,gateDir = gateDir,inputFCSDir = inputDir,panle1map = panle1mapFile)

sessionInfo()
