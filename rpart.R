library(C50)
data(churn)

# 先來選擇變數
names(churnTrain) %in% c("state","account_length","area_code")
# 反向選擇
!names(churnTrain) %in% c("state","account_length","area_code")

variable.list <- !names(churnTrain) %in% c("state","account_length","area_code")
# 篩選
churnTrain <- churnTrain[,variable.list]
churnTest <- churnTest[,variable.list]

# 分割資料 我們用sample
sample(1:10,size = 4)
# 在0和5 中 抽5個 可重複 replace=T
sample(c(0,5),size = 5, replace = T)

# 抽樣數要比樣本數大 否則要使用 replace=T

# 在 1~20 中 抽12個不重複整數
sample.int(20,12)

set.seed(2)
# 設計一個箱子 只有2個球
# 叫資料集來抽球 1為Train 2為Test
ind <- sample(1:2 , size = nrow(churnTrain),replace = T, prob = c(0.7,0.3))
# 照著拿到的球 進該進的洞
trainset = churnTrain[ind==1,]
testset = churnTrain[ind==2,]

# rpart
library(rpart)
# 設定基本決策樹 minsplit 最小包含樣本數 cp = 
# maxdepth 最大層數限制(有幾層數)
con = rpart.control(minsplit = 20,cp=0.01)
# rpart(y~x 設定Y與X . 代表全部(不包含指定的Y), data = 資料集, control = 基本設定)
churn.rp <- rpart(churn ~., data = trainset,control = con)

summary(churn.rp)

# 視覺化
# uniform 樹枝一樣長 brach 樹枝彎曲 margin 間隔
plot(churn.rp, uniform = T, branch = 0.6, margin = 0.1)
text(churn.rp, all = T , use.n = T, cex=0.7)

# rpart.plot 套件
install.packages('rpart.plot')
library('rpart.plot')
rpart.plot(churn.rp)

# 衡量 rpart 模型

# 使用 cost complexity
# 邊際效益的概念
# 每多一顆樹 可以下降多少 training error
# 我們觀察cptable
churn.rp$cptable

# 找到最小 x error
min_row = which.min(churn.rp$cptable[,"xerror"])
churn.cp <- churn.rp$cptable[min_row,"CP"]

# 使用 prune 來修剪決策樹
prune.tree <- prune(churn.rp, cp = churn.cp)
rpart.plot(churn.rp)
rpart.plot(prune.tree)


# 評估決策樹模型

predictions <- predict(prune.tree , newdata = testset, type = "class")

# 套件計算 混淆矩陣
library("caret")
library("e1071")

confusionMatrix(table(predictions, testset$churn))


## ctree
install.packages("party")
library("party")
p <- party::cforest_control()
