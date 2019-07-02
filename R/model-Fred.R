#' St. Louis Fed FRED cache
#'
#' @references \url{https://fred.stlouisfed.org/}
#'
#' Read the python documentation for information on the data-attributes \url{https://plutopy.readthedocs.io/en/latest/Fred.html}
#'
#' Sample notebook: \url{https://github.com/shyams80/plutons/blob/master/docs-R/Fred.ipynb}
#'
#' @export Fred
#' @exportClass Fred

Fred <- setRefClass('Fred',
  fields = c("conn"),
  methods = list(
    initialize = function(){
      .self$conn <- model.common.con.StockVizUs()
    },
    Meta = function(){
      "Query the FRED meta-data cache"

      return (tbl(.self$conn, 'FRED_SERIES') %>%
                select(SERIES_ID = ID, TICKER = SERIES_ID, NAME = TITLE, FREQUENCY = FREQ, UNITS, SEASON_ADJUST))
    },
    TimeSeries = function(){
      "Query the FRED time-series cache"

      return (tbl(.self$conn, 'FRED_OBSERVATION') %>%
                select(SERIES_ID, TIME_STAMP, VAL))
    }
  ))

