file = "2017-01-23_PANEL 2_DHS_Group one_F1636334_010.fcs"

file = "2017-01-23_PANEL 2_DHS_Group one_F1638605_013.fcs"
file = "2016-09-13_PANEL 2_DHS_Group one_F1631262_014.fcs"
file = "2016-12-12_PANEL 2_DHS_Group two_F1636111_040.fcs"
file = "2016-05-11_PANEL 2_ZF_panel 2_F1631920_007.fcs"
file = "2016-12-01_PANEL 2_HB_group one_F1652726_008.fcs"
source(file = "generateFortessa.R")

frame = read.FCS(paste(inputDir, file, sep = ""))

templateMono = "~/git/auto-fcs/explore/openCyto/dc.dev.LSR.c.txt"
if (getMachineType(frame) == "FORTESSA") {
  templateMonoFortessa = convertP2ToFortessa(templateFile = templateMono, outputDir = outputDir)
  
  gt_mono <-
    gatingTemplate(templateMonoFortessa, autostart = 1L)
  print(getMachineType(frame))
  
}else {
  gt_mono <-
    gatingTemplate(templateMono, autostart = 1L)
}
