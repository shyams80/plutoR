#' Commodity Futures and Options
#'
#' @references
#' \url{https://www.mcxindia.com/}
#' \url{https://www.ncdex.com/}
#' \url{https://www.cmegroup.com/}
#'
#' Read the python documentation for information on the data-attributes \url{https://plutopy.readthedocs.io/en/latest/CommodityFuturesAndOptions.html}
#'
#' Sample notebook: \url{https://github.com/shyams80/plutons/blob/master/docs-R/CommodityFuturesAndOptions.ipynb}
#'
#'
#' @export CommodityFuturesAndOptions
#' @exportClass CommodityFuturesAndOptions

CommodityFuturesAndOptions <- setRefClass('CommodityFuturesAndOptions',
  fields = c("conn"),
  methods = list(
    initialize = function(){
      .self$conn <- model.common.con.StockViz()
    },
    CmeEod = function(){
      "Query the end-of-day prices of commodity futures contracts traded on the COMEX and NYMEX"

      return (tbl(.self$conn, 'CME_BHAV') %>%
                select(CONTRACT, TIME_STAMP, PRODUCT_SYMBOL, PRODUCT_DESCRIPTION,
                       CONTRACT_MONTH, CONTRACT_YEAR, CONTRACT_DAY,
                       HIGH = PX_HIGH, LOW = PX_LOW, OPEN = PX_OPEN, LAST = PX_LAST, SETTLE,
                       VOLUME))
    },
    McxEod = function(){
      "Query the end-of-day prices of commodity contracts traded on the MCX"

      return (tbl(.self$conn, 'BHAV_COM_MCX') %>%
                select(CONTRACT, TIME_STAMP, EXPIRY, EXPIRY_SERIES, OTYPE, STRIKE,
                       HIGH = PX_HIGH, LOW = PX_LOW, OPEN = PX_OPEN, CLOSE = PX_CLOSE,
                       VOLUME, VOL, VOL_UNITS, VALUE, OI))
    },
    NcdexEod = function(){
      "Query the end-of-day prices of commodity contracts traded on the NCDEX"

      return (tbl(.self$conn, 'BHAV_COM_NCDEX') %>%
                select(CONTRACT = SYMBOL, TIME_STAMP, EXPIRY, EXPIRY_SERIES,
                       COMMODITY, DELIVERY_CENTRE,
                       HIGH = H, LOW = L, OPEN = O, CLOSE = C,
                       PRICE_UNIT, TRADED_QTY, MEASURE,
                       TRADED_NUM, TRADED_VAL = TRADED_VAL_LAKHS, OI, LAST_TRADE = LAST_TRADE_DT))
    }
  ))
