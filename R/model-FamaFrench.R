#' FamaFrench
#'
#' @references
#' \url{http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/index.html}
#'
#' Read the python documentation for information on the data-attributes \url{https://plutopy.readthedocs.io/en/latest/FamaFrench.html}
#'
#' Sample notebook: \url{https://github.com/shyams80/plutons/blob/master/docs-R/FamaFrench.ipynb}
#'
#' @export FamaFrench
#' @exportClass FamaFrench

FamaFrench <- setRefClass('FamaFrench',
  fields = c("connUs2"),
  methods = list(
   initialize = function(){
     .self$connUs2 <- model.common.con.StockVizUs2()
   },
   FiveFactor3x2Daily = function(){
     "Query the Fama-French 5-factor daily returns (http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/Data_Library/f-f_5_factors_2x3.html)"

     return(tbl(.self$connUs2, 'FAMA_FRENCH_5_FACTOR_DAILY') %>%
              select(TIME_STAMP, KEY_ID, RET))
   },
   Industry49Daily = function(){
     "Query the Fama-French daily returns of 49 different industries (http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/Data_Library/det_49_ind_port.html)"

     return(tbl(.self$connUs2, 'FAMA_FRENCH_INDUSTRY_49_DAILY') %>%
              select(TIME_STAMP, KEY_ID, RET_TYPE, RET))
   },
   MomentumDaily = function(){
     "Query the Fama-French daily returns of momentum factor and portfolios"

     #factor: https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/Data_Library/det_mom_factor_daily.html
     #portfolios: https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/Data_Library/det_10_port_form_pr_12_2_daily.html

     return(tbl(.self$connUs2, 'FAMA_FRENCH_MOMENTUM_DAILY') %>%
              select(TIME_STAMP, KEY_ID, RET_TYPE, RET))
   },
   MomentumMonthly = function(){
     "Query the Fama-French monthly returns of momentum factor and portfolios"

     #factor: https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/Data_Library/det_mom_factor.html
     #portfolios: https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/Data_Library/det_10_port_form_pr_12_2.html

     return(tbl(.self$connUs2, 'FAMA_FRENCH_MOMENTUM_MONTHLY') %>%
              select(TIME_STAMP, KEY_ID, RET_TYPE, RET))
   }

  ))
