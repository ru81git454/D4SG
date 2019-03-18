library(rgdal)
library(maptools)
library(rgeos)
library(scales)
library(ggplot2)
#function 
Township_data<-function(path){
  #read Township shapefile
  Township.shp <- readOGR(path)
  #Townid
  tw_new.df <- fortify(Township.shp, region = "TOWNID")
  #Townname
  mydata<-data.frame(township=Township.shp$TOWNNAME, id=Township.shp$TOWNID)
  mydata_PM25<-merge(mydata,airbox.Township,by="township",all.x=T)
  #combine Townname+Townid
  Township<-merge(tw_new.df,mydata_PM25,by="id",all.x=T)
}

#test|check
library(readr)
pm25_mean <- read_csv("~/Desktop/pm25_mean.csv", 
                      col_types = cols(X1 = col_skip()))
mydata<-data.frame(township=Township.shp$TOWNNAME, id=Township.shp$TOWNID,towncode=Township.shp$TOWNCODE)
mydata_PM25<-merge(mydata,pm25_mean,by="towncode",all.x=T)
Township<-merge(tw_new.df,mydata_PM25,by="id",all.x=T)
head(pm25_mean)
head(mydata)
head(mydata_PM25)
head(Township)
