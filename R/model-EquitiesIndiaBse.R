#' Equities India BSE
#'
#' @references
#' \url{https://bseindia.com/}
#'
#' Read the python documentation for information on the data-attributes \url{https://plutopy.readthedocs.io/en/latest/EquitiesIndiaBse.html}
#'
#' Sample notebook: \url{https://github.com/shyams80/plutons/blob/master/docs-R/EquitiesIndiaBse.ipynb}
#'
#'
#' @export EquitiesIndiaBse
#' @exportClass EquitiesIndiaBse

EquitiesIndiaBse <- setRefClass('EquitiesIndiaBse',
  fields = c("conn"),
  methods = list(
    initialize = function(){
      .self$conn <- model.common.con.StockViz()
    },
    Tickers = function(){
      "Query meta data of listed equity tickers"

      return(tbl(.self$conn, 'EQUITY_TICKER_BSE') %>%
               select(ISIN, CODE = SC_CODE, SYMBOL = SC_ID, SERIES = SC_GROUP, NAME = SC_NAME, FACE = FACE_VALUE, INDUSTRY))
    },
    MiscInfo = function(){
      "Query miscellaneous information of listed equity tickers"

      return(tbl(.self$conn, 'EQUITY_MISC_INFO_BSE') %>%
               select(CODE = SC_CODE, TIME_STAMP, FF_MKT_CAP_CR, FULL_MKT_CAP_CR, D2T_PCT))
    },
    EodTimeSeries = function(){
      "Query unadjusted end-of-day price and volume time-series for listed stocks"

      return(tbl(.self$conn, 'BSE_PX_HISTORY') %>%
               select(CODE = SC_CODE, NAME = SC_NAME, SERIES = SC_GROUP, TYPE = SC_TYPE, TIME_STAMP,
                      HIGH = PX_HIGH, LOW = PX_LOW, OPEN = PX_OPEN, CLOSE = PX_CLOSE,
                      LAST = PX_LAST, VOLUME = NO_OF_SHRS,
                      NUM_TRADES = NO_TRADES, TURNOVER = NET_TURNOV))
    },
    CorporateResults = function(){
      "Query to CorporateResults for a specific period and stock"

      return(tbl(.self$conn, 'CORP_RESULTS_KV_BSE') %>%
               select(CODE = SC_CODE, PERIOD_BEGIN, PERIOD_END, IS_AUDITED, H1 = HEADER, KEY = K, VALUE = V))
    }
  ))
