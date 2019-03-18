#for grid

library(readr)
library(dplyr)
#資料匯入
X2017_AirBox <- read_csv("2017-AirBox.csv")
#算眾數的function
FindMode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}
#資料分析_annual>10 group_by 測站
a<-group_by(X2017_AirBox, device_id)
airbox_by_device<-summarise(a,PM2.5=mean(PM2.5),lat=FindMode(lat),lon=FindMode(lon))
#PM2.5>10
#這裡改你想設定的ＰＭ２．５濃度多少以上（10,30,50,70)
airbox_certain<-airbox_by_device[which(airbox_by_device$PM2.5>10),]
library(ggmap)
library(RColorBrewer)
#資料視覺化 網格
airpollution_2d<-function(data,location,zoom,bin){
  MyMap <- get_map(location = location,
                   source = "google", maptype = "toner-lite", language = "zh-TW", crop = FALSE, zoom = zoom)
  YlOrBr <- c("#feedde", "#fdd0a2", "#fdae6b", "#fd8d3c", "#e6550d","#a63603")
  ggmap(MyMap) %+% data +
    aes(x = lon, y = lat, z = PM2.5) +
    stat_summary_2d(fun = mean, binwidth = c(bin, bin) ,alpha=.7) +
    scale_fill_gradientn(name = "Median", colours = YlOrBr, space = "Lab") +
    labs(x = "Longitude", y = "Latitude") +
    coord_map()
}
#資料視覺化 網格
#location='taiwan',zoom=8,'bin=0.05
#location 打你想看的地方,zoom打你想看的放大比例,bin打你想看的網格大小
airpollution_2d(airbox_certain,'Taiwan',8,.05)
airpollution_2d(airbox_certain,'環東大道',12,.01)
airpollution_2d(airbox_certain,'南港軍人公墓',15,.01)
airpollution_2d(airbox_certain,'南港軍人公墓',15,.005)
