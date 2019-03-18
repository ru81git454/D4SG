library(rgdal)
library(maptools)
library(rgeos)
library(scales)

##function
factory_area_data<-function(path){
  #read factory_area shapefile
  factory_area.shp <- readOGR('工業區範圍圖-修正/工業區範圍圖.shp')
  factory_area.shp$FNAME
  #Factory_name
  Factory<- fortify(factory_area.shp, region = "FNAME")
  Factory_name
}
Factory
#test|check
Factory_name
a=head(Township_data("mapdata/TOWN_MOI_1070516.shp"))
a
b=factory_area_data('工業區範圍圖-修正/工業區範圍圖.shp')
head(b)
#plot
#google api
register_google(key="AIzaSyBMd54qL97Jal9Zuql_MCMFqMlLkRF8ihE")

twmap <- get_map(location = 'Taiwan', zoom = 8,language = "zh-TW",api_key = API)
ggmap(twmap)+ #ggmap
  geom_polygon(data = b,  #面量圖
               aes(x = long, y = lat, group = group), 
               color = "grey80", size = 0.1,alpha = 0.5) + 
  scale_fill_gradientn(colours = brewer.pal(9,"Reds"))
