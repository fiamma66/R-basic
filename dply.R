# dplyr

library(dplyr)

# %>% pipe 的使用非常大量
# debug 方便
load("riii/Statistics/applenews.RData")
str(applenews)
applenews = applenews[,-1]

# filter使用
# AND -> &  ,
filter(applenews,category == "娛樂" & clicked > 10000)
filter(applenews,category == "娛樂" , clicked > 10000)

# or
filter(applenews,category == "娛樂" | clicked > 10000)

# %in% 參數
head(filter(applenews , category %in% c("娛樂","社會")))

# select
head(select(applenews,category,clicked))
# 從dt 到 clicked 的所有欄位
head(select(applenews,dt:clicked))

# 選擇欄位名稱有 click 字串的欄位
head(select(applenews,contains("click")))

# iris selectd helpers
head(select(iris,starts_with("Sepal")))


# 使用 pipe 來整理
# 本來要把前面的結果
# 以 . 來表示
# 若為第一個 則可以省略
select(applenews,category:clicked) %>%
  filter(category == "娛樂") %>%
  head()
#
# 在整理得好一點
applenews %>%
  select(category:clicked) %>%
  filter(category == "娛樂") %>%
  head()

