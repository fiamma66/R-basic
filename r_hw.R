setwd("E:/Rwork")
match_demo <- read.table(file = file.choose(),sep = "|",header = F)

str(match_demo)


m1 <- matrix(rep(-1,25),nrow = 5)
colnames(m1) <- c("A","B","C"
                  ,"D","E")
rownames(m1) <- c("A","B","C"
                  ,"D","E")
i=1
for (i in 1:nrow(match_demo)){
  m1[match_demo[i,1],match_demo[i,2]] <- match_demo[i,3]
  
}

# 稍微不好的寫法
re <- function(file=read.table(file = file.choose(),header = F,sep = "|")){
  m1 <- matrix(rep(-1,25),nrow = 5)
  colnames(m1) <- c("A","B","C"
                    ,"D","E")
  rownames(m1) <- c("A","B","C"
                    ,"D","E")
  for (i in 1:nrow(file)){
    m1[file[i,1],file[i,2]] <- file[i,3]
    
  }
  return(m1)
  
}


re()

# 改進

match_re <- function(filename,header=T,sep="|"){
  t = read.table(filename,header=header,sep = sep)
  mat = matrix(-1, # 若無指定數量 要記得 nrow 跟 ncol 都要加
               nrow = length(levels(t[,1])), # level 來看有哪些類別
               ncol = length(levels(t[,1])), 
               dimnames = list(levels(t[,1]),levels(t[,1])))
  
  for (i in 1:nrow(t)) {
    mat[t[i,1], t[i,2]] = t[i,3] 
    
  }
  
  return(mat)
  
  
  
  
}
match_re("./riii/data/match.txt",header = F,sep = "|")


