

# R 的 switch 只對 index 做揀選
switch (1,
  print("y"),print("e"),print("s")
)

# if else 正規寫法
x <- 5
if (x >3) {
  print("x>3")
} else if (x<1) {
  print("x<1")
} else {
  print("i don't know")
}

# ifelse 直接判斷並傳回指定數字
test = ifelse(x>3,20,10)
test


# for 迴圈
# matrix(rep(NA,81),nrow=9)
nine <- matrix(nrow=9,ncol=9)
i=1
t=1
for (i in seq(9)) {
  for (t in seq(9)){
    #nine[i,t] <- i*t
    # 整理得漂亮一點
    #nine[i,t] <- paste(i,"*",t,"= ",i*t)
    nine[i,t] <- sprintf(" %s * %s = %s",i,t,i*t)
  }
  
}
nine

m1 <- matrix(1:9)
m2 <- matrix(1:9,ncol = 9)
nine2 <- m1 %*% m2

# break and next
# next 類似 continue



