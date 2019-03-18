#資料匯入
library(readr)
X2017_AirBox <- read_csv("~/Documents/資料英雄_2018/PM2.5 data from 中研院/2017-AirBox.csv")

#資料檢視
summary(X2017_AirBox)
summary(X2017_AirBox$PM2.5)
FindMode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}
#資料分析_annual>10 group_by 測站
#4060測站中3909超標>10
library(dplyr)
a<-group_by(X2017_AirBox, device_id)
airbox_by_device<-summarise(a,PM2.5=mean(PM2.5),lat=FindMode(lat),lon=FindMode(lon))
airbox_annual_10<-airbox_by_device[which(airbox_by_device$PM2.5>10),]
#4060測站中1494超標>30
airbox_annual_30<-airbox_by_device[which(airbox_by_device$PM2.5>30),]
#4060測站中168超標>50
airbox_annual_50<-airbox_by_device[which(airbox_by_device$PM2.5>50),]
#4060測站中65超標>50
airbox_annual_70<-airbox_by_device[which(airbox_by_device$PM2.5>70),]

#資料視覺化_annual>10 group_by 測站
airpollution_ggmap<-function(data,location,zoom,alpha){
  twmap <- get_map(location =location , zoom = zoom,language = "zh-TW",maptype = 'terrain')
  ggmap(twmap)+
    geom_point(aes(x=as.double(lon),y=as.double(lat)),data=data,alpha=alpha,color='red')+
    geom_vline(xintercept=seq(120, 122, by=0.01),color='grey')+
    geom_hline(yintercept=seq(20, 26, by=0.01),color='grey')

}
#1149個點被移除 ＃經緯度飄移
airpollution_ggmap(airbox_annual_70,'Taiwan',8,1)
airpollution_ggmap(airbox_annual_50,'Taiwan',8,1)
airpollution_ggmap(airbox_annual_30,'Taiwan',8,.1)
airpollution_ggmap(airbox_annual_10,'Taiwan',8,.1)
##taipei
airpollution_ggmap(airbox_annual_10,'Taipei',10,.1)
airpollution_ggmap(airbox_annual_10,'Taipei',12,.3)
airpollution_ggmap(airbox_annual_30,'Taipei',12,.3)
#taipei_hotpot
airpollution_ggmap(airbox_annual_30,'龍山寺站',16,.5)
airpollution_ggmap(airbox_annual_30,'舊莊',16,.2)
#桃園
airpollution_ggmap(airbox_annual_10,'桃園',10,.1)
airpollution_ggmap(airbox_annual_10,'桃園',12,.4)
airpollution_ggmap(airbox_annual_30,'桃園',12,.5)
#桃園_hotpot
airpollution_ggmap(airbox_annual_30,'林口三井',15,.5)
airpollution_ggmap(airbox_annual_30,'卓厝',15,.5)

  ##Kaohsiung_size=10
Kaohsiung_10_map<- airpollution_ggmap(airbox_annual_10,'Kaohsiung',10,.1)
Kaohsiung_10_map
  ##Kaohsiung_size=12
airpollution_ggmap(airbox_annual_10,'Kaohsiung',12,.3)


#資料檢視_緯度
sort(unique(airbox_annual_10$lat))

#資料分析_24_hours>25 group_by 測站
airbox_by_device_2017_12_31<-a[which(a$Date=="2017-12-31"),]
#1167筆 719超標
airbox_24_hour_2017_12_31<-summarise(airbox_by_device_2017_12_31,PM2.5=mean(PM2.5),lat=FindMode(lat),lon=FindMode(lon))
air_daily_2017_12_31_25<-airbox_24_hour_2017_12_31[which(airbox_24_hour_2017_12_31$PM2.5>25),]
#1167筆 346超標
air_daily_2017_12_31_37.5<-airbox_24_hour_2017_12_31[which(airbox_24_hour_2017_12_31$PM2.5>37.5),]
#1167筆 164超標
air_daily_2017_12_31_50<-airbox_24_hour_2017_12_31[which(airbox_24_hour_2017_12_31$PM2.5>50),]
#1167筆 13超標
air_daily_2017_12_31_75<-airbox_24_hour_2017_12_31[which(airbox_24_hour_2017_12_31$PM2.5>75),]

#資料視覺化_24_hours>25 group_by 測站
#50個點被移除 ＃經緯度飄移
library(ggmap)
airpollution_ggmap(air_daily_2017_12_31_25,'Taiwan',8,.1)
airpollution_ggmap(air_daily_2017_12_31_37.5,'Taiwan',8,.1)
airpollution_ggmap(air_daily_2017_12_31_50,'Taiwan',8,1)
airpollution_ggmap(air_daily_2017_12_31_75,'Taiwan',8,1)
##taipei
airpollution_ggmap(air_daily_2017_12_31_25,'Taipei',10,.1)
airpollution_ggmap(air_daily_2017_12_31_25,'Taipei',12,.3)
airpollution_ggmap(air_daily_2017_12_31_50,'Taipei',12,1)
#taipei_hotpot
airpollution_ggmap(air_daily_2017_12_31_50,'訊舟科技',16,1)


