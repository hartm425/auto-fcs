histFile="/Users/Kitty/Downloads/hist.xln"

data = read.delim(histFile, stringsAsFactors = FALSE,header = FALSE)


library(ggplot2)
ggplot(data=data, aes(data$V1)) + geom_histogram(bins = 300)+xlim()
data=data[which(data$V1<250000),]
data =as.data.frame(data)
ggplot(data=data, aes(V1)) + geom_histogram(bins = 300)