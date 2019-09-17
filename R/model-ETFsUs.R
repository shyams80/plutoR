#' ETFs listed in the US
#'
#' Read the python documentation for information on the data-attributes \url{https://plutopy.readthedocs.io/en/latest/ETFsUs.html}
#'
#' Sample notebook: \url{https://github.com/shyams80/plutons/blob/master/docs-R/ETFsUs.ipynb}
#'
#' @export ETFsUs
#' @exportClass ETFsUs

ETFsUs <- setRefClass('ETFsUs',
  fields = c("conn"),
  methods = list(
    initialize = function(){
      .self$conn <- model.common.con.StockViz()
    },
    Meta = function(){
      "Query the meta-data"

      return (tbl(.self$conn, 'ETF_META_V') %>%
               select(SYMBOL, NAME = FUND, LAUNCH_DATE, ISSUER, EXPENSE_RATIO, AUM,
                      ASSET_CLASS, SEGMENT, UNDERLYING_INDEX))
    }
))
