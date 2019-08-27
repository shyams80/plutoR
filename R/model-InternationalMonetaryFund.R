#' International Monetary Fund
#'
#' @references
#' \url{https://www.imf.org}
#'
#' Read the python documentation for information on the data-attributes \url{https://plutopy.readthedocs.io/en/latest/InternationalMonetaryFund.html}
#'
#' Sample notebook: \url{https://github.com/shyams80/plutons/blob/master/docs-R/InternationalMonetaryFund.ipynb}
#'
#' @export InternationalMonetaryFund
#' @exportClass InternationalMonetaryFund

InternationalMonetaryFund <- setRefClass('InternationalMonetaryFund',
  fields = c("connUs"),
  methods = list(
    initialize = function(){
      .self$connUs <- model.common.con.StockVizUs()
    },
    Meta = function(){
      "Query IMF meta-data based on geography/indicator. Then use the ID obtained here to query the time-series"

      return(tbl(.self$connUs, 'IMF_META') %>%
               select(ID, AREA_CODE, AREA, DATA_KEY, DATA_DESCRIPTION,
                      FREQ, UNIT_MEASURE, UNIT_MULT, START_YEAR, END_YEAR))
    },
    TimeSeries = function(){
      "Query the IMF time-series data based on the Meta ID"

      return(tbl(.self$connUs, 'IMF_OBSERVATION') %>%
               select(ID = SERIES_ID,
                      YEAR = DATE_Y, MONTH = DATE_M,
                      VALUE = VAL))
    }
  ))
