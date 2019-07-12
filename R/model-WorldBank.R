#' World Bank Global Economic Monitor data
#'
#' @references
#' \url{https://worldbank.org}
#'
#' Read the python documentation for information on the data-attributes \url{https://plutopy.readthedocs.io/en/latest/WorldBank.html}
#'
#' Sample notebook: \url{https://github.com/shyams80/plutons/blob/master/docs-R/WorldBank.ipynb}
#'
#' @export WorldBank
#' @exportClass WorldBank

WorldBank <- setRefClass('WorldBank',
  fields = c("conn"),
  methods = list(
   initialize = function(){
     .self$conn <- model.common.con.StockVizUs()
   },
   Meta = function(){
     "Query to find the country and indicator id's of the Global Economic Monitor data published by the World Bank"

     return(tbl(.self$conn, 'WORLD_BANK_META') %>%
              select(COUNTRY_ID, COUNTRY_NAME, INDICATOR_ID, INDICATOR_NAME, COUNTRY_KEY = C_ID, INDICATOR_KEY = I_ID, START_YEAR = SY, END_YEAR = EY))
   },
   TimeSeries = function(){
     "Query the Global Economic Monitor data the World Bank"

     return(tbl(.self$conn, 'WORLD_BANK_OBSERVATION') %>%
              select(COUNTRY_KEY = COUNTRY_ID, INDICATOR_KEY = INDICATOR_ID, YEAR, VALUE))
   }

  ))
