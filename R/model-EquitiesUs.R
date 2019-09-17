#' Equities US
#'
#' @references
#' \url{https://iexcloud.io}
#' \url{https://www.sec.gov/}
#'
#' Read the python documentation for information on the data-attributes \url{https://plutopy.readthedocs.io/en/latest/EquitiesUs.html}
#'
#' Sample notebook: \url{https://github.com/shyams80/plutons/blob/master/docs-R/EquitiesUs.ipynb}
#'
#'
#' @export EquitiesUs
#' @exportClass EquitiesUs

EquitiesUs <- setRefClass('EquitiesUs',
  fields = c("conn"),
  methods = list(
    initialize = function(){
      .self$conn <- model.common.con.StockVizUs2()
    },
    Tickers = function(){
      "Query meta data of listed equity (common stock) tickers"

      return(tbl(.self$conn, 'EQUITY_TICKER_US') %>%
               select(SYMBOL, NAME = CO_NAME, EXCHANGE = EXCH, MKT_CAP))
    },
    EodAdjustedTimeSeries = function(){
      "Query end-of-day price and volume time-series adjusted for splits, bonus and dividends for listed stocks"

      return(tbl(.self$conn, 'BHAV_EQ_TD') %>%
               select(SYMBOL, TIME_STAMP, HIGH = H, LOW = L, OPEN = O, CLOSE = C, VOLUME = V))
    },
    SecMeta = function(){
      "Meta information of companies in the SEC EDGAR database. Useful for SIC."

      return(tbl(.self$conn, 'SEC_META') %>%
               select(SYMBOL = TICKER, NAME, CIK, SIC, SIC_DESC))
    },
    SecFilings = function(){
      "Links to SEC filings. Useful to keep track of M&A events in your portfolio"

      return(tbl(.self$conn, 'SEC_FILINGS') %>%
               select(ACC_NO, SYMBOL = TICKER, FILING_DATE, FILING_URL, FILING_TYPE, FORM_NAME))
    }
))
