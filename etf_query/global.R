suppressWarnings({
	library(RPostgreSQL)
	library(shiny)
	library(shinydashboard)
	library(shinyAce)
})

######
# configs
#####
dbname <- "etf"
host <- "localhost"
port <- 5432

#TODO: error checking
# TO CLOSE CONNECTIONS lapply(dbListConnections(PostgreSQL()), dbDisconnect)
conn <- dbConnect(PostgreSQL(), dbname = dbname, host = host, port = port)
db_tables <- dbGetQuery(conn, "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'")
