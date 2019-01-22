# dataFrame

name <- c("Joe","Bob","Vivi")
age <- c(26,28,22)
gender <- c("Male","Male","Female")

df <- data.frame(name,age,gender)

str(df)
summary(df)

# 使用 iris

data("iris")
str(iris)
head(iris,n = 10)

# 取前三列
iris[1:3,]

# 篩選出 花萼>5.5
iris[,"Sepal.Length"] > 5.5

# 對樣本作篩選
iris[iris[,"Sepal.Length"] > 5.5,]

# recursive object 專屬使用
iris$Sepal.Length

# 使用 which 
# 回傳值為 index
idx = which(iris$Sepal.Length > 5.5)
iris[idx,]

# table join
# use merge
df1 = data.frame(CustomerId = c(1:6),
                 Product = c(rep("Toaster",3),
                             rep("Radio",3)))
df2 = data.frame(CustomerId = c(2,4,6),
                 State = c(rep("Alabama",2),
                           rep("Ohio",1)))
# inner join
merge(df1,df2,by = "CustomerId")

# Outer join
merge(x=df1,y=df2,all = T)

# Left join
merge(x=df1,y=df2,all.x = T)
# 使用 all.x all.y 
# 來完成 left or right join

# order 排序 呈現 index
iris[order(iris$Sepal.Length, decreasing = TRUE),]

# sort 排序 呈現數值
iris[sort(iris$Sepal.Length,decreasing = T),]


# 資料轉換
# ifelse(condition,{if statement},{else statment})
ifelse(iris$Species == "setosa","IsSetosa","NotSetosa")

iris$Species_new = as.factor(ifelse(iris$Species == "setosa","IsSetosa","NotSetosa")
)
str(iris)
