library(dbplyr)
library(dplyr)
library(odbc)
library(RPostgres)
library(plutoR)
options("scipen"=999)
source("../R/config.R")

currencies <- Currencies()

# get traded futures pairs

print("traded futures pairs:")

currencies$NseFuturesTimeSeries() %>%
  group_by(SYMBOL) %>%
  summarize(START_DT = min(TIME_STAMP), END_DT = max(TIME_STAMP)) %>%
  arrange(START_DT) %>%
  print()

# get the latest USDINR option chain for the nearest expiry

print("latest USDINR option chain for the nearest expiry:")

maxDt <- (currencies$NseOptionsTimeSeries() %>%
            summarize(MAX_DT = max(TIME_STAMP)) %>%
            collect())$MAX_DT[[1]]

expiryDt <- (currencies$NseOptionsTimeSeries() %>%
            filter(TIME_STAMP == maxDt & SYMBOL == 'USDINR') %>%
            summarize(MAX_DT = max(EXPIRY)) %>%
            collect())$MAX_DT[[1]]

currencies$NseOptionsTimeSeries() %>%
  filter(TIME_STAMP == maxDt & SYMBOL == 'USDINR' & EXPIRY == expiryDt) %>%
  arrange(STRIKE, OTYPE) %>%
  print()

# get the currencies tracked by AlphaVantage end-of-day

print("AlphaVantage end-of-day pairs:")

currencies$AvEodTimeSeries() %>%
  group_by(SYMBOL) %>%
  summarize(START_DT = min(TIME_STAMP), END_DT = max(TIME_STAMP)) %>%
  arrange(START_DT) %>%
  print(n=Inf)

# get the currencies tracked by AlphaVantage 30-min bars

print("AlphaVantage 30-min bars:")

currencies$Av30minTimeSeries() %>%
  group_by(SYMBOL) %>%
  summarize(START_DT = min(TIME_STAMP), END_DT = max(TIME_STAMP), COUNT = n()) %>%
  arrange(START_DT) %>%
  print(n=Inf)


