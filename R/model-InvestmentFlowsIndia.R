#' Investment Flows India
#'
#' @references
#' \url{https://cdslindia.com/}
#' \url{https://www.sebi.gov.in}
#'
#' Read the python documentation for information on the data-attributes \url{https://plutopy.readthedocs.io/en/latest/InvestmentFlowsIndia.html}
#'
#' Sample notebook: \url{https://github.com/shyams80/plutons/blob/master/docs-R/InvestmentFlowsIndia.ipynb}
#'
#'
#' @export InvestmentFlowsIndia
#' @exportClass InvestmentFlowsIndia

InvestmentFlowsIndia <- setRefClass('InvestmentFlowsIndia',
  fields = c("conn"),
  methods = list(
    initialize = function(){
      .self$conn <- model.common.con.StockViz()
    },
    DiiCashMarket = function(){
      "Query purchases and sales of debt and equity by Domestic Institutional Investors"

      return(tbl(.self$conn, 'DII_MKT_FLOW') %>%
               select(TIME_STAMP = AsOf, SECURITY_TYPE = SecType,
                      BUY_VALUE = Purchases, SELL_VALUE = Sales))
    },
    DiiDerivativesMarket = function(){
      "Query purchases and sales of futures and options by Domestic Institutional Investors"

      return(tbl(.self$conn, 'DII_DERIV_FLOW') %>%
               select(TIME_STAMP = AsOf, SECURITY_TYPE = DerivProduct,
                      BUY_CONTRACTS = BuyContracts, BUY_VALUE = BuyAmount,
                      SELL_CONTRACTS = SellContracts, SELL_VALUE = SellAmount,
                      OI_CONTRACTS = OIContracts, OI_VALUE = OIAmount))
    },
    FiiCashMarket = function(){
      "Query purchases and sales of debt and equity by Foreign Institutional Investors"

      return(tbl(.self$conn, 'FII_MKT_FLOW') %>%
               select(TIME_STAMP = AsOf, SECURITY_TYPE = SecType, ROUTE = Route,
                      BUY_VALUE = Purchases, SELL_VALUE = Sales,
                      NET_VALUE_DLR = NetDlr, CONVERSION_RATE_USDINR = ConverionRate))
    },
    FiiDerivativesMarket = function(){
      "Query purchases and sales of futures and options by Foreign Institutional Investors"

      return(tbl(.self$conn, 'FII_DERIV_FLOW') %>%
               select(TIME_STAMP = AsOf, SECURITY_TYPE = DerivProduct,
                      BUY_CONTRACTS = BuyContracts, BUY_VALUE = BuyAmount,
                      SELL_CONTRACTS = SellContracts, SELL_VALUE = SellAmount,
                      OI_CONTRACTS = OIContracts, OI_VALUE = OIAmount))
    }
))
