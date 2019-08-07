library(dbplyr)
library(dplyr)
library(odbc)
library(plutoR)
options("scipen"=999)
source("../R/config.R")

indices<-Indices()

# fetch the last 10 day India VIX levels

indices$IndiaVixTimeSeries() %>%
  top_n(10, wt=TIME_STAMP) %>%
  print(n=Inf)

#fetch the latest rates across tenors

maxDt <- (indices$IndiaGsecTimeSeries() %>%
            summarize(MAX_TS = max(TIME_STAMP)) %>%
            collect())$MAX_TS[1]

indices$IndiaGsecTimeSeries() %>%
  filter(TIME_STAMP == maxDt) %>%
  arrange(NAME) %>%
  print()

#get all total-return NSE indices for the latest time_stamp

maxDtNse <- (indices$NseTimeSeries() %>% summarize(MAX_TS = max(TIME_STAMP)) %>% collect())$MAX_TS[1]
indices$NseTimeSeries() %>%
  group_by(NAME) %>%
  filter(TIME_STAMP == maxDtNse && NAME %like% '% TR%') %>%
  select(NAME) %>%
  print(n = 10)

#get start and end dates for all total-return NSE indices

indices$NseTimeSeries() %>%
  group_by(NAME) %>%
  filter(NAME %like% '% TR%') %>%
  summarize(ST=min(TIME_STAMP), ET=max(TIME_STAMP)) %>%
  print(n = 10)

#get all BSE indices for the latest time_stamp

maxDtBse <- (indices$BseTimeSeries() %>% summarize(MAX_TS = max(TIME_STAMP)) %>% collect())$MAX_TS[1]
indices$BseTimeSeries() %>%
  group_by(NAME) %>%
  filter(TIME_STAMP == maxDtBse) %>%
  select(NAME) %>%
  print(n = 10)

#fetch the latest NSE NIFTY 50 constituents

maxDt <- (indices$NseConstituents() %>%
            filter(NAME == "NIFTY 50") %>%
            summarize(MAX_TS = max(TIME_STAMP)) %>%
            collect())$MAX_TS[1]

indices$NseConstituents() %>%
  filter(TIME_STAMP == maxDt & NAME == "NIFTY 50") %>%
  print(n = 10)

#fetch the latest BSE SENSEX constituents

maxDt <- (indices$BseConstituents() %>%
            filter(NAME == "sp bse sensex") %>%
            summarize(MAX_TS = max(TIME_STAMP)) %>%
            collect())$MAX_TS[1]

indices$BseConstituents() %>%
  filter(TIME_STAMP == maxDt & NAME == "sp bse sensex") %>%
  print(n = 10)

#fetch index date ranges published on yahoo finance

indices$YahooFinanceTimeSeries() %>%
  group_by(NAME) %>%
  summarize(ST = min(TIME_STAMP), ET = max(TIME_STAMP)) %>%
  arrange(NAME) %>%
  print(n=Inf)

# show data-ranges for Fama-french factors

indices$FamaFrench5Factor3x2Daily() %>%
  group_by(KEY_ID) %>%
  summarize(ST = min(TIME_STAMP), ET = max(TIME_STAMP)) %>%
  arrange(KEY_ID) %>%
  print(n=Inf)


# show data-ranges for Fama-french industry daily returns

indices$FamaFrenchIndustry49Daily() %>%
  group_by(KEY_ID) %>%
  summarize(ST = min(TIME_STAMP), ET = max(TIME_STAMP)) %>%
  arrange(ST) %>%
  print(n=Inf)
