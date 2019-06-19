source("r/model-common.R")

#' Indices
#'
#' @references
#' \url{https://nseindia.com/}
#' \url{https://bseindia.com/}
#'
#' @param NAME string, name of the index. Use this to query the time-series
#' @param TIME_STAMP date
#' @param HIGH numeric, nullable
#' @param LOW numeric, nullable
#' @param OPEN numeric, nullable
#' @param CLOSE numeric
#' @param VOLUME numeric, nullable
#'
#' @examples
#' library(dbplyr)
#' library(dplyr)
#' library(odbc)
#' library(plutoR)
#' options("scipen"=999)
#'
#' # get all NSE indices for the latest time_stamp
#' indices<-Indices()
#' maxDt <- (indices$NseTimeSeries() %>% summarize(MAX_TS = max(TIME_STAMP)) %>% collect())$MAX_TS[1]
#' indices$NseTimeSeries() %>%
#'      group_by(NAME) %>%
#'      filter(TIME_STAMP == maxDt) %>%
#'      select(NAME) %>%
#'      print(n = Inf)
#'
#' @import methods
#' @export Indices
#' @exportClass Indices

Indices <- setRefClass('Indices',
   fields = c("conn"),
   methods = list(
     initialize = function(){
       .self$conn <- model.common.con.StockViz()
     },
     NseTimeSeries = function(){
       "Query the index time-series published by the NSE"

       return(tbl(.self$conn, 'BHAV_INDEX') %>%
         select(NAME = INDEX_NAME, TIME_STAMP = TIME_STAMP, HIGH = PX_HIGH, LOW = PX_LOW, OPEN = PX_OPEN, CLOSE = PX_CLOSE, VOLUME = TRD_QTY))
     },
     BseTimeSeries = function(){
       "Query the index time-series published by the BSE"

       return(tbl(.self$conn, 'BHAV_INDEX_BSE') %>%
         select(NAME = INDEX_NAME, TIME_STAMP = TIME_STAMP, HIGH = PX_HIGH, LOW = PX_LOW, OPEN = PX_OPEN, CLOSE = PX_CLOSE))
     }
  ))
