#' Indices
#'
#' @references
#' \url{https://nseindia.com/}
#' \url{https://bseindia.com/}
#'
#' Read the python documentation for information on the data-attributes \url{https://plutopy.readthedocs.io/en/latest/Indices.html}
#'
#' Sample notebook: \url{https://github.com/shyams80/plutons/blob/master/docs-R/Indices.ipynb}
#'
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
