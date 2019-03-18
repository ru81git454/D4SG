#sql.content='SELECT * from cems_metadata'
CEMS.byTownship<-function(sql.content){
  #define sql
  db.content <- dbGetQuery(con, sql.content)
  #content   
  CEMS.df=as.data.frame(db.content)
  CEMS<-CEMS.df%>%
    group_by(township) %>%
    summarise(cems_number=length(abbr),longitude=median(longitude),latitude=median(latitude)) %>%
    arrange(desc(cems_number))
}

#test
CEMS.byTownship('SELECT * from cems_metadata')

