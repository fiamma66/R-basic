# dplyr 連線 SQL

install.packages("RMariaDB")
install.packages("dbplyr")
library('RMariaDB')
library('dbplyr')

conn = dbConnect(MariaDB(),dbname="test_r",host="127.0.0.1",
                    port=3306,user="root",password="root")
data("iris")
copy_to(conn, iris, temporary = F)

# collect() 為 Action 真正執行
tbl(conn,"iris") %>%
  select(starts_with("Sepal"), "Species") %>%
  group_by(Species) %>%
  summarise_at(.funs = funs(mean(.,na.rm = T),sd(.,na.rm = T),),
               .vars = vars(starts_with("Sepal"))) %>%
  collect()

# 也可以直接下SQL指令
dbGetQuery(conn , "select * from iris") %>%
  filter(Species == "setosa")

# 等同於 showtables
dbListTables(conn)


# applenews example
copy_to(conn,applenews , temporary = F)
# 查看table 大略內容
tbl(conn,"applenews")
# 排除編碼錯誤的亂碼問題
dbSendQuery(conn, "SET NAMES utf8")

category_stat = tbl(conn,"applenews") %>%
  group_by(category) %>%
  summarise_at(.funs = funs(min(.,na.rm = T),max(.,na.rm = T),mean(.,na.rm = T)),
               .vars = vars(matches("clicked"))) %>%
  arrange(desc(mean)) %>%
  collect()


# ggplot 2 
library(ggplot2)

g <- ggplot(category_stat, aes(x=category , y=mean))
g + geom_bar(stat = "identity")

# 根據我們查詢的排序結果來顯示長條圖
g + geom_bar(stat = "identity") + scale_x_discrete(limits=category_stat$category)

# 填滿顏色 區分類別
g + geom_bar(stat = "identity",aes(fill=category)) + scale_x_discrete(limits=category_stat$category) + geom_text(size=3,aes(label = mean),position = position_stack(vjust=0.5))


