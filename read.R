
getwd()
# 兩個 \\ 或 一個 /
setwd("E:/Rwork/riii")
rm(list = ls())

tw2330_web <- read.csv(file = "https://raw.githubusercontent.com/YuHsuanLin/riii/master/data/2330.csv",
                       header = T)


install.packages("tidyverse")
library("tidyverse")

# 適用檔案較大的讀取
tw2330_readr <- read_csv(file = "./data/2330.csv",col_names = T)

str(tw2330_readr)


# 讀取 Excel 
library(readxl)

excel <- read_excel("./data/FinancialReport.xlsx")

# 讀取 json 原生package
library(jsonlite)
json_data <- fromJSON("./mydatabase.Ptt_fix_3.json")

str(json_data)


# xml
install.packages("XML")
url <- 'http://opendata.epa.gov.tw/ws/Data/ATM00698/?$format=xml'
library(XML)
library(xml2)
weather <- xmlToDataFrame(url)
xmlToDataFrame
xml_url






