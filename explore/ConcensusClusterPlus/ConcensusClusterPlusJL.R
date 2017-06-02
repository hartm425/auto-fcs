function (d = NULL, maxK = 3, reps = 10, pItem = 0.8, pFeature = 1, 
          clusterAlg = "hc", title = "untitled_consensus_cluster", 
          innerLinkage = "average", finalLinkage = "average", distance = "pearson", 
          ml = NULL, tmyPal = NULL, seed = NULL, plot = NULL, writeTable = FALSE, 
          weightsItem = NULL, weightsFeature = NULL, verbose = F, 
          corUse = "everything") 
{
  if (is.null(seed) == TRUE) {
    seed = timeSeed = as.numeric(Sys.time())
  }
  set.seed(seed)
  if (is.null(ml) == TRUE) {
    if (!class(d) %in% c("dist", "matrix", "ExpressionSet")) {
      stop("d must be a matrix, distance object or ExpressionSet (eset object)")
    }
    if (inherits(d, "dist")) {
      if (is.null(attr(d, "method"))) {
        attr(d, "method") <- distance <- "unknown - user-specified"
      }
      if (is.null(distance) || (distance != attr(d, "method"))) {
        distance <- attr(d, "method")
      }
      if ((!is.null(pFeature)) && (pFeature < 1)) {
        message("Cannot use the pFeatures parameter when specifying a distance matrix as the data object\n")
        pFeature <- 1
      }
      if (!is.null(weightsFeature)) {
        message("Cannot use the weightsFeature parameter when specifying a distance matrix as the data object\n")
        weightsFeature <- NULL
      }
      if (clusterAlg == "km") {
        message("Note: k-means will cluster the distance matrix you provided.  This is similar to kmdist option when suppling a data matrix")
      }
    }
    else {
      if (is.null(distance)) {
        distance <- "pearson"
      }
    }
    if ((clusterAlg == "km") && inherits(distance, "character") && 
        (distance != "euclidean")) {
      message("Note: The km (kmeans) option only supports a euclidean distance metric when supplying a data matrix.  If you want to cluster a distance matrix using k-means use the 'kmdist' option, or use a different algorithm such as 'hc' or 'pam'.  Changing distance to euclidean")
      distance <- "euclidean"
    }
    if (inherits(d, "ExpressionSet")) {
      d <- exprs(d)
    }
    ml <- ccRun(d = d, maxK = maxK, repCount = reps, diss = inherits(d, 
                                                                     "dist"), pItem = pItem, pFeature = pFeature, innerLinkage = innerLinkage, 
                clusterAlg = clusterAlg, weightsFeature = weightsFeature, 
                weightsItem = weightsItem, distance = distance, 
                verbose = verbose, corUse = corUse)
  }
  res = list()
  if ((is.null(plot) == FALSE | writeTable) & !file.exists(paste(title, 
                                                                 sep = ""))) {
    dir.create(paste(title, sep = ""))
  }
  log <- matrix(ncol = 2, byrow = T, c("title", title, "maxK", 
                                       maxK, "input matrix rows", ifelse(inherits(d, "matrix"), 
                                                                         nrow(d), "dist-mat"), "input matrix columns", ifelse(inherits(d, 
                                                                                                                                       "matrix"), ncol(d), ncol(as.matrix(d))), "number of bootstraps", 
                                       reps, "item subsampling proportion", pItem, "feature subsampling proportion", 
                                       ifelse(is.null(pFeature), 1, pFeature), "cluster algorithm", 
                                       clusterAlg, "inner linkage type", innerLinkage, "final linkage type", 
                                       finalLinkage, "correlation method", distance, "plot", 
                                       if (is.null(plot)) NA else plot, "seed", if (is.null(seed)) NA else seed))
  colnames(log) = c("argument", "value")
  if (writeTable) {
    write.csv(file = paste(title, "/", title, ".log.csv", 
                           sep = ""), log, row.names = F)
  }
  if (is.null(plot)) {
  }
  else if (plot == "pngBMP") {
    bitmap(paste(title, "/", "consensus%03d.png", sep = ""))
  }
  else if (plot == "png") {
    png(paste(title, "/", "consensus%03d.png", sep = ""))
  }
  else if (plot == "pdf") {
    pdf(onefile = TRUE, paste(title, "/", "consensus.pdf", 
                              sep = ""))
  }
  else if (plot == "ps") {
    postscript(onefile = TRUE, paste(title, "/", "consensus.ps", 
                                     sep = ""))
  }
  colorList = list()
  colorM = rbind()
  thisPal <- c("#A6CEE3", "#1F78B4", "#B2DF8A", "#33A02C", 
               "#FB9A99", "#E31A1C", "#FDBF6F", "#FF7F00", "#CAB2D6", 
               "#6A3D9A", "#FFFF99", "#B15928", "#bd18ea", "#2ef4ca", 
               "#f4cced", "#f4cc03", "#05188a", "#e5a25a", "#06f106", 
               "#85848f", "#000000", "#076f25", "#93cd7f", "#4d0776", 
               "#ffffff")
  colBreaks = NA
  if (is.null(tmyPal) == TRUE) {
    colBreaks = 10
    tmyPal = myPal(colBreaks)
  }
  else {
    colBreaks = length(tmyPal)
  }
  sc = cbind(seq(0, 1, by = 1/(colBreaks)))
  rownames(sc) = sc[, 1]
  sc = cbind(sc, sc)
  heatmap(sc, Colv = NA, Rowv = NA, symm = FALSE, scale = "none", 
          col = tmyPal, na.rm = TRUE, labRow = rownames(sc), labCol = F, 
          main = "consensus matrix legend")
  for (tk in 2:maxK) {
    if (verbose) {
      message(paste("consensus ", tk))
    }
    fm = ml[[tk]]
    hc = hclust(as.dist(1 - fm), method = finalLinkage)
    message("clusteredJL")
    ct = cutree(hc, tk)
    names(ct) = colnames(d)
    if (class(d) == "dist") {
      names(ct) = colnames(as.matrix(d))
    }
    c = fm
    colorList = setClusterColors(res[[tk - 1]][[3]], ct, 
                                 thisPal, colorList)
    pc = c
    pc = pc[hc$order, ]
    if (!is.null(plot) && plot == "pngBMP") {
      pc = pc[, hc$order]
      pc = rbind(pc, 0)
      oc = colorList[[1]][hc$order]
      heatmap(pc, Colv = NA, Rowv = NA, symm = FALSE, 
              scale = "none", col = tmyPal, na.rm = TRUE, 
              labRow = F, labCol = F, mar = c(5, 5), main = paste("consensus matrix k=", 
                                                                  tk, sep = ""), ColSideCol = oc)
    }
    else {
      pc = rbind(pc, 0)
      heatmap(pc, Colv = as.dendrogram(hc), Rowv = NA, 
              symm = FALSE, scale = "none", col = tmyPal, 
              na.rm = TRUE, labRow = F, labCol = F, mar = c(5, 
                                                            5), main = paste("consensus matrix k=", tk, 
                                                                             sep = ""), ColSideCol = colorList[[1]])
    }
    legend("topright", legend = unique(ct), fill = unique(colorList[[1]]), 
           horiz = FALSE)
    res[[tk]] = list(consensusMatrix = c, consensusTree = hc, 
                     consensusClass = ct, ml = ml[[tk]], clrs = colorList)
    colorM = rbind(colorM, colorList[[1]])
  }
  CDF(ml)
  clusterTrackingPlot(colorM[, res[[length(res)]]$consensusTree$order])
  if (is.null(plot) == FALSE) {
    dev.off()
  }
  res[[1]] = colorM
  if (writeTable) {
    for (i in 2:length(res)) {
      write.csv(file = paste(title, "/", title, ".k=", 
                             i, ".consensusMatrix.csv", sep = ""), res[[i]]$consensusMatrix)
      write.table(file = paste(title, "/", title, ".k=", 
                               i, ".consensusClass.csv", sep = ""), res[[i]]$consensusClass, 
                  col.names = F, sep = ",")
    }
  }
  return(res)
}
