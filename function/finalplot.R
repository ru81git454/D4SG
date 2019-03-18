library(ggmap)
library(RColorBrewer)
library(ggplot2)
# input 想看的區域,放大比例
PM25<-function(location,zoom){
  #google api
  register_google(key="AIzaSyBMd54qL97Jal9Zuql_MCMFqMlLkRF8ihE")
  twmap <- get_map(location = location, zoom = zoom,language = "zh-TW",api_key = API)
  ggmap(twmap)+ #ggmap
    geom_polygon(data = Township,  #面量圖
                 aes(x = long, y = lat, group = group, fill = PM2.5), 
                 color = "grey80", size = 0.1,alpha = 0.5)+
    scale_fill_gradientn(colours = brewer.pal(9,"Reds"))
}

#CEMS_amount
cems_amount<-function(location,zoom){
  #google api
  register_google(key="AIzaSyBMd54qL97Jal9Zuql_MCMFqMlLkRF8ihE")
  twmap <- get_map(location = location, zoom = zoom,language = "zh-TW",api_key = API)
  ggmap(twmap)+
    geom_polygon(data = Township,  #面量圖
                 aes(x = long, y = lat, group = group), 
                 color = "grey80", size = 0.1,alpha = 0.5)+
    geom_point(data = CEMS,
               aes(x=longitude,y=latitude,color = cems_number))+
    geom_text(data = CEMS,
              aes(x=longitude,y=latitude,label = cems_number))+
    scale_color_gradient(low='blue', high='Darkblue')
  }
#factory_amount
factory_amount<-function(location,zoom){
  #google api
  register_google(key="AIzaSyBMd54qL97Jal9Zuql_MCMFqMlLkRF8ihE")
  twmap <- get_map(location = location, zoom = zoom,language = "zh-TW",api_key = API)
  ggmap(twmap)+
    geom_polygon(data = Township,  #面量圖
                 aes(x = long, y = lat, group = group), 
                 color = "grey80", size = 0.1,alpha = 0.5)+
    geom_point(data = factory,
               aes(x=longitude,y=latitude,color = factory_number))+
    geom_text(data = factory,
              aes(x=longitude,y=latitude,label = factory_number))+
    scale_color_gradient(low='blue', high='Darkblue')
} 
#cems compare airbox
cems_airbox<-function(location,zoom){
  #google api
  register_google(key="AIzaSyBMd54qL97Jal9Zuql_MCMFqMlLkRF8ihE")
  
  twmap <- get_map(location = location, zoom = zoom,language = "zh-TW",api_key = API)
  ggmap(twmap)+ #ggmap
    geom_polygon(data = Township,  #面量圖
                 aes(x = long, y = lat, group = group, fill = PM2.5), 
                 color = "grey80", size = 0.1,alpha = 0.5) + 
    scale_fill_gradientn(colours = brewer.pal(9,"Reds"))+
    geom_point(data = CEMS,
             aes(x=longitude,y=latitude,color = cems_number))+
    geom_text(data = CEMS,
              aes(x=longitude,y=latitude,label = cems_number))+
    scale_color_gradient(low='Blue', high='Darkblue')
}
#factory compare airbox
factory_amount<-function(location,zoom){
  #google api
  register_google(key="AIzaSyBMd54qL97Jal9Zuql_MCMFqMlLkRF8ihE")
  twmap <- get_map(location = location, zoom = zoom,language = "zh-TW",api_key = API)
  ggmap(twmap)+
    geom_polygon(data = Township,  #面量圖
                 aes(x = long, y = lat, group = group,fill = PM2.5), 
                 color = "grey80", size = 0.1,alpha = 0.5)+
    scale_fill_gradientn(colours = brewer.pal(9,"Reds"))+
    geom_point(data = factory,
               aes(x=longitude,y=latitude,color = factory_number))+
    geom_text(data = factory,
              aes(x=longitude,y=latitude,label = factory_number))+
    scale_color_gradient(low='blue', high='Darkblue')
} 



#test
PM25('Taiwan',8)
CEMS.test
cems_amount('Taiwan',8)
cems_airbox('Kaohsiung',10)
cems_amount<-function(location,zoom){
  #google api
  register_google(key="AIzaSyBMd54qL97Jal9Zuql_MCMFqMlLkRF8ihE")
  twmap <- get_map(location = location, zoom = zoom,language = "zh-TW",api_key = API)
  ggmap(twmap)+
    geom_polygon(data = Township,  #面量圖
                 aes(x = long, y = lat, group = group), 
                 color = "grey80", size = 0.1,alpha = 0.5)+
    geom_point(data = CEMS.test,
               aes(x=longitude,y=latitude,color = cems_number))+
    geom_text(data = CEMS.test,
              aes(x=longitude,y=latitude,label = cems_number))+
    scale_color_gradient(low='blue', high='Darkblue')
}
cems_airbox<-function(location,zoom){
  #google api
  register_google(key="AIzaSyBMd54qL97Jal9Zuql_MCMFqMlLkRF8ihE")
  
  twmap <- get_map(location = location, zoom = zoom,language = "zh-TW",api_key = API)
  ggmap(twmap)+ #ggmap
    geom_polygon(data = Township,  #面量圖
                 aes(x = long, y = lat, group = group, fill = PM2.5), 
                 color = "grey80", size = 0.1,alpha = 0.5) + 
    scale_fill_gradientn(colours = brewer.pal(9,"Reds"))+
    geom_point(data = CEMS.test,
               aes(x=longitude,y=latitude,color = cems_number))+
    geom_text(data = CEMS.test,
              aes(x=longitude,y=latitude,label = cems_number))+
    scale_color_gradient(low='lightgreen', high='green')
}
