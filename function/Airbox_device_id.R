##library
source('FindMode.R')
source('db_connect.R')
library(dplyr)
#sql.content='SELECT device_id,PM2.5,longitude,latitude from Airbox '
airbox.byTownship<-function(sql.content){
  #define sql
  db.content <- dbGetQuery(con, sql.content)
  #content
  airbox=as.data.frame(db.content)
  airbox.byTownship<-airbox%>%
    group_by(device_id) %>%
    summarise(PM2.5=mean(PM25),longitude=FindMode(longitude),latitude=FindMode(latitude))%>%
    arrange(desc(PM2.5))
  write_csv(airbox.byTownship,'airbox.byTownship.csv')
}


#test
airbox.byTownship('SELECT device_id,PM2.5,longitude,latitude from Airbox ')
