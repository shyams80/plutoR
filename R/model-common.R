model.common.con.StockViz <- function() {
   dbConnect(plutoDbR::Pluto(),
             database="NORWAY:StockViz:R",
             backendServer="mssql",
             server=config.webservice)
}

model.common.con.StockVizUs <- function() {
   dbConnect(plutoDbR::Pluto(),
             database="NORWAY:StockVizUs:R",
             backendServer="mssql",
             server=config.webservice)
}

model.common.con.StockVizUs2 <- function() {
   dbConnect(plutoDbR::Pluto(),
             database="NORWAY:StockVizUs2:R",
             backendServer="mssql",
             server=config.webservice)
}


model.common.con.StockVizDyn <- function() {
   dbConnect(plutoDbR::Pluto(),
             database="SWEDEN:StockVizDyn:R",
             backendServer="postgres",
             server=config.webservice)
}

model.common.con.StockVizBeka <- function() {
   dbConnect(plutoDbR::Pluto(),
             database="WINDOWS:StockVizBeka:R",
             backendServer="postgres",
             server=config.webservice)
}
