#' Yield curves
#'
#' @references
#' \url{https://www.ccilindia.com}
#' \url{http://treasury.gov}
#' \url{https://www.ecb.europa.eu}
#'
#' Read the python documentation for information on the data-attributes \url{https://plutopy.readthedocs.io/en/latest/YieldCurve.html}
#'
#' Sample notebook: \url{https://github.com/shyams80/plutons/blob/master/docs-R/YieldCurve.ipynb}
#'
#' @export YieldCurve
#' @exportClass YieldCurve

YieldCurve <- setRefClass('YieldCurve',
  fields = c("conn"),
  methods = list(
   initialize = function(){
     .self$conn <- model.common.con.StockViz()
   },
   IndiaZeroCoupon = function(){
     "Query the Indian Zero Coupon Yield Curve published by CCIL"

     return(tbl(.self$conn, 'ZERO_COUPON_CURVE') %>%
              select(TIME_STAMP, MATURITY, YIELD))
   },
   UsTreasury = function(){
     "Query the Daily Treasury Yield Curve Rates published by US Treasury"

     return(tbl(.self$conn, 'UST_YIELD_CURVE') %>%
              select(TIME_STAMP, M1, M3, M6, Y1, Y2, Y3, Y5, Y7, Y10, Y20, Y30))
   },
   EuroArea = function(){
     "Query Euro area yield curves published by the ECB"

     return(tbl(.self$conn, 'EUR_YIELD_CURVE') %>%
              select(CURVE_ID, TIME_STAMP, TENOR_Y, TENOR_M, VALUE = VAL))
   }
  ))
