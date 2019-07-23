#' Currencies
#'
#' @references
#' \url{https://nseindia.com/}
#' \url{https://www.alphavantage.co}
#'
#' Read the python documentation for information on the data-attributes \url{https://plutopy.readthedocs.io/en/latest/Currencies.html}
#'
#' Sample notebook: \url{https://github.com/shyams80/plutons/blob/master/docs-R/Currencies.ipynb}
#'
#'
#' @export Currencies
#' @exportClass Currencies

Currencies <- setRefClass('Currencies',
  fields = c("conn", "connBeka"),
  methods = list(
   initialize = function(){
     .self$conn <- model.common.con.StockViz()
     .self$connBeka <- model.common.con.StockVizBeka()
   },
   NseFuturesTimeSeries = function(){
     "Query the currency futures time-series published by the NSE"

     return(tbl(.self$conn, 'BHAV_CUR_FUT') %>%
              select(TIME_STAMP, SYMBOL, EXPIRY = EXPIRY_DT,
                     HIGH = PX_HIGH, LOW = PX_LOW, OPEN = PX_OPEN, CLOSE = PX_CLOSE, SETTLE = PX_SETTLE,
                     CONTRACTS = TRADED_CONTRACTS, VALUE = TRADED_VAL, OI = OI_CONTRACTS))
   },
   NseOptionsTimeSeries = function(){
     "Query the currency option time-series published by the NSE"

     return(tbl(.self$conn, 'BHAV_CUR_OPT') %>%
              select(TIME_STAMP, SYMBOL, EXPIRY, STRIKE, OTYPE = OPTION_TYPE,
                     HIGH = PX_HIGH, LOW = PX_LOW, OPEN = PX_OPEN, CLOSE = PX_CLOSE, SETTLE = PX_SETTLE,
                     CONTRACTS = TRATED_CONTRACTS, VALUE = NOTIONAL_VALUE, OI = OI_CONTRACTS))
   },
   AvEodTimeSeries = function(){
     "Query the end-of-day currency USD-fx time-series published by AlphaVantage"

     return(tbl(.self$connBeka, 'av_fx_usd_daily_ts') %>%
              select(TIME_STAMP = time_stamp, SYMBOL = curr_code,
                     HIGH = px_high, LOW = px_low, OPEN = px_open, CLOSE = px_close))
   },
   Av30minTimeSeries = function(){
     "Query the 30-min bar of currency USD-fx time-series published by AlphaVantage"

     return(tbl(.self$connBeka, 'av_fx_usd_30min_ts') %>%
              select(TIME_STAMP = time_stamp, SYMBOL = curr_code,
                     HIGH = px_high, LOW = px_low, OPEN = px_open, CLOSE = px_close))
   }
  ))
