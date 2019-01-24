# 讀取存好的 Rdata

load("./Statistics/cdc.Rdata")
head(cdc,10)

str(cdc)

# 資料型態錯誤 重新轉換
# 只有 0 1 類別資料 使用 factor
cdc$exerany <- as.factor(cdc$exerany)
cdc$hlthplan <- as.factor(cdc$hlthplan)
cdc$smoke100 <- as.factor(cdc$smoke100)


# 再次檢查
str(cdc)

# 查看特定資料狀況
paste(round(table(cdc$genhlth)/nrow(cdc)*100,2),"%")
# 查看所有人健康狀況的比例

# 組合資料查看
table(cdc$gender, cdc$genhlth)
# 查看 男女性別健康狀況比例

# 三維度資料
table(cdc$gender, cdc$genhlth,cdc$exerany)
# 蠻難看懂的


# 合併 性別與健康狀況
table(paste(cdc$gender , cdc$genhlth, sep = "_"),cdc$exerany)
# 用 paste 結合 對應位置的向量 並加入分隔
# 再將運動狀況併進來看 -> 資料降維


# 連續型
table(cdc$height)
summary(cdc$height)

# 找到min max
# 進行大致分組 使用 cut
# 包含上界 不包含下界 (] <- (min<x<=max)
head(cut(cdc$height,seq(45,95,by=5)))

# 我們平常喜歡 min <= x < max -> [)
table(cut(cdc$height,seq(45,95,by=5),right = F))

# 保留原本的變數
# 設定新的變數 (原本的並沒有錯誤 故保留)
cdc$h_group <- cut(cdc$height,seq(45,95,by=5),right = F)

str(cdc)


# 平均 中位 眾數
mean(cdc$height)

median(cdc$height)

# 眾數無內建函數
# 使用 table
# which.max(table(cdc$height))
# names(which.max(table(cdc$height)))
as.numeric(names(which.max(table(cdc$height))))

# 全距 max - min
max(cdc$height) - min(cdc$height)

# 四分位距 
# fivenum -> min 四分位 median 四分位 max
# 建議使用 summary 直接看 敘述統計報表
summary(cdc$height)


# 離散值
sd(cdc$height)

var(cdc$height)

sqrt(cdc$height)
?sqrt


# 共變異數
# 必須為連續數值
cov(cdc[,c("height","height",
           "wtdesire","age")])

# 相關係數
cor(cdc[,c("height","height",
           "wtdesire","age")])


# example

gdp <- read.csv("./data/gdp.csv")

# gdp <- gdp[1:15,]

# complete.cases 可檢查資料是否完整
gdp <- gdp[complete.cases(gdp),]
str(gdp)
as.numeric(gdp$GDP)
# 發現 被轉換的 是階層代號
# 轉換成文字看看
as.character(gdp$GDP)
# 再轉換為數字
as.numeric(as.character(gdp$GDP))
# 無法判斷 千分位的 逗號

# 先正規化 把逗號去掉
sub(",","",as.character(gdp$GDP))
gdp$GDP <- as.numeric(sub(",","",as.character(gdp$GDP)))
str(gdp)

gdp$Export <- as.numeric(sub(",","",as.character(gdp$Export)))

str(gdp)
