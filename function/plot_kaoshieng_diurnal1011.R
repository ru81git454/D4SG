data<-read.csv("taichung_airbox_hrly.dat", header=T, sep=",")
class(data)
dim(data)
names(data)
devtool::install_github("dkahle/ggmap",ref="tidyup")
#library("dkahle")
#goog_key
register_google(key="AIzaSyBMd54qL97Jal9Zuql_MCMFqMlLkRF8ihE")
library(ggmap)
#map <- get_map(location = 'Taiwan', zoom = 8)
map <- get_map(maptype = "satellite",location = c(lon = 120.32, lat = 22.6), zoom = 12)
ggmap(map) + geom_point(aes(x = device_lon, y = device_lat,color=pm25_max,size=pm25_amp/200), data = data) +
  scale_color_gradientn(colours = rainbow(5))
class(data$pm25_amp)
# light color
ggmap(map) + geom_point(aes(x = device_lon, y = device_lat,color=pm25_max,size=pm25_amp/200), data = data) +
  scale_color_gradientn(colours = rainbow(3))
#different map
map <- get_map(maptype = "roadmap",location = c(lon = 120.32, lat = 22.6), zoom = 12)
ggmap(map) + geom_point(aes(x = device_lon, y = device_lat,color=pm25_max,size=pm25_amp/200), data = data) +
  scale_color_gradientn(colours = rainbow(5))
