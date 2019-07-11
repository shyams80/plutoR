#' Indices
#'
#' @references
#' \url{https://nseindia.com/}
#' \url{https://bseindia.com/}
#' \url{https://www.ccilindia.com}
#' \url{https://finance.yahoo.com/}
#'
#' Read the python documentation for information on the data-attributes \url{https://plutopy.readthedocs.io/en/latest/Indices.html}
#'
#' Sample notebook: \url{https://github.com/shyams80/plutons/blob/master/docs-R/Indices.ipynb}
#'
#' @export Indices
#' @exportClass Indices

Indices <- setRefClass('Indices',
   fields = c("conn", "connUs2"),
   methods = list(
     initialize = function(){
       .self$conn <- model.common.con.StockViz()
       .self$connUs2 <- model.common.con.StockVizUs2()
     },
     IndiaVixTimeSeries = function(){
        "Query the India VIX time-series data published by the NSE"

        return(tbl(.self$conn, 'VIX_HISTORY') %>%
         select(TIME_STAMP, HIGH = PX_HIGH, LOW = PX_LOW, OPEN = PX_OPEN, CLOSE = PX_CLOSE))
     },
     IndiaGsecTimeSeries = function(){
        "Query the Indian Government Soverign Bond index time-series published by the CCIL"

        return(tbl(.self$conn, 'INDEX_CCIL_TENOR') %>%
         select(NAME = INDEX_NAME, TIME_STAMP, TRI, PRI, COUPON, YTM, DURATION))
     },
     NseTimeSeries = function(){
       "Query the index time-series published by the NSE"

       return(tbl(.self$conn, 'BHAV_INDEX') %>%
         select(NAME = INDEX_NAME, TIME_STAMP, HIGH = PX_HIGH, LOW = PX_LOW, OPEN = PX_OPEN, CLOSE = PX_CLOSE, VOLUME = TRD_QTY))
     },
     NseConstituents = function(){
        "Query the latest constituents of NSE indices"

        return(tbl(.self$conn, 'INDEX_NSE_3') %>%
         select(NAME = INDEX_NAME, TIME_STAMP, SYMBOL, INDUSTRY, CAP_WEIGHT))
     },
     BseTimeSeries = function(){
       "Query the index time-series published by the BSE"

       return(tbl(.self$conn, 'BHAV_INDEX_BSE') %>%
         select(NAME = INDEX_NAME, TIME_STAMP, HIGH = PX_HIGH, LOW = PX_LOW, OPEN = PX_OPEN, CLOSE = PX_CLOSE))
     },
     BseConstituents = function(){
        "Query the latest constituents of BSE indices"

        return(tbl(.self$conn, 'INDEX_BSE2') %>%
         select(NAME = INDEX_NAME, TIME_STAMP = INDEX_DATE, CODE = SECURITY_CODE, SYMBOL = NSE_SYMBOL, SECURITY_NAME))
     },
     YahooFinanceTimeSeries = function(){
        "Query the index time-series published by Yahoo Finance"

        return(tbl(.self$connUs2, 'BHAV_YAHOO') %>%
         select(NAME = SYMBOL, TIME_STAMP, HIGH = H, LOW = L, OPEN = O, CLOSE = C, CLOSE_ADJ = AC, VOLUME = V))
     }
  ))
