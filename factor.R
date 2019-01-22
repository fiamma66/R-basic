# Factor

weather = c("sunny",
            "rainy",
            "cloudy",
            "rainy",
            "cloudy")

# 類別有大小關係
# 字串 > 複數 > 數值 > 布林
# 小的會被轉換為大的

weather = factor(weather)

weather[4] <- "typhoon"

# 使用 levels 取值
levels(weather)

levels(weather) <- c(levels(weather),
                     "typhoon")

gender <- c(0,1,1,0,0,0)
gender <- factor(gender)
levels(gender) <- c("Female",
                    "Male")

# 替換 level 會將原始資料
# 一起做替換
# 注意替換的順序
gender
