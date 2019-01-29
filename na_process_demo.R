load("./riii/Statistics/appledaily.RData")
str(appledaily)

appledaily$dt[1]

# format 用法
# 找一組字串 對應位置換成時間
dt <- as.POSIXct(appledaily$dt, 
                 format = "%Y年%m月%d日%H:%M")

# 時區問題
# 若要將 年月日時分開儲存
# 使用 POSIXlt
unclass(as.POSIXlt(appledaily$dt[1], 
                   format = "%Y年%m月%d日%H:%M")
)$hour

appledaily$hour <- unclass(as.POSIXlt(appledaily$dt, 
                                      format = "%Y年%m月%d日%H:%M")
)$hour

str(appledaily)

appledaily$dt <- as.POSIXct(appledaily$dt, 
                            format = "%Y年%m月%d日%H:%M")

now <- Sys.time()
tm <- as.integer(unclass(now))
now - appledaily$dt[1]
# as.Date 會轉換為以日為標準
now <- as.Date(now)
now - appledaily$dt[1]

# JST
as.POSIXct(tm,origin="1970-1-1",tz = "Japan")

# Taipei
as.POSIXct(tm,origin="1970-1-1",tz = "Asia/Taipei")

# 更好的套件

library(lubridate)
library(tidyverse)
now()
now_date <- Sys.time()
month(now_date,label = T)
ymd(20190521)
mdy(052195)
# 加入時分秒
ymd_hms("18.11.30 14:35:11")
# 加入時區(自定義時區)
ymd_hms("18.11.30 14:35:11",tz="Asia/Taipei")

la_dt = ymd_hms("18.11.30 14:35:11",tz="America/Los_Angeles")

# 換成台灣時間
with_tz(la_dt, tzone = "Asia/Taipei")

appledaily$dt <- ymd_hm(appledaily$dt,tz="Asia/Taipei")
str(appledaily)


# 清理文字 正規表示法
appledaily$clicked[1]
# R的 escape \\ 
# 第一個方法 sub
tmp <- sub("人氣\\(","",appledaily$clicked[1])
tmp2 <- sub("\\)","",tmp)


# 第二個方法 regular expression
# str_match(string,pattern)
appledaily$clicked <- as.numeric(str_match(appledaily$clicked,"人氣\\((\\d+)\\)")[,2])

str(appledaily)

# grep 取特定字串 return index
grep("中國",appledaily$title)
appledaily$title[grep("中國",appledaily$title)]

# grepl() return boolean
grepl("a",c("abcd","bdd","poaf"))


# strsplit() = python .split()

unlist(strsplit(c("asf-asg","aop-gas"),"-"))
sapply(strsplit(c("asf-asg","aop-gas"),"-"),
       function(e){e[2]})



# 正規化部分怪異資料
table(appledaily$category)
names(table(appledaily$category))

appledaily$category[appledaily$category == "國際\",\"LA\",\"SF\",\"NY\",\"US"] = "國際"

appledaily$category[appledaily$category == "國際\",\"SF\",\"US"] = "國際"




## NA值 處理
applenew = appledaily

# 製作假NA值
# 用Sample
# 種子序問題
# 同一種子序 抽樣會被固定
sample(x=1:100,size = 10)
# 固定抽樣 index
no_list = sample(1:nrow(applenew),size = 30)
applenew[no_list,"clicked"] = NA
# 檢查 NA 值
is.na(applenew)

complete.cases(applenew)

# NA值 全部移除
clean_data <- applenew[complete.cases(applenew),]
# 並不推薦


# 填補
# 全體平均數
# 有NA 就無法算
mean(applenew$clicked)
mean_clicked <- mean(applenew$clicked,na.rm = T)
applenew$clicked[is.na(applenew$clicked)] = mean_clicked

# 以類別計算平均數
cat_mean <- tapply(applenew$clicked,applenew$category,function(e){as.integer(mean(e,na.rm = T))})
# 總共有幾個類別
length(names(cat_mean))
# 每個類別的 NA 都用該類別的平均來填
# for loop
for(i in 1:length(names(cat_mean))){
  applenew[applenew$category == 
             names(cat_mean)[i] & # 類別相同且有NA時
             is.na(applenew$clicked),"clicked"] = cat_mean[i]
            # clicked 項為 該類別的平均
  
  
}


# 也可以使用中位數
cat_med <- tapply(applenew$clicked,applenew$category, function(e){median(e,na.rm = T)})
for(i in 1:length(names(cat_med))){
  applenew[applenew$category == 
             names(cat_med)[i] & # 類別相同且有NA時
             is.na(applenew$clicked),"clicked"] = cat_med[i]
  # clicked 項為 該類別的中位數
  
  
}















