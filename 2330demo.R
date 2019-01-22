stock <- read.csv(file = file.choose(),header = T)


summary(stock$High)

# Date 被轉換為factor
stock$Date <- as.Date(stock$Date)

str(stock)

# Date 格式 可以比較同是Date了
stock[1,"Date"] > "2017-01-01"
tw2330_2017 <- stock[stock[,"Date"] > "2017-01-01" &
  stock[,"Date"] < "2017-12-31",]

tw2330_2017[order(tw2330_2017$Close,decreasing = T),]



