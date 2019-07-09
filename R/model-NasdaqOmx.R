#' NasdaqOmx Indices
#'
#' @references
#' \url{https://indexes.nasdaqomx.com/}
#' \url{https://www.quandl.com/}
#'
#' Read the python documentation for information on the data-attributes \url{https://plutopy.readthedocs.io/en/latest/NasdaqOmx.html}
#'
#' Sample notebook: \url{https://github.com/shyams80/plutons/blob/master/docs-R/NasdaqOmx.ipynb}
#'
#' @export NasdaqOmx
#' @exportClass NasdaqOmx

NasdaqOmx <- setRefClass('NasdaqOmx',
  fields = c("conn"),
  methods = list(
   initialize = function(){
     .self$conn <- model.common.con.StockVizUs2()
   },
   Meta = function(){
     "Query to find the time-series id of total-return indices published by the NasdaqOmx"

     return(tbl(.self$conn, 'NASDAQOMX_META') %>%
              select(ID, CODE = DATASET_CODE, NAME = INDEX_NAME))
   },
   TimeSeries = function(){
     "Query the index time-series published by the NasdaqOmx"

     return(tbl(.self$conn, 'QUANDL_DATA_V3') %>%
              select(ID, TIME_STAMP = TRADE_DATE, CLOSE = INDEX_VALUE))
   }

  ))
