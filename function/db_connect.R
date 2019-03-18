#library
library(RPostgreSQL)
# connect driver (not yet)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname = db.name,
                 host = db.host, port = db.port,
                 user = db.user, password = db.password)