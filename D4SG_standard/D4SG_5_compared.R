#group_by device & month statics
a_month_device <- a %>%
  group_by(device_id, month) %>%
  summarise(PM2.5=mean(PM2.5),lat=FindMode(lat),lon=FindMode(lon))
test<-tapply(a_month_device$PM2.5,a_month_device$month,summary)
df <- data.frame(matrix(unlist(test ), nrow=12,byrow=T))
colnames(df)<-c("MIN",'1st Qu.','Median','Mean','3rd Qu.',"max")
#