library(DBI)
library(plutoDbR)
library(plutoR)
library(tidyverse)

options("scipen"=999)
source("../R/config.R")

yc <- YieldCurve()

#fetch the latest India Zero Coupon Bond yields

endDt <- (yc$IndiaZeroCoupon() %>%
  summarize(MAX_TS = max(TIME_STAMP)) %>%
  collect())$MAX_TS[1]

yc$IndiaZeroCoupon() %>%
  filter(TIME_STAMP == endDt) %>%
  arrange(MATURITY) %>%
  print(n=Inf)

#fetch the latest US Treasury Yield Curve

endDt <- (yc$UsTreasury() %>%
  summarize(MAX_TS = max(TIME_STAMP)) %>%
  collect())$MAX_TS[1]

yc$UsTreasury() %>%
  filter(TIME_STAMP == endDt) %>%
  print()

#fetch the latest Euro area yield curve

endDt <- (yc$EuroArea() %>%
            summarize(MAX_TS = max(TIME_STAMP)) %>%
            collect())$MAX_TS[1]

yc$EuroArea() %>%
  inner_join(yc$EuroArea(), by=c('TENOR_Y', 'TENOR_M', 'TIME_STAMP')) %>%
  filter(TIME_STAMP == endDt & CURVE_ID.x == 'G_N_A' & CURVE_ID.y == 'G_N_C') %>%
  select(TENOR_Y, TENOR_M, GNA = VALUE.x, GNC = VALUE.y) %>%
  arrange(TENOR_Y, TENOR_M) %>%
  print(n=Inf)
