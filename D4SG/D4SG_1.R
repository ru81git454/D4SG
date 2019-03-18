#CEMS_資料清理_高雄
CEMS列管單位資料集_高雄<-CEMS列管單位資料集[which(CEMS列管單位資料集$County=='高雄市'),]
summary(CEMS列管單位資料集_高雄)
###CEMS+空氣品質測站_資料分析_工廠分佈
twmap <- get_map(location = c(lon=120.4,lat=22.63), zoom = 11,language = "zh-TW",maptype = 'roadmap')
ggmap(twmap)+
  geom_point(aes(x=longitude,y=latitude),data=CEMS列管單位資料集_高雄,alpha=.5,size=3)+
  geom_point(aes(x=經度,y=緯度),data=空氣品質測站基本資料_高雄,alpha=.5,color='darkred',size=15)

#CEMS_資料分析_Township ＃小港區最多列管工廠
ggplot(CEMS列管單位資料集_高雄, aes(x=Township)) +
  geom_bar()+
  theme(text=element_text(family="黑體-繁 中黑", size=10))

#空氣品質測站_資料清理_高雄
空氣品質測站基本資料_高雄<-空氣品質測站基本資料[which(空氣品質測站基本資料$縣市=='高雄市'),]
summary(空氣品質測站基本資料_高雄)

#＃空氣品質測站與CEMS工廠分佈問題 高屏空品區（屏東列入與否）

#清理後空氣品質監測日值_資料清理_高雄
清理後空氣品質監測日值_高雄<-清理後空氣品質監測日值201707_201806[which(清理後空氣品質監測日值201707_201806$縣市=='高雄市'),]
summary(清理後空氣品質監測日值_高雄)
#清理後空氣品質監測日值_資料清理_排除NA
清理後空氣品質監測日值_高雄<-清理後空氣品質監測日值_高雄[which(清理後空氣品質監測日值_高雄[,10]!='-'),]
#清理後空氣品質監測日值_資料清理_char->numeric
清理後空氣品質監測日值_高雄[,10]<-apply(清理後空氣品質監測日值_高雄[,10],1,as.numeric)

#清理後空氣品質監測日值_資料分析_各測站
測站_PM2.5<-aggregate(清理後空氣品質監測日值_高雄[,10], by=list(清理後空氣品質監測日值_高雄$測站),mean)
ggplot(測站_PM2.5, mapping=aes(x=Group.1,y=測站_日值[,2])) +
  geom_bar(stat= 'identity')+
  theme(text=element_text(family="黑體-繁 中黑", size=10))
#清理後空氣品質監測日值_資料分析_時間分析
日期_PM2.5<-aggregate(清理後空氣品質監測日值_高雄[,10], by=list(清理後空氣品質監測日值_高雄$監測日期), FUN=mean)
ggplot(日期_PM2.5,mapping = aes(x = Group.1, y = 日期_PM2.5[,2])) +
  geom_line() +
  geom_point()

#降雨量_資料匯入合併
csvpath="/Users/pei/Documents/資料英雄_2018/D4SG/EPA/風向、降水量資料201707-201806/"
csvfilesn = list.files( path = csvpath, pattern="*.csv")
tmprt = function(rtcsv){
  read.csv( rtcsv, stringsAsFactors = FALSE)
}
lhudata = lapply(paste(csvpath,csvfilesn, sep = ""), tmprt)
csvfilesn
rain_all<-rbind(lhudata[[1]],lhudata[[2]],lhudata[[3]],lhudata[[4]],
                lhudata[[5]],lhudata[[6]],lhudata[[7]],lhudata[[8]],
                lhudata[[9]],lhudata[[10]],lhudata[[11]],lhudata[[12]])
#降雨量_資料清理_高雄
rain_all<-rain_all[which(rain_all$測站=='高雄'),]

#X106空品資料_資料清理_高雄_PM2.5
X106空品資料_高雄<-X106空品資料[which(X106空品資料[2]==site &X106空品資料[3]=='PM2.5'),]
