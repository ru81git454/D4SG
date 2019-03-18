library(rgdal)
library(ggplot2)
library(maptools)
library(rgeos)
library(scales)
library(ggmap)
library(RColorBrewer)
##set the shapefile
#read Township shapefile
Township.shp <- readOGR("/Users/pei/Documents/📔資料英雄_2018/function/mapdata/TOWN_MOI_1070516.shp")
Township.shp$TOWNID
#Townid
tw_new.df <- fortify(Township.shp, region = "TOWNID")
head(tw_new.df,10)
#Townname
mydata<-data.frame(NAME_2=Township.shp$TOWNNAME, id=Township.shp$TOWNID,
                   PM2.5=rnorm(length(Township.shp$TOWNID)))
head(mydata)
#combine Townname+Townid
final.plot<-merge(tw_new.df,mydata,by="id",all.x=T)
head(final.plot,10)
#google api
register_google(key="AIzaSyBMd54qL97Jal9Zuql_MCMFqMlLkRF8ihE")

twmap <- get_map(location = 'Taiwan', zoom = 8,language = "zh-TW",api_key = API)
ggmap(twmap)+ #ggmap
  geom_polygon(data = final.plot,  #面量圖
               aes(x = long, y = lat, group = group, fill = PM2.5), 
               color = "grey80", size = 0.1,alpha = 0.5) + 
  scale_fill_gradientn(colours = brewer.pal(9,"Reds"))

#read_shp
read_township_shp=function(shpfile_path){
  Township.shp <- readOGR(shpfile_path)
  tw_new.df <- fortify(Township.shp, region = "TOWNID")
  mydata<-data.frame(NAME_2=Township.shp$TOWNNAME, id=Township.shp$TOWNID)
  final.plot<-merge(tw_new.df,mydata,by="id",all.x=T)
}

#plot
mapper_plot<-function()


