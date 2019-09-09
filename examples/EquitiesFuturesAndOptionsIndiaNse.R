library(DBI)
library(plutoDbR)
library(plutoR)
library(tidyverse)

options("scipen"=999)
source("../R/config.R")

eqFo <- EquitiesFuturesAndOptionsIndiaNse()

# get all NIFTY futures contract traded right now

print("NIFTY futures contract traded right now")

endDt <- (eqFo$FuturesEodTimeSeries() %>%
            summarize(MAX_TS = max(TIME_STAMP)) %>%
            collect())$MAX_TS[1]

eqFo$FuturesEodTimeSeries() %>%
  filter(SYMBOL == "NIFTY" & TIME_STAMP == endDt) %>%
  print()

# get all NIFTY option contracts at the nearest expiry traded right now

print("NIFTY option contracts at the nearest expiry traded right now")

endDt <- (eqFo$OptionsEodTimeSeries() %>%
            summarize(MAX_TS = max(TIME_STAMP)) %>%
            collect())$MAX_TS[1]

expiry <- (eqFo$OptionsEodTimeSeries() %>%
             filter(SYMBOL == "NIFTY" & TIME_STAMP == endDt) %>%
             summarize(MIN_TS = min(EXPIRY)) %>%
             collect())$MIN_TS[1]

eqFo$OptionsEodTimeSeries() %>%
  filter(SYMBOL == "NIFTY" & TIME_STAMP == endDt
         & EXPIRY == expiry & as.integer(STRIKE) %% 100 == 0) %>%
  arrange(STRIKE, OTYPE) %>%
  print()

# get all greeks for the NIFTY option contracts at the nearest expiry traded right now

print("greeks for the NIFTY option contracts at the nearest expiry traded right now")

endDt <- (eqFo$OptionGreeks() %>%
            summarize(MAX_TS = max(TIME_STAMP)) %>%
            collect())$MAX_TS[1]

expiry <- (eqFo$OptionGreeks() %>%
             filter(SYMBOL == "NIFTY" & TIME_STAMP == endDt) %>%
             summarize(MIN_TS = min(EXPIRY)) %>%
             collect())$MIN_TS[1]

eqFo$OptionGreeks() %>%
  filter(SYMBOL == "NIFTY" & TIME_STAMP == endDt
         & EXPIRY == expiry & as.integer(STRIKE) %% 100 == 0) %>%
  arrange(STRIKE, OTYPE) %>%
  print()

# get NIFTY's lot-sizes at different expiries

print("NIFTY's lot-sizes at different expiries")

futureDate <- as.Date(Sys.Date() + 30*3)

eqFo$LotSize() %>%
  filter(SYMBOL == "NIFTY" & CONTRACT <= futureDate) %>%
  arrange(desc(CONTRACT)) %>%
  head(15) %>%
  print()


