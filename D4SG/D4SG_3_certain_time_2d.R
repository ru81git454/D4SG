#資料處理 certain time 6/15-9/10
a_06150910<-a[which(a$Date>='2017-06-15' & a$Date<='2017-09-10'),]
library(dplyr)
#資料分析_6/15-9/10 group_by 測站
a_06150910<-group_by(X2017_AirBox, device_id)
#4060測站中3909超標>10
airbox_by_device<-summarise(a_06150910,PM2.5=mean(PM2.5),lat=FindMode(lat),lon=FindMode(lon))
airbox_certain_10<-airbox_by_device[which(airbox_by_device$PM2.5>10),]
#4060測站中1494超標>30
airbox_certain_30<-airbox_by_device[which(airbox_by_device$PM2.5>30),]
#4060測站中168超標>50
airbox_certain_50<-airbox_by_device[which(airbox_by_device$PM2.5>50),]
#4060測站中65超標>50
airbox_certain_70<-airbox_by_device[which(airbox_by_device$PM2.5>70),]

#資料視覺化 certain time網格
airpollution_2d(airbox_certain_10,'Taiwan',8,.05)
airpollution_2d(airbox_certain_30,'Taiwan',8,.05)
airpollution_2d(airbox_certain_50,'Taiwan',8,.05)
airpollution_2d(airbox_certain_70,'Taiwan',8,.05)

install.packages("openair")
library('openair')
