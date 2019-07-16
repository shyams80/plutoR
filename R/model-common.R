model.common.con.StockViz <- function() {
   DBI::dbConnect(odbc::odbc(),
  	Driver = config.db.StockViz.driver,
  	Server = config.db.StockViz.server,
  	Database = config.db.StockViz.dbName,
  	UID = config.db.StockViz.user,
  	PWD = config.db.StockViz.password)
}

model.common.con.StockVizUs <- function() {
   DBI::dbConnect(odbc::odbc(),
   Driver = config.db.StockVizUs.driver,
   Server = config.db.StockVizUs.server,
   Database = config.db.StockVizUs.dbName,
   UID = config.db.StockVizUs.user,
   PWD = config.db.StockVizUs.password)
}


model.common.con.StockVizUs2 <- function() {
   DBI::dbConnect(odbc::odbc(),
   Driver = config.db.StockVizUs2.driver,
   Server = config.db.StockVizUs2.server,
   Database = config.db.StockVizUs2.dbName,
   UID = config.db.StockVizUs2.user,
   PWD = config.db.StockVizUs2.password)
}

model.common.con.StockVizDyn <- function() {
   DBI::dbConnect(RPostgres::Postgres(),
#   Driver = config.db.StockVizDyn.driver,
   host = config.db.StockVizDyn.server,
   dbname = config.db.StockVizDyn.dbName,
   user = config.db.StockVizDyn.user,
   password = config.db.StockVizDyn.password,
   sslmode='allow')
}
