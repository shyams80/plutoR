library(dbplyr)
library(dplyr)
library(odbc)
library(plutoR)
options("scipen"=999)
source("../R/config.R")

fred<-Fred()

# get all series with the name 'India ' in it with the first and last dates for which time-series data are available

indianFred <- fred$Meta() %>% inner_join(fred$TimeSeries(), by = 'SERIES_ID') %>%
  filter(NAME %like% '%India %') %>%
  group_by(SERIES_ID, TICKER, NAME) %>%
  summarize(MIN_TS = min(TIME_STAMP), MAX_TS = max(TIME_STAMP)) %>%
  select(SERIES_ID, TICKER, NAME, MIN_TS, MAX_TS) %>%
  print(n=Inf)

# get a sample of one of the time-series

fred$TimeSeries() %>% filter(SERIES_ID == -2147478748, TIME_STAMP >= as.Date('2019-01-01')) %>%
  arrange(desc(TIME_STAMP)) %>%
  head(5) %>%
  print()
