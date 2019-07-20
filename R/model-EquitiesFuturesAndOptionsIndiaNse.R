#' Equities Futures and Options traded on the NSE
#'
#' @references
#' \url{https://nseindia.com/}
#'
#' Read the python documentation for information on the data-attributes \url{https://plutopy.readthedocs.io/en/latest/EquitiesFuturesAndOptionsIndiaNse.html}
#'
#' Sample notebook: \url{https://github.com/shyams80/plutons/blob/master/docs-R/EquitiesFuturesAndOptionsIndiaNse.ipynb}
#'
#'
#' @export EquitiesFuturesAndOptionsIndiaNse
#' @exportClass EquitiesFuturesAndOptionsIndiaNse

EquitiesFuturesAndOptionsIndiaNse <- setRefClass('EquitiesFuturesAndOptionsIndiaNse',
  fields = c("conn"),
  methods = list(
    initialize = function(){
      .self$conn <- model.common.con.StockViz()
    },
    FuturesEodTimeSeries = function(){
      "Query the end-of-day prices of equity futures contracts traded on the NSE"

      return (tbl(.self$conn, 'BHAV_EQ_FUT') %>%
                select(TIME_STAMP, SYMBOL, EXPIRY = EXPIRY_DT,
                       HIGH = PX_HIGH, LOW = PX_LOW, OPEN = PX_OPEN, CLOSE = PX_CLOSE, SETTLE = PX_SETTLE,
                       CONTRACTS, VALUE = VAL_IN_LAKH, OI = OPEN_INTEREST))
    },
    OptionsEodTimeSeries = function(){
      "Query the end-of-day prices of equity options contracts traded on the NSE"

      return (tbl(.self$conn, 'BHAV_EQ_OPT') %>%
                select(TIME_STAMP, SYMBOL, EXPIRY = EXPIRY_DT, STRIKE = STRIKE_PR, OTYPE = OPTION_TYP,
                       HIGH = PX_HIGH, LOW = PX_LOW, OPEN = PX_OPEN, CLOSE = PX_CLOSE, SETTLE = PX_SETTLE,
                       CONTRACTS, VALUE = VAL_IN_LAKH, OI = OPEN_INTEREST))
    },
    OptionGreeks = function(){
      "Query the end-of-day option greeks of equity options contracts traded on the NSE"

      return (tbl(.self$conn, 'EQ_OPTION_GREEKS') %>%
                select(TIME_STAMP, SYMBOL, EXPIRY = EXPIRY_DATE, STRIKE, OTYPE = OPTION_TYPE,
                       MODEL_PRICE = MODEL_PX, DELTA, THETA, VEGA, RHO, LAMBDA, GAMMA, IV, TTM, RATE, SIGMA))
    },
    LotSize = function(){
      "Query the lot-size of equity futures and options contracts traded on the NSE"

      return (tbl(.self$conn, 'MKT_LOT') %>%
                select(SYMBOL, CONTRACT, LOT_SIZE))
    }
  ))
