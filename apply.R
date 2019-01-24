


data(iris)

# 以 Speices 為 index 看其他變數平均
tapply(iris$Sepal.Length,
       iris$Species, mean)

tapply(iris$Sepal.Length,
       iris$Species,
       function(e){list(avg=mean(e),md=median(e),s_d = sd(e))})

lapply(names(iris[1:4]), function(e){ tapply(iris[,e], iris$Species , mean)})

# lapply 前面的資料作為變數丟給後面的 Function
# function 內再 tapply 分組計算 


x = c(80,70,59,88,72,57)
t = c(1,1,2,1,1,2)
tapply(x,t, mean)







