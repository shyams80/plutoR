#' Equities India NSE
#'
#' @references
#' \url{https://nseindia.com/}
#'
#' Read the python documentation for information on the data-attributes \url{https://plutopy.readthedocs.io/en/latest/EquitiesIndiaNse.html}
#'
#' Sample notebook: \url{https://github.com/shyams80/plutons/blob/master/docs-R/EquitiesIndiaNse.ipynb}
#'
#'
#' @export EquitiesIndiaNse
#' @exportClass EquitiesIndiaNse

EquitiesIndiaNse <- setRefClass('EquitiesIndiaNse',
  fields = c("conn", "connDyn"),
  methods = list(
    initialize = function(){
      .self$conn <- model.common.con.StockViz()
      .self$connDyn <- model.common.con.StockVizDyn()
    },
    Tickers = function(){
      "Query meta data of listed equity tickers"

      return(tbl(.self$conn, 'EQUITY_TICKER') %>%
               select(ISIN, SYMBOL, SERIES, NAME, DATE_LISTING, PAID_UP, FACE, MARKET_LOT))
    },
    MiscInfo = function(){
      "Query miscellaneous information of listed equity tickers"

      return(tbl(.self$conn, 'EQUITY_MISC_INFO') %>%
               select(SYMBOL, TIME_STAMP, FF_MKT_CAP_CR, D2T_PCT, LOWER_PX_BAND, UPPER_PX_BAND))
    },
    MarketCapDecile = function(){
      "Query market-cap decile of of listed equity tickers"

      return(tbl(.self$conn, 'DECILE_CONSTITUENTS') %>%
               select(SYMBOL, TIME_STAMP, DECILE))
    },
    EodTimeSeries = function(){
      "Query unadjusted end-of-day price and volume time-series for listed stocks"

      return(tbl(.self$conn, 'PX_HISTORY') %>%
               select(SYMBOL, SERIES, TIME_STAMP,
                      HIGH = PX_HIGH, LOW = PX_LOW, OPEN = PX_OPEN, CLOSE = PX_CLOSE,
                      LAST = PX_LAST, VOLUME = TOT_TRD_QTY))
    },
    EodAdjustedTimeSeries = function(){
      "Query end-of-day price and volume time-series adjusted for splits, bonus and dividends for listed stocks"

      return(tbl(.self$connDyn, 'eod_adjusted_nse') %>%
               select(SYMBOL = ticker, TIME_STAMP = date_stamp,
                      HIGH = h, LOW = l, OPEN = o, CLOSE = c, VOLUME = v))
    },
    DailyReturns = function(){
      "Query the percentage daily return (close-to-close) time-series for listed stocks"

      return(tbl(.self$conn, 'RETURN_SERIES_ALL') %>%
               select(SYMBOL, TIME_STAMP, VALUE = DAILY_RETURN))
    },
    CorporateActions = function(){
      "Query the corporate actions for listed stocks"

      return(tbl(.self$conn, 'CORP_ACTION') %>%
               select(SYMBOL, SERIES, EX_DATE, PURPOSE, WHEN_UPDATED = UPDATE_DT))
    },
    CorporateEvents = function(){
      "Query the corporate events for listed stocks"

      return(tbl(.self$conn, 'CORP_RESULTS_DATE') %>%
               select(SYMBOL, DISC_DATE, PURPOSE = TITLE, EVENT_DATE = BM_DATE))
    },
    CorporateResultsMeta = function(){
      "Query to obtain the REF_ID to lookup CorporateResults for a specific period"

      return(tbl(.self$conn, 'CORP_RESULTS_KEY_NSE') %>%
               select(REF_ID = AUTO_ID, SYMBOL, IS_AUDITED, IS_CUMULATIVE, IS_CONSOLIDATED,
                      PERIOD_BEGIN, PERIOD_END, PERIOD = PERIOD_KEY,
                      BROADCAST_DATE = BROADCAST_STAMP))
    },
    CorporateResults = function(){
      "Query to CorporateResults for a specific period and stock"

      return(tbl(.self$conn, 'CORP_RESULTS_QTR_NSE') %>%
               select(REF_ID, H1, H2, H3, H4, KEY = K, VALUE = V))
    },
    ShareholdingPatternRaw = function(){
      "Query and parse Share-holding patterns"

      return(tbl(.self$conn, 'SHARE_HOLDING_PATTERN2') %>%
               select(SYMBOL, TIME_STAMP = AS_OF, VALUE, KEY))
    }
  ))
