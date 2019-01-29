# 圖形分析
load("./riii/Statistics/cdc.Rdata")

str(cdc)
cdc$exerany = as.factor(cdc$exerany)
cdc$hlthplan = as.factor(cdc$hlthplan)
cdc$smoke100 = as.factor(cdc$smoke100 )

summary(cdc)

# 長條圖
barplot(table(cdc$genhlth))



# 圓餅圖
pie(table(cdc$genhlth))

# 加入比例標籤
pct = round(table(cdc$genhlth) / nrow(cdc) *100 ,1)
labels = paste(names(pct),pct,"%")
pie(table(cdc$genhlth),labels = labels)



# 馬賽克圖
table(cdc$gender)
gender_smoke <- table(cdc$gender,cdc$smoke100)
mosaicplot(gender_smoke)


# 直方圖
hist(cdc$height)


# 將畫布切割
# 適用於比較圖片
par(mfrow=c(3,1))
hist(cdc$height)
hist(cdc$height,breaks = 30)
hist(cdc$height,breaks = 50)


# 盒鬚圖
par(mfrow=c(1,1))
boxplot(cdc$weight)
# 水平
boxplot(cdc$weight,horizontal = T)
# ~ 的使用
boxplot(cdc$weight ~ cdc$gender)

# 英制 BMI 直接轉換
bmi <- (cdc$weight/cdc$height^2) * 703
boxplot(bmi ~ cdc$genhlth)

# 點散布圖
# 大概看出相關性
plot(cdc$weight , cdc$height)

# 輸出圖檔
# 先做空檔
jpeg("./pieplot.jpg")
plot(cdc$weight,cdc$height)
# 存檔
dev.off()


# ggplot2
library(ggplot2)

# 直接使用整個資料
g <- ggplot(cdc,
            aes(x=height,y=weight))
# 使用 aes 來指定x,y軸的資料
# 跟資料有關 都使用 aes
g+geom_point(aes(col=exerany))

# x軸身高 y軸體重 用性別分組且以顏色區分
g <- ggplot(cdc,aes(x=height,
                    y=weight,
                    col=gender))
g+geom_point()


# 不再一開始分好資料
# 記得資料都要用aes
g <- ggplot(cdc,aes(x=height,
                    y=weight))
g+geom_point(aes(col=gender))


g <- ggplot(cdc,aes(x=genhlth))
g + geom_bar() 

g + geom_bar() +ylab("次數")+ggtitle("健康狀況")

g + geom_bar(fill="snow",color="black")

# 使用性別分組 以填色區分
g+geom_bar(col="black",aes(fill=gender))

# 更改堆疊
# 預設是 Stack
g+geom_bar(col="black",
           aes(fill=gender),
           position = "stack")

# dodge
g+geom_bar(col="black",
           aes(fill=gender),
           position = "dodge")


g <- ggplot(cdc,aes(x=gender))
g+geom_bar(aes(fill=genhlth),position = "dodge")


# fill 以百分比為上界
g+geom_bar(aes(fill=genhlth),position = "fill")


# identity
g+geom_bar(aes(fill=genhlth),position = "identity")


g <- ggplot(cdc,aes(x=weight))
g+geom_histogram()

# facet wrap 排列多個分組圖
g+geom_histogram() + facet_wrap(~gender)

g+geom_histogram() + facet_wrap(~genhlth,
                                nrow = 3)

# facet grid 橫著排列
g+geom_histogram() + facet_wrap(gender ~ genhlth)


# coordinate
g <- ggplot(cdc,aes(x=genhlth))
g+geom_bar()+coord_flip()

# 南丁格爾圖
g+geom_bar() + coord_polar(theta = "x")
g+geom_bar() + coord_polar(theta = "y")
g+geom_bar(aes(fill=gender)) + coord_polar(theta = "y")


# 原始的圓餅圖
# 較為複雜
# 只有一個 x 軸 以genhlth填滿
# 加入 bar 再透過 coordinate 轉換
ggplot(cdc,aes(x=1,fill=genhlth)) + geom_bar() + coord_polar(theta = "y")


# geom_xx() 中 有預設的統計方法
# 若想使用自己整理好的 
# 參數 stat = "identity"
precount <- as.data.frame(table(cdc$genhlth,
                    dnn=c("genhlth")))
g <- ggplot(precount,aes(x=genhlth,
                         y=Freq))
# 直接執行 會告訴你 stat_count()錯誤
g+geom_bar()
g2 <- g+geom_bar(stat = "identity",fill="blue")


# ggplot 存檔
# ggsave
ggsave(filename = "ggsave.jpg",plot = g2,width = 15,height = 15,limitsize = F)

g <- ggplot(cdc,aes(x=weight))
g+geom_histogram()+scale_y_continuous(sec.axis = sec_axis(~.))


# 對資料作調整
g+geom_histogram()+scale_y_log10()


