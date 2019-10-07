library(DBI)
library(plutoDbR)
library(plutoR)
library(tidyverse)

options("scipen"=999)
source("../R/config.R")

indices<-Indices()

# fetch the last 10 day India VIX levels

print("running...")
indices$IndiaVixTimeSeries() %>%
  top_n(10, wt=TIME_STAMP) %>%
  print(n=Inf)

# if top_n doesn't work, use arrange %>% head
indices$IndiaVixTimeSeries() %>%
  arrange(desc(TIME_STAMP)) %>%
  head(10) %>%
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

# fetch index date ranges published by Barclays

indices$BarclaysMeta() %>%
  inner_join(indices$BarclaysTimeSeries()) %>%
  group_by(FAMILY, NAME) %>%
  summarize(ST = min(TIME_STAMP), ET = max(TIME_STAMP)) %>%
  select(FAMILY, NAME, ST, ET) %>%
  arrange(FAMILY) %>%
  print(n = Inf)

# fetch index date ranges published by Wilshire

indices$WilshireMeta() %>%
  inner_join(indices$WilshireTimeSeries()) %>%
  group_by(NAME) %>%
  summarize(ST = min(TIME_STAMP), ET = max(TIME_STAMP)) %>%
  select(NAME, ST, ET) %>%
  arrange(ST) %>%
  print(n = Inf)
