#' Indices
#'
#' @references
#' \url{https://nseindia.com/}
#' \url{https://bseindia.com/}
#' \url{https://www.ccilindia.com}
#' \url{https://finance.yahoo.com/}
#' \url{http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/index.html}
#'
#' Read the python documentation for information on the data-attributes \url{https://plutopy.readthedocs.io/en/latest/Indices.html}
#'
#' Sample notebook: \url{https://github.com/shyams80/plutons/blob/master/docs-R/Indices.ipynb}
#'
#' @export Indices
#' @exportClass Indices

Indices <- setRefClass('Indices',
   fields = c("conn", "connUs2"),
   methods = list(
     initialize = function(){
       .self$conn <- model.common.con.StockViz()
       .self$connUs2 <- model.common.con.StockVizUs2()
     },
     IndiaVixTimeSeries = function(){
        "Query the India VIX time-series data published by the NSE"

        return(tbl(.self$conn, 'VIX_HISTORY') %>%
         select(TIME_STAMP, HIGH = PX_HIGH, LOW = PX_LOW, OPEN = PX_OPEN, CLOSE = PX_CLOSE))
     },
     IndiaGsecTimeSeries = function(){
        "Query the Indian Government Soverign Bond index time-series published by the CCIL"

        return(tbl(.self$conn, 'INDEX_CCIL_TENOR') %>%
         select(NAME = INDEX_NAME, TIME_STAMP, TRI, PRI, COUPON, YTM, DURATION))
     },
     NseTimeSeries = function(){
       "Query the index time-series published by the NSE"

       return(tbl(.self$conn, 'BHAV_INDEX') %>%
         select(NAME = INDEX_NAME, TIME_STAMP, HIGH = PX_HIGH, LOW = PX_LOW, OPEN = PX_OPEN, CLOSE = PX_CLOSE, VOLUME = TRD_QTY))
     },
     NseConstituents = function(){
        "Query the latest constituents of NSE indices"

        return(tbl(.self$conn, 'INDEX_NSE_3') %>%
         select(NAME = INDEX_NAME, TIME_STAMP, SYMBOL, INDUSTRY, CAP_WEIGHT))
     },
     BseTimeSeries = function(){
       "Query the index time-series published by the BSE"

       return(tbl(.self$conn, 'BHAV_INDEX_BSE') %>%
         select(NAME = INDEX_NAME, TIME_STAMP, HIGH = PX_HIGH, LOW = PX_LOW, OPEN = PX_OPEN, CLOSE = PX_CLOSE))
     },
     BseConstituents = function(){
        "Query the latest constituents of BSE indices"

        return(tbl(.self$conn, 'INDEX_BSE2') %>%
         select(NAME = INDEX_NAME, TIME_STAMP = INDEX_DATE, CODE = SECURITY_CODE, SYMBOL = NSE_SYMBOL, SECURITY_NAME))
     },
     YahooFinanceTimeSeries = function(){
        "Query the index time-series published by Yahoo Finance"

        return(tbl(.self$connUs2, 'BHAV_YAHOO') %>%
         select(NAME = SYMBOL, TIME_STAMP, HIGH = H, LOW = L, OPEN = O, CLOSE = C, CLOSE_ADJ = AC, VOLUME = V))
     },
     FamaFrench5Factor3x2Daily = function(){
       "Query the Fama-French 5-factor daily returns (http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/Data_Library/f-f_5_factors_2x3.html)"

       return(tbl(.self$connUs2, 'FAMA_FRENCH_5_FACTOR_DAILY') %>%
                select(TIME_STAMP, KEY_ID, DAILY_RETURN))
     },
     FamaFrenchIndustry49Daily = function(){
       "Query the Fama-French daily returns of 49 different industries (http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/Data_Library/det_49_ind_port.html)"

       return(tbl(.self$connUs2, 'FAMA_FRENCH_INDUSTRY_49_DAILY') %>%
                select(TIME_STAMP, KEY_ID, DAILY_RETURN))
     },
     FamaFrenchMomentumDaily = function(){
       "Query the Fama-French daily returns of momentum factor and portfolios"

       #factor: https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/Data_Library/det_mom_factor_daily.html
       #portfolios: https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/Data_Library/det_10_port_form_pr_12_2_daily.html

       return(tbl(.self$connUs2, 'FAMA_FRENCH_MOMENTUM_DAILY') %>%
                select(TIME_STAMP, KEY_ID, DAILY_RETURN))
     }
  ))
