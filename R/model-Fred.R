source("r/model-common.R")

#' St. Louis Fed FRED cache
#'
#' @references \url{https://fred.stlouisfed.org/}
#'
#' @param SERIES_ID integer, use this to query the time-series
#' @param TICKER string, FRED id
#' @param NAME string, title
#' @param FREQUENCY string, 'D' for day, 'M' for month, 'Q' for quarter, etc.
#' @param UNITS string, 'Miles', 'Million of Dollars', etc.
#' @param SEASON_ADJUST string, 'SA' for seasonally adjusted, etc.
#' @param TIME_STAMP date
#' @param VAL numeric
#'
#' @examples
#' library(dbplyr)
#' library(dplyr)
#' library(odbc)
#' library(plutoR)
#' options("scipen"=999)
#'
#' # get all series with the name 'India ' in it with the first and last dates
#' # for which time-series data are available
#' fred<-Fred()
#' indianFred <- fred$Meta() %>% inner_join(fred$TimeSeries(), by = 'SERIES_ID') %>%
#'     filter(NAME %like% '%India %') %>%
#'     group_by(SERIES_ID, TICKER, NAME) %>%
#'     summarize(MIN_TS = min(TIME_STAMP), MAX_TS = max(TIME_STAMP)) %>%
#'     select(SERIES_ID, TICKER, NAME, MIN_TS, MAX_TS)
#'
#' print(data.frame(indianFred))
#'
#' # get a sample of one of the time-series
#' fred$TimeSeries() %>% filter(SERIES_ID == -2147478748, TIME_STAMP >= as.Date('2019-01-01')) %>%
#'     arrange(desc(TIME_STAMP)) %>%
#'     head(5) %>%
#'     print()
#'
#' @import methods
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

