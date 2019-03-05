# dplyr

library(dplyr)

# %>% pipe 的使用非常大量
# debug 方便
load("./Statistics/applenews.RData")
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
head(select(iris,ends_with("Length")))


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

# Mutate 產生新欄位
freqsum = applenews %>%
  select(clicked) %>%
  sum()
# arrange -> 相當於 orderby
applenews %>%
  select(title,category,clicked) %>%
  mutate(portion = clicked / freqsum) %>%
  arrange(desc(portion)) %>%
  head()


# group_by , summarize
# group_by 分組依據
# summarize 計算分組總和
applenews %>%
  group_by(category) %>%
  summarise(clicked_sum = sum(clicked, na.rm = T)) %>%
  arrange(desc(clicked_sum))

# summarize_at 指定特定欄位
# 參數建議 .var .fun
# .var 選擇欄位 .fun 選擇運算方法
applenews = applenews %>%
  select(title,category,clicked) %>%
  mutate(portion = clicked / freqsum) 

applenews %>%
  group_by(category) %>%
  summarise_at(.vars = vars(clicked,portion), .funs = funs(sum,mean,
                                                           min,max))

# 圖形化

cat_state <- applenews %>%
  group_by(category) %>%
  summarise(clicked_sum = sum(clicked, na.rm = T))

# 長條圖
barplot(cat_state$clicked_sum, 
        names.arg=cat_state$category, 
        col=rainbow(length(cat_state$category)),
        family="Songti SC")

# 圓餅圖
pie(cat_state$clicked_sum, 
    labels = cat_state$category 
    )

# ggplot bar
g <- ggplot(cat_state,aes(y=clicked_sum,x=category))
g + geom_bar(stat = "identity",aes(fill=category))


ggplot(cat_state, aes(x=1,y=clicked_sum,fill = category)) + geom_bar(stat = "identity") + coord_polar(theta ="y" ) 

