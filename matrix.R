
# matrix
matrix(data=1:9,nrow = 3,
       byrow = F)
# nrow 或 ncol 擇1
matrix(data=1:9,ncol = 3,
       byrow = T)
# byrow = F 直著放

kevin = c(86,76)
marry = c(99,96)
jerry = c(55,40)
mat = matrix(c(kevin,marry,jerry),nrow=3,
byrow=T)
# dim 顯示矩陣大小
dim(mat)
# ex : 3 X 2

colnames(mat) <- c("first","second")
rownames(mat) <- c("kevin",
                   "marry",
                   "jerry")
# 篩選 matrix 資料
# 使用 []
# 第一次成績
mat[,1]

# 第一個人的資料
mat[1,]
mat[c(1,3),]

# index 也可使用 名字
mat["kevin",]

mat[,1] < 60
# 篩選不及格
mat[mat[,1] < 60,]

# 篩選及格
mat[mat[,1]>60,]

# rbind cbind
sam = c(70,50)

# 必須設定回去
mat <- rbind(mat,sam)
mat
mat <- cbind(mat,c(82,95,61,71))
colnames(mat) <- c("first","second","third")
mat

# matrix mean

rowMeans(mat)

colMeans(mat)

# 矩陣相乘
m1 = matrix(1:4, byrow = T, nrow = 2)
m2 = matrix(5:8, byrow = T, nrow = 2)
m1 %*% m2
mat <- matrix(c(kevin,marry,jerry),nrow = 3,byrow = T)

mat
m1 <- matrix(c(0.4,0.6),nrow = 2)
mat <- cbind(mat,mat %*% m1)
colnames(mat) <- c("first",
                   "second",
                   "mean")
rownames(mat) <- c("kevin",
                   "marry",
                   "jerry")

mat 
# 偷懶方法
mat <- matrix(c(kevin,marry,jerry),nrow = 3,byrow = T)

final <- mat %*% c(0.4,0.6)


