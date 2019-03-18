library('lubridate')
library('ggplot2')
library('ggmap')
library(dplyr)


a$month<-as.factor(month(a$Date))
#group_by device & month statics
a_month_device <- a %>%
  group_by(device_id, month) %>%
  summarise(PM2.5=mean(PM2.5),lat=FindMode(lat),lon=FindMode(lon))
test<-tapply(a_month_device$PM2.5,a_month_device$month,summary)
df <- data.frame(matrix(unlist(test ), nrow=12,byrow=T))
colnames(df)<-c("MIN",'1st Qu.','Median','Mean','3rd Qu.',"max")

#counts 有資料的
ggplot(aes(x=a_month_device$month,fill=month), data=a_month_device) +
  geom_bar()+
  labs(x = "month", y = "data counts",name='month')
table(a_month_device$month)
#資料視覺化 Rose plot with ggplot2 超標濃度
a_month<-a %>%
  group_by(month) %>%
  summarise(PM2.5=mean(PM2.5),lat=FindMode(lat),lon=FindMode(lon))
ggplot(data=a_month,aes(x=month,y=PM2.5,fill=month))+
  geom_bar(stat = "identity")

#PM2.5 濃度   有130個點超過70
ggplot(aes(x=a_month_device$month,y=a_month_device$PM2.5,fill=month), data=a_month_device) +
  geom_boxplot()+
  labs(x = "month", y = "PM2.5",name='month')

ggplot(aes(x=a_month_device$month,y=a_month_device$PM2.5,fill=month), data=a_month_device) +
  geom_boxplot()+
  labs(x = "month", y = "PM2.5",name='month') +
  ylim(low=0, high=90)
summary(a_month_device$PM2.5)
sts<-as.data.frame(tapply(a_month_device$PM2.5, a_month_device$month,summary ))
#標準化
ggplot(aes(x=a_month_device$month,y=scale(a_month_device$PM2.5),color=month), data=a_month_device) +
  geom_jitter(alpha=0.1)+
  labs(x = "month", y = "PM2.5",name='month')+
  ylim(low=0, high=5)
# 資料處理 >70 50 30 10 ?用四分位
airbox_month_70<-a_month_device[which(a_month_device$PM2.5>70),]
airbox_month_50<-a_month_device[which(a_month_device$PM2.5>50) ,]
airbox_month_30<-a_month_device[which(a_month_device$PM2.5>30),]
airbox_month_10<-a_month_device[which(a_month_device$PM2.5>10) ,]


#資料合併
over_70<-as.data.frame(table(unique(airbox_month_70)$month))
over_50<-as.data.frame(table(unique(airbox_month_50)$month))
over_30<-as.data.frame(table(unique(airbox_month_30)$month))
over_10<-as.data.frame(table(unique(airbox_month_10)$month))

data <- over_10 %>%
  left_join(over_30, by='Var1') %>%
  left_join(over_50, by='Var1') %>%
  left_join(over_70, by='Var1')
colnames(data)<-c("month",10,30,50,70)

#資料視覺化 Rose plot with ggplot2 超標個數
require(reshape2)
#資料重組
data=data[1:12,]
data1=data.frame(t(data))
data2=data1[2:5,]
colnames(data2)=month.name
data2$group=row.names(data2)
data3=melt(data2,id="group")
data3$value=as.numeric(data3$value)
head(data3)
#視覺化
ggplot(data=data3,aes(x=variable,y=value,fill=group))+
  geom_bar(stat="identity")+
  scale_fill_brewer(palette="Greens")+xlab("")+ylab("")
ggplot(data=data3,aes(x=variable,y=value,fill=group))+
  geom_bar(stat="identity",width=1,colour="black",size=0.1)+
  coord_polar()+
  scale_fill_brewer(palette="Greens")+
  xlab("")+ylab("")
data4=melt(data2[3:4,],id="group")
data4$value=as.numeric(data4$value)

ggplot(data=data4,aes(x=variable,y=value,fill=group))+
  geom_bar(stat="identity",width=1,colour="black",size=0.1)+
  coord_polar()+
  scale_fill_brewer(palette="Greens")+
  xlab("")+ylab("")
