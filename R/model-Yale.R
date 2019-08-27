#' Yale/Shiller
#'
#' @references
#' \url{http://www.econ.yale.edu/~shiller/data.htm}
#'
#' Read the python documentation for information on the data-attributes \url{https://plutopy.readthedocs.io/en/latest/Yale.html}
#'
#' Sample notebook: \url{https://github.com/shyams80/plutons/blob/master/docs-R/Yale.ipynb}
#'
#' @export Yale
#' @exportClass Yale

Yale <- setRefClass('Yale',
  fields = c("connUs2"),
  methods = list(
    initialize = function(){
      .self$connUs2 <- model.common.con.StockVizUs2()
    },
    Confidence = function(){
      "Query Stock Market Confidence Indexes produced by the Yale School of Management. (https://svz.bz/2NzetU3)"

      return(tbl(.self$connUs2, 'YALE_CONFIDENCE') %>%
               select(NAME = INDEX_NAME, TIME_STAMP, VALUE = VAL, STD_ERR))
    },
    SP500 = function(){
      "Query the monthly stock price, dividends, and earnings data and the consumer price index."

      return(tbl(.self$connUs2, 'YALE_SPCOMP') %>%
               select(TIME_STAMP,
                      CLOSE = VAL, CLOSE_REAL = VAL_REAL,
                      DIVIDEND, DIVIDEND_REAL,
                      EARNINGS, EARNINGS_REAL,
                      CPI, LONG_IR, CAPE))
    }
))
