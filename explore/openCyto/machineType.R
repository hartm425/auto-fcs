

getMachineType <- function(frame) {
  t = pData(parameters(frame))
  if("BUV396-A" %in% t$name){
    return("FORTESSA")
  }else if("BUV 395-A" %in% t$name){
    return("LSR")
  }else{
    return("MACHINE_UNDETERMINED")
  }
}