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

ggplot(airbox_annual_10,aes(x=lon,y=lat,z=PM2.5))+
  ylim(22,24)+
  xlim(120,122)+
  stat_summary_2d( binwidth = c(.05, .05))


#Taiwan
airpollution_2d(airbox_annual_10,'Taiwan',8,.05)
airpollution_2d(airbox_annual_30,'Taiwan',8,.05)
airpollution_2d(airbox_annual_50,'Taiwan',8,.05)
airpollution_2d(airbox_annual_70,'Taiwan',8,.05)
#台北 AQT
airpollution_2d(airbox_annual_70,'Taipei',10,.05)
airpollution_2d(airbox_annual_70,'Taipei',12,.05)
airpollution_2d(airbox_annual_70,'Taipei',12,.03)
airpollution_2d(airbox_annual_70,'Taipei',12,.01)
#台北 AQT 熱區
airpollution_2d(airbox_annual_10,'環東大道',12,.01)
airpollution_2d(airbox_annual_10,'南港軍人公墓',15,.01)
airpollution_2d(airbox_annual_10,'南港軍人公墓',15,.005)
#台北 IT1 熱區
airpollution_2d(airbox_annual_70,'新北產業園區',15,.005)
airpollution_2d(airbox_annual_70,'龍山寺',15,.005)
airpollution_2d(airbox_annual_70,'舊莊',15,.005)
#新竹 IT1
airpollution_2d(airbox_annual_70,'新竹',10,.05)
airpollution_2d(airbox_annual_70,'新竹',12,.05)
airpollution_2d(airbox_annual_70,'新竹',12,.03)
airpollution_2d(airbox_annual_70,'新竹',12,.01)
#新竹 IT1 熱區
airpollution_2d(airbox_annual_70,c(lon = 120.9840519, lat = 24.7768982),17,.001)
#台中 IT1
airpollution_2d(airbox_annual_70,'台中',10,.05)
airpollution_2d(airbox_annual_70,'台中',12,.05)
airpollution_2d(airbox_annual_70,c(lon = 120.7201704, lat = 24.1914447),12,.03)
airpollution_2d(airbox_annual_70,c(lon = 120.7386833, lat = 24.1597213),12,.01)
#台中 IT1 熱區
airpollution_2d(airbox_annual_70,c(lon = 120.7202269, lat = 24.1592224),15,.005)
#嘉義 IT1
airpollution_2d(airbox_annual_70,'民雄',10,.05)
airpollution_2d(airbox_annual_70,'民雄',12,.05)
airpollution_2d(airbox_annual_70,'民雄',12,.03)
airpollution_2d(airbox_annual_70,'民雄',12,.01)
#嘉義 IT1 熱區
airpollution_2d(airbox_annual_70,c(lon = 120.4412698, lat = 23.5763963),15,.005)
#台南 IT1
airpollution_2d(airbox_annual_70,c(lon = 120.7386833, lat = 24.1597213),12,.01)
airpollution_2d(airbox_annual_70,'台南',12,.05)
airpollution_2d(airbox_annual_70,'台南',12,.03)
airpollution_2d(airbox_annual_70,'台南',12,.01)
#台南 IT1 熱區
airpollution_2d(airbox_annual_70,'林默娘公園',15,.005)
airpollution_2d(airbox_annual_70,c(lon = 120.2070142, lat = 22.9701915),15,.005)
#高雄 IT1
airpollution_2d(airbox_annual_70,'高雄',10,.05)
airpollution_2d(airbox_annual_70,'高雄',12,.05)
airpollution_2d(airbox_annual_70,'高雄',12,.03)
airpollution_2d(airbox_annual_70,'高雄',12,.01)
airpollution_2d(airbox_annual_70,c(lon = 120.358858, lat = 22.5068145),12,.05)
#高雄 IT1 熱區
airpollution_2d(airbox_annual_70,'高雄地方法院',15,.005)
airpollution_2d(airbox_annual_70,c(lon = 120.3577902, lat = 22.5108597),15,.005)





# 資料視覺化 airbox plot density
library(ggmap)
library(RColorBrewer)

MyMap <- get_map(location = "Taiwan",
                 source = "google", maptype ="toner-lite", crop = FALSE, zoom = 7)

YlOrBr <- c("#FFFFD4", "#FED98E", "#FE9929", "#D95F0E", "#993404")

ggmap(MyMap) +
  stat_density2d(data = airbox_annual_10, aes(x = lon, y = lat, fill = ..level.., alpha = ..level..),
                 geom = "polygon", size = 0.01, bins = 16) +
  scale_fill_gradient(low = "red", high = "green") +
  scale_alpha(range = c(0, 0.3), guide = FALSE)
