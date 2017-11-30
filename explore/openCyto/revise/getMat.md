gateDef = as.data.frame(matrix(nrow = length(getIndiceMat(gs1, "root"))))
for(node in getNodes(gh)){
gateDef =cbind(gateDef,getIndiceMat(gs1, node))
}
 
   write.table(
    gateDef,
    sep = "\t",
    quote = FALSE,
    file = paste(outputDir, "gateDefTest.txt", sep = ""),
    row.names = FALSE
  )
 
 gateDef = data.frame(
      QC = QCDEF,
      lymph = getIndiceMat(gs1, "lymph"),
      Singlets = getIndiceMat(gs1, "Singlets"),
      PE_A_Minus = getIndiceMat(gs1, "PE-A"),
      CD3Plus = getIndiceMat(gs1, "CD3+"),
      cd4Pcd8M = getIndiceMat(gs1, "CD4"),
      cd4Mcd8P = getIndiceMat(gs1, "CD8"),
      HLADR = getIndiceMat(gs1, "ActivatedCD4"),
      CD4_CCR7PCD45RAP = getIndiceMat(gs1, "CD4/CCR7+CD45RA+"),
      CD4_CCR7PCD45RAM = getIndiceMat(gs1, "CD4/CCR7+CD45RA-"),
      CD4_CCR7MCD45RAM = getIndiceMat(gs1, "CD4/CCR7-CD45RA-"),
      CD4_CCR7MCD45RAP = getIndiceMat(gs1, "CD4/CCR7-CD45RA+"),
      CD8_CCR7PCD45RAP = getIndiceMat(gs1, "CD8/CCR7+CD45RA+"),
      CD8_CCR7PCD45RAM = getIndiceMat(gs1, "CD8/CCR7+CD45RA-"),
      CD8_CCR7MCD45RAM = getIndiceMat(gs1, "CD8/CCR7-CD45RA-"),
      CD8_CCR7MCD45RAP = getIndiceMat(gs1, "CD8/CCR7-CD45RA+"),
      BCELL = getIndiceMat(gs1, "CD19gate")
      
    )