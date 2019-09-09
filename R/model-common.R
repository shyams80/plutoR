model.common.con.StockViz <- function() {
   dbConnect(plutoDbR::Pluto(),
             serverId="NORWAY:StockViz",
             backendServer="mssql",
             host=config.redis.server,
             password=config.redis.password,
             db=1)
}

model.common.con.StockVizUs <- function() {
   dbConnect(plutoDbR::Pluto(),
             serverId="NORWAY:StockVizUs",
             backendServer="mssql",
             host=config.redis.server,
             password=config.redis.password,
             db=2)
}

model.common.con.StockVizUs2 <- function() {
   dbConnect(plutoDbR::Pluto(),
             serverId="NORWAY:StockVizUs2",
             backendServer="mssql",
             host=config.redis.server,
             password=config.redis.password,
             db=3)
}


model.common.con.StockVizDyn <- function() {
   dbConnect(plutoDbR::Pluto(),
             serverId="SWEDEN:StockVizDyn",
             backendServer="postgres",
             host=config.redis.server,
             password=config.redis.password,
             db=4)
}

model.common.con.StockVizBeka <- function() {
   dbConnect(plutoDbR::Pluto(),
             serverId="WINDOWS:StockVizBeka",
             backendServer="postgres",
             host=config.redis.server,
             password=config.redis.password,
             db=5)
}
