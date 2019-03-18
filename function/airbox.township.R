source('FindMode.R')
library(readr)
library(dplyr)

airbox_township<-function(path){
  #load data
  airbox_data <- read_csv(path, col_types = cols(X1 = col_skip()))
  #airbox_data in township
  airbox.Township<-airbox_data%>%
    group_by(township) %>%
    summarise(PM2.5=mean(PM2.5))%>%
    filter(grepl('[\u4e00-\u9fa5]+',township)) %>%
    #filter(!grepl('卡那封',township)) %>%
    #filter(PM2.5>PM2.5_standard)%>%
    arrange(desc(PM2.5))
}


##test
airbox_township('airbox.township.csv')



