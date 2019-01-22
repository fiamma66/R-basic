# 查詢函式
?mean

# 查詢 packages 下 的函式
?base::mean

# 查詢 範例資料
data()

# import co2 資料集
data("CO2")

# 最常使用 iris
data("iris")

# 查看當前變數
ls()

# 查看物件類別
class(iris)

# str -> structure
str(iris)

# Assign 可以使用箭號
a <- 5
# alt + "-" 快捷鍵

# 向量 c() <- combined
height <- c(155,160,182)

# 向量運算 1.長度相等
x <- c(1,4,5,2)
y <- c(2,6,2,4)
x + y
x * y
# 對應位置運算

# 向量運算 2.長度不等
x + c(10)
# 先針對位置的對應
# 各元素再做運算

x + c(10,4,2,3,1)
# output 11 8 7 5 2
# -> warning 非倍數的向量


# 命名向量
names(height) <- c("John",
                   "Bob",
                   "Eric")
height
# output
# John  Bob Eric 
# 155  160  182

height > 175
# output
# John   Bob  Eric 
# FALSE FALSE  TRUE

# And 條件
height < 180 & height > 170

# Index 從 1 開始
height[1:2]

# 從1到20 間隔2
seq(from = 1 , to = 20 , by = 2)
# 也可以簡寫 但間隔只為1
1:20
# 相等間隔產生
seq(1,20,length=4)

# 重複repeat
rep(1,times=5)
rep(c(1,5),10)
# each 參數
rep(c(1,5),each=3)
# length 總長度
rep(c(1,5),length=5)


# 運算子只能計算數值
# 字串串接? how
paste("abc","def")
# paste有預設分隔符號
paste("abc","def",sep="")
paste("abc","def",sep=",")

paste(c("abc","def"),c(1,2))

paste(c("abc","def"),c(1,2),sep="-")
# collapes 參數 變成一組向量
paste(c("big","bang"),1:4,collapse = "+")

paste(c("big","bang"),1:4,sep = "",collapse = "+")




