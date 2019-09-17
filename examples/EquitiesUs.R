library(DBI)
library(plutoDbR)
library(plutoR)
library(tidyverse)

options("scipen"=999)
source("../R/config.R")

usEquities <- EquitiesUs()

# last 10 days of AAPL stock prices

usEquities$EodAdjustedTimeSeries() %>%
  filter(SYMBOL == "AAPL") %>%
  arrange(desc(TIME_STAMP)) %>%
  head(10) %>%
  print(n=Inf)


# biggest 20 listed stocks

usEquities$Tickers() %>%
  arrange(desc(MKT_CAP)) %>%
  head(20) %>%
  print(n=Inf)

# M&A in the last 90 days

cutoff <- Sys.Date() - 90

usEquities$Tickers() %>%
  inner_join(usEquities$SecMeta(), by = c('SYMBOL')) %>%
  inner_join(usEquities$SecFilings(), by = c('SYMBOL')) %>%
  filter(FILING_DATE >= cutoff & (FILING_TYPE == 'DEFM14A' | FILING_TYPE == 'SC14D9C')) %>%
  select(SYMBOL, NAME.x, SIC_DESC, FILING_DATE, FILING_TYPE) %>%
  arrange(desc(MKT_CAP)) %>%
  print(n=Inf)
