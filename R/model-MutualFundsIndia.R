#' Amfi India mutual-fund cache
#'
#' @references \url{https://amfiindia.com/}
#'
#' Read the python documentation for information on the data-attributes \url{https://plutopy.readthedocs.io/en/latest/MutualFundsIndia.html}
#'
#' Sample notebook: \url{}
#'
#' @export MutualFundsIndia
#' @exportClass MutualFundsIndia

MutualFundsIndia <- setRefClass('MutualFundsIndia',
  fields = c("conn"),
  methods = list(
    initialize = function(){
      .self$conn <- model.common.con.StockViz()
    },
    Meta = function(){
      "Query the meta-data"

      return (tbl(.self$conn, 'MF_META2') %>%
                select(SCHEME_CODE, AS_OF, BENCH_ORIG, BENCH_NOW, CATEGORY, EXPENSE, EXPENSE_RATIO, TURNOVER_RATIO))
    },
    AumFundwise = function(){
      "Query the fund-wise assets under management (AUM) of different asset managers"

      return (tbl(.self$conn, 'MF_FUNDWISE_AUM') %>%
                select(PERIOD, FUND, AVG_AUM_WO_FOFD, AVG_AUM_FOFD))
    },
    AumSchemewise = function(){
      "Query the scheme-wise assets under management (AUM) of different asset managers and their 'schemes'"

      return (tbl(.self$conn, 'MF_SCHEMEWISE_AUM') %>%
                select(PERIOD, SCHEME_CODE, SCHEME_NAME, AVG_AUM_WO_FOFD, AVG_AUM_FOFD))
    },
    NavTimeSeries = function(){
      "Query for the NAVs of different funds"

      return (tbl(.self$conn, 'MF_NAV_HISTORY') %>%
                select(SCHEME_CODE, SCHEME_NAME, TIME_STAMP = AS_OF, NAV))
    },
    Portfolio = function(){
      "Query for the monthly reported portfolios of different funds"

      return (tbl(.self$conn, 'MF_PORTFOLIO_HISTORY') %>%
                select(SCHEME_CODE, PORTFOLIO_DATE, INSTRUMENT, INSTRUMENT_TYPE, SYMBOL, NAME, SECTOR, WEIGHTAGE))
    }
  ))

