#資料匯入
library(readr)
air_daily_201707_201806 <- read_csv("~/Documents/資料英雄_2018/EPA/空氣品質監測日值201707~201806/清理後空氣品質監測日值201707~201806.csv",
                                     locale = locale(encoding = "BIG5"),
                                    col_types =cols(
                                      .default = col_character(),
                                      序號 = col_integer(),
                                      監測日期 = col_date(format = ""),
                                      "細懸浮微粒PM 2.5 (μg/m 3 )"=col_number(),
                                      經度 = col_double(),
                                      緯度 = col_double()
                                    ) )
#資料檢視
summary(air_daily_201707_201806)
summary(air_daily_201707_201806$`細懸浮微粒PM 2.5 (μg/m 3 )`)
mean(air_daily_201707_201806$`細懸浮微粒PM 2.5 (μg/m 3 )`,na.rm = TRUE)
#PM2.5 histogram
ggplot(aes(x=`細懸浮微粒PM 2.5 (μg/m 3 )`), data=air_daily_201707_201806) +
  geom_density(na.rm = TRUE,fill='red',alpha=.2)+
  theme(text=element_text(family="黑體-繁 中黑", size=10))
#PM2.5 時間序列
ggplot(air_daily_201707_201806,mapping = aes(x = 監測日期, y = `細懸浮微粒PM 2.5 (μg/m 3 )`))+
  geom_line(color='darkred',alpha=.5) +
  geom_point(alpha=.01,color='red')
# 空間視覺化
twmap <- get_map(location = 'Taiwan', zoom = 8,language = "zh-TW",maptype = 'terrain')
ggmap(twmap)+
  geom_point(aes(x=經度,y=緯度),data=air_daily_201707_201806,alpha=.01,color='red')

