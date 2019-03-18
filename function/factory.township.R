library(dplyr)
#sql.content='SELECT * from factory '
#content   
factory.byTownship<-function(sql.content){
  #define sql
  db.content <- dbGetQuery(con, sql.content)
  #content
  factory.df=as.data.frame(db.content)
  factory<-factory.df%>%
    group_by(township) %>%
    summarise(factory_number=length(name),longitude=median(longitude),latitude=median(latitude))%>%
    arrange(desc(factory_number))
}

#test
factory.byTownship('SELECT * from factory')
