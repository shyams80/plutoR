source("r/config.R")

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
