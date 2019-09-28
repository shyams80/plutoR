library(DBI)
library(plutoDbR)
library(plutoR)
library(tidyverse)

options(tibble.width = Inf)
options("scipen" = 99999)
source("../R/config.R")

equitiesIndiaBse <- EquitiesIndiaBse()
symbol <- 'SBIN'

#get BSE's code for a symbol

secInfo <- equitiesIndiaBse$Tickers() %>%
           filter(SYMBOL == symbol) %>%
           collect()

secInfo %>% print()

code <- secInfo$CODE[[1]]

# fetch some "misc" info

miscDate <- (equitiesIndiaBse$MiscInfo() %>%
    filter(CODE == code) %>%
    summarize(MAX_DT = max(TIME_STAMP)) %>%
    collect())$MAX_DT[[1]]

print("latest misc info: ")
equitiesIndiaBse$MiscInfo() %>%
  filter(TIME_STAMP == miscDate & CODE == code) %>%
  print(n = Inf)

# fetch the latest end-of-day prices

maxDt <- (equitiesIndiaBse$EodTimeSeries() %>%
            summarize(MAX_DT = max(TIME_STAMP)) %>%
            collect())$MAX_DT[[1]]

print("latest end-of-day prices:")
equitiesIndiaBse$EodTimeSeries() %>%
  filter(TIME_STAMP == maxDt & CODE == code) %>%
  print()


# fetch the last 10 day EOD prices for State Bank of India equity

print("last 10 day EOD prices:")
equitiesIndiaBse$EodTimeSeries() %>%
  filter(CODE == code) %>%
  arrange(desc(TIME_STAMP)) %>%
  head(10) %>%
  print(n=Inf)

# fetch the last 24 quarter EPS for State Bank of India

print("the last 24 quarter EPS: ")
refs <- equitiesIndiaBse$CorporateResults() %>%
  filter(CODE == code & KEY %like% '%diluted%' & KEY %like% '%after%') %>%
  arrange(desc(PERIOD_END)) %>%
  collect() %>%
  mutate(PERIOD_END = as.Date(PERIOD_END), PERIOD_BEGIN = as.Date(PERIOD_BEGIN)) %>%
  mutate(P_DIFF = PERIOD_END-PERIOD_BEGIN) %>%
  filter(P_DIFF < 100) %>%
  head(24)

refs %>% print(n=Inf)
